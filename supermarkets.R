library(osmdata)
library(sf)
library(dplyr)
library(purrr)
library(geojsonio)
library(tigris)
library(leaflet)
options(tigris_use_cache = TRUE)

# Reload saved data
all_results <- readRDS("osm_progress.rds")

us_states <- states(cb = TRUE, year = 2022) |>
  filter(!STUSPS %in% c("PR", "VI", "GU", "MP", "AS"))



# ============================================================
# US Supermarkets - OSM scrape to GeoJSON for Mapbox
# ============================================================

library(osmdata)
library(sf)
library(dplyr)
library(purrr)
library(geojsonio)
library(tigris)
library(leaflet)
options(tigris_use_cache = TRUE)

# ---- 1. Define chains and get US states ----

chains <- c(
  "Walmart", "Kroger", "Albertsons", "Safeway", "Publix",
  "H-E-B", "Aldi", "Trader Joe's", "Whole Foods Market",
  "Costco", "Target", "Wegmans", "Meijer", "Food Lion",
  "Giant", "Stop & Shop", "ShopRite", "Winn-Dixie",
  "Sprouts Farmers Market", "Hy-Vee", "Save Mart", "Piggly Wiggly"
)

us_states <- states(cb = TRUE, year = 2022) |>
  filter(!STUSPS %in% c("PR", "VI", "GU", "MP", "AS"))

# ---- 2. Define the per-state query function ----

query_state <- function(state_geom, state_name) {
  message("Querying ", state_name, "...")
  bb <- st_bbox(state_geom)
  
  result <- tryCatch({
    opq(bbox = bb, timeout = 180) |>
      add_osm_feature(key = "shop", value = "supermarket") |>
      add_osm_feature(key = "brand", value = chains, value_exact = FALSE) |>
      osmdata_sf()
  }, error = function(e) {
    message("  Failed: ", e$message)
    return(NULL)
  })
  
  if (is.null(result)) return(NULL)
  
  pts <- result$osm_points
  polys <- result$osm_polygons
  
  features <- list()
  
  if (!is.null(pts) && nrow(pts) > 0 && "brand" %in% names(pts)) {
    pts <- pts |> filter(!is.na(brand))
    if (nrow(pts) > 0) features$points <- pts
  }
  
  if (!is.null(polys) && nrow(polys) > 0 && "brand" %in% names(polys)) {
    polys <- polys |> filter(!is.na(brand))
    if (nrow(polys) > 0) {
      polys_centroid <- suppressWarnings(st_centroid(polys))
      features$polys <- polys_centroid
    }
  }
  
  Sys.sleep(3)
  return(features)
}

# ---- 3. Loop through states with progress saving ----
# SKIP THIS IF you already have all_results saved.
# Reload with: all_results <- readRDS("osm_progress.rds")

all_results <- vector("list", nrow(us_states))
names(all_results) <- us_states$NAME

for (i in seq_len(nrow(us_states))) {
  all_results[[i]] <- query_state(
    st_geometry(us_states)[i],
    us_states$NAME[i]
  )
  if (i %% 10 == 0) saveRDS(all_results, "osm_progress.rds")
}
saveRDS(all_results, "osm_progress.rds")


# ============================================================
# ▼▼▼ START RE-RUNNING FROM HERE ▼▼▼
# ============================================================

# ---- 4. Flatten and combine into a single sf object ----

keep_cols <- c("osm_id", "name", "brand", "addr:housenumber",
               "addr:street", "addr:city", "addr:state", "addr:postcode",
               "opening_hours", "phone", "website")

extract_sf <- function(x) {
  if (is.null(x)) return(NULL)
  bind_rows(
    if (!is.null(x$points)) x$points |> select(any_of(keep_cols)) else NULL,
    if (!is.null(x$polys))  x$polys  |> select(any_of(keep_cols)) else NULL
  )
}

supermarkets <- map(all_results, extract_sf) |>
  compact() |>
  bind_rows() |>
  st_as_sf()

# ---- 5. Deduplicate (same brand at ~same coords = duplicate mapping) ----

supermarkets <- supermarkets |>
  mutate(
    lon = st_coordinates(geometry)[, 1],
    lat = st_coordinates(geometry)[, 2]
  ) |>
  distinct(brand, round(lon, 4), round(lat, 4), .keep_all = TRUE) |>
  select(-lon, -lat)

cat("After dedup:", nrow(supermarkets), "stores\n")

# ---- 6. Clean column names for Mapbox ----

supermarkets_clean <- supermarkets |>
  rename(
    housenumber = `addr:housenumber`,
    street      = `addr:street`,
    city        = `addr:city`,
    state       = `addr:state`,
    postcode    = `addr:postcode`,
    hours       = opening_hours
  ) |>
  mutate(
    address = paste(housenumber, street) |> trimws(),
    name = ifelse(is.na(name), brand, name)
  ) |>
  select(osm_id, brand, name, address, city, state, postcode,
         hours, phone, website)

# ---- 7. Spatial filter against actual US boundaries ----
#    (replaces the old rectangular bbox filter; excludes Canada, Mexico, Caribbean)

us_states_4326 <- st_transform(us_states, 4326)
us_boundary <- st_union(us_states_4326)

supermarkets_clean <- supermarkets_clean |>
  st_filter(us_boundary, .predicate = st_within)

cat("After US-boundary spatial filter:", nrow(supermarkets_clean), "stores\n")

# ---- 8. Drop non-supermarket brands ----

non_supermarket <- c(
  "DHL Poststation", "DPD Pickup Station", "Paczkomat InPost",
  "InPost", "Royal Mail", "Redbox", "Starbucks",
  "United Community Bank", "Planet"
)

supermarkets_clean <- supermarkets_clean |>
  filter(!brand %in% non_supermarket)

# ---- 9. Consolidate brand variants ----
# Note: Giant, Giant Eagle, Giant Food are SEPARATE chains — don't merge.

supermarkets_clean <- supermarkets_clean |>
  mutate(brand_clean = case_when(
    brand %in% c("Aldi", "Aldi Nord", "Aldi Süd", "Aldi;ALDI") ~ "Aldi",
    brand %in% c("Albertsons", "Albertsons Market") ~ "Albertsons",
    brand %in% c("H-E-B", "H-E-B plus!", "H-E-B Plus!") ~ "H-E-B",
    brand %in% c("Kroger", "Kroger Marketplace") ~ "Kroger",
    brand %in% c("Publix", "Publix GreenWise Market") ~ "Publix",
    brand %in% c("Walmart", "Walmart Neighborhood Market") ~ "Walmart",
    TRUE ~ brand
  )) |>
  select(osm_id, brand = brand_clean, brand_original = brand,
         name, address, city, state, postcode, hours, phone, website,
         geometry)

# ---- 10. Final check ----

cat("Final store count:", nrow(supermarkets_clean), "\n")
print(table(supermarkets_clean$brand))

st_crs(supermarkets_clean)
summary(st_coordinates(supermarkets_clean))

# ---- 11. Visual sanity check ----

leaflet(supermarkets_clean |> sample_n(2000)) |>
  addTiles() |>
  addCircleMarkers(radius = 2, color = "navy", popup = ~brand)

# ---- 12. Export GeoJSON for Mapbox ----

st_write(supermarkets_clean, "us_only_supermarkets.geojson",
         driver = "GeoJSON", delete_dsn = TRUE)

cat("Done. File written to us_only_supermarkets.geojson\n")
