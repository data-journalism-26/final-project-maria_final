install.packages(c("osmextract", "sf", "dplyr", "stringr", "readr"))

library(osmextract)
library(sf)
library(dplyr)
library(stringr)
library(readr)

extract_osm_tag <- function(x, tag) {
  str_match(x, paste0('"', tag, '"=>"([^"]+)"'))[, 2]
}

# =========================
# MISSISSIPPI
# =========================

ms_points <- oe_get(
  "Mississippi",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

ms_fast_food <- ms_points |>
  mutate(
    amenity = extract_osm_tag(other_tags, "amenity"),
    cuisine = extract_osm_tag(other_tags, "cuisine"),
    brand = extract_osm_tag(other_tags, "brand"),
    operator = extract_osm_tag(other_tags, "operator"),
    takeaway = extract_osm_tag(other_tags, "takeaway"),
    drive_through = extract_osm_tag(other_tags, "drive_through"),
    
    chain = case_when(
      !is.na(brand) ~ brand,
      !is.na(operator) ~ operator,
      TRUE ~ name
    ),
    
    chain = str_to_title(chain)
  ) |>
  
  filter(
    amenity == "fast_food" |
      (
        amenity == "restaurant" &
          str_detect(
            str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
            "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars"
          )
      )
  ) |>
  
  mutate(
    category = case_when(
      amenity == "fast_food" ~ "fast_food",
      amenity == "restaurant" ~ "chain_restaurant",
      TRUE ~ "other"
    ),
    
    likely_chain_fast_food = str_detect(
      str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
      "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars"
    )
  ) |>
  
  select(
    osm_id,
    name,
    chain,
    category,
    cuisine,
    takeaway,
    drive_through,
    likely_chain_fast_food,
    geometry
  )

st_write(
  ms_fast_food,
  "ms_mapbox_fast_food.geojson",
  delete_dsn = TRUE
)



# =========================
# TEXAS
# =========================

tx_points <- oe_get(
  "Texas",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

tx_fast_food <- tx_points |>
  mutate(
    amenity = extract_osm_tag(other_tags, "amenity"),
    cuisine = extract_osm_tag(other_tags, "cuisine"),
    brand = extract_osm_tag(other_tags, "brand"),
    operator = extract_osm_tag(other_tags, "operator"),
    takeaway = extract_osm_tag(other_tags, "takeaway"),
    drive_through = extract_osm_tag(other_tags, "drive_through"),
    
    chain = case_when(
      !is.na(brand) ~ brand,
      !is.na(operator) ~ operator,
      TRUE ~ name
    ),
    
    chain = str_to_title(chain)
  ) |>
  
  filter(
    amenity == "fast_food" |
      (
        amenity == "restaurant" &
          str_detect(
            str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
            "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars|in-n-out|raising cane"
          )
      )
  ) |>
  
  mutate(
    category = case_when(
      amenity == "fast_food" ~ "fast_food",
      amenity == "restaurant" ~ "chain_restaurant",
      TRUE ~ "other"
    ),
    
    likely_chain_fast_food = str_detect(
      str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
      "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars|in-n-out|raising cane"
    )
  ) |>
  
  select(
    osm_id,
    name,
    chain,
    category,
    cuisine,
    takeaway,
    drive_through,
    likely_chain_fast_food,
    geometry
  )

st_write(
  tx_fast_food,
  "tx_mapbox_fast_food.geojson",
  delete_dsn = TRUE
)



# =========================
# CALIFORNIA
# =========================

ca_points <- oe_get(
  "California",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

ca_fast_food <- ca_points |>
  mutate(
    amenity = extract_osm_tag(other_tags, "amenity"),
    cuisine = extract_osm_tag(other_tags, "cuisine"),
    brand = extract_osm_tag(other_tags, "brand"),
    operator = extract_osm_tag(other_tags, "operator"),
    takeaway = extract_osm_tag(other_tags, "takeaway"),
    drive_through = extract_osm_tag(other_tags, "drive_through"),
    
    chain = case_when(
      !is.na(brand) ~ brand,
      !is.na(operator) ~ operator,
      TRUE ~ name
    ),
    
    chain = str_to_title(chain)
  ) |>
  
  filter(
    amenity == "fast_food" |
      (
        amenity == "restaurant" &
          str_detect(
            str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
            "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars|in-n-out|del taco|el pollo loco"
          )
      )
  ) |>
  
  mutate(
    category = case_when(
      amenity == "fast_food" ~ "fast_food",
      amenity == "restaurant" ~ "chain_restaurant",
      TRUE ~ "other"
    ),
    
    likely_chain_fast_food = str_detect(
      str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
      "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|whataburger|five guys|chipotle|pizza hut|domino|little caesars|in-n-out|del taco|el pollo loco"
    )
  ) |>
  
  select(
    osm_id,
    name,
    chain,
    category,
    cuisine,
    takeaway,
    drive_through,
    likely_chain_fast_food,
    geometry
  )

st_write(
  ca_fast_food,
  "ca_mapbox_fast_food.geojson",
  delete_dsn = TRUE
)


# =========================
# ALASKA
# =========================

ak_points <- oe_get(
  "Alaska",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

ak_fast_food <- ak_points |>
  mutate(
    amenity = extract_osm_tag(other_tags, "amenity"),
    cuisine = extract_osm_tag(other_tags, "cuisine"),
    brand = extract_osm_tag(other_tags, "brand"),
    operator = extract_osm_tag(other_tags, "operator"),
    takeaway = extract_osm_tag(other_tags, "takeaway"),
    drive_through = extract_osm_tag(other_tags, "drive_through"),
    
    chain = case_when(
      !is.na(brand) ~ brand,
      !is.na(operator) ~ operator,
      TRUE ~ name
    ),
    
    chain = str_to_title(chain)
  ) |>
  
  filter(
    amenity == "fast_food" |
      (
        amenity == "restaurant" &
          str_detect(
            str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
            "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|five guys|pizza hut|domino"
          )
      )
  ) |>
  
  mutate(
    category = case_when(
      amenity == "fast_food" ~ "fast_food",
      amenity == "restaurant" ~ "chain_restaurant",
      TRUE ~ "other"
    ),
    
    likely_chain_fast_food = str_detect(
      str_to_lower(paste(name, brand, operator, cuisine, sep = " ")),
      "mcdonald|burger king|wendy|taco bell|kfc|subway|chick-fil-a|popeyes|sonic|arbys|five guys|pizza hut|domino"
    )
  ) |>
  
  select(
    osm_id,
    name,
    chain,
    category,
    cuisine,
    takeaway,
    drive_through,
    likely_chain_fast_food,
    geometry
  )

st_write(
  ak_fast_food,
  "ak_mapbox_fast_food.geojson",
  delete_dsn = TRUE
)
