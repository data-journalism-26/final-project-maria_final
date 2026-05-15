install.packages(c("osmextract", "sf", "dplyr", "stringr", "readr"))

library(osmextract)
library(sf)
library(dplyr)
library(stringr)
library(readr)

# Download/read Mississippi OSM extract
ms_points <- oe_get(
  "Mississippi",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

# Filter convenience stores + gas stations
ms_food_retail <- ms_points |>
  mutate(
    shop = str_match(other_tags, '"shop"=>"([^"]+)"')[, 2],
    amenity = str_match(other_tags, '"amenity"=>"([^"]+)"')[, 2],
    brand = str_match(other_tags, '"brand"=>"([^"]+)"')[, 2],
    operator = str_match(other_tags, '"operator"=>"([^"]+)"')[, 2]
  ) |>
  filter(
    shop == "convenience" |
      amenity == "fuel"
  ) |>
  mutate(
    category = case_when(
      shop == "convenience" & amenity == "fuel" ~ "gas_station_with_convenience_store",
      shop == "convenience" ~ "convenience_store",
      amenity == "fuel" ~ "gas_station",
      TRUE ~ "other"
    ),
    likely_sells_food = shop == "convenience" |
      str_detect(
        str_to_lower(paste(name, brand, operator, sep = " ")),
        "mart|market|food|convenience|7-eleven|circle k|shell|exxon|chevron|bp|marathon|valero|speedway"
      )
  ) |>
  select(
    osm_id, name, brand, operator,
    category, shop, amenity, likely_sells_food,
    geometry
  )

nrow(ms_food_retail)

# Save for analysis
st_write(ms_food_retail, "mississippi_convenience_gas.geojson", delete_dsn = TRUE)
write_csv(st_drop_geometry(ms_food_retail), "mississippi_convenience_gas.csv")



#TEXAS

tx_points <- oe_get(
  "Texas",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

tx_food_retail <- tx_points |>
  mutate(
    shop = str_match(other_tags, '"shop"=>"([^"]+)"')[, 2],
    amenity = str_match(other_tags, '"amenity"=>"([^"]+)"')[, 2],
    brand = str_match(other_tags, '"brand"=>"([^"]+)"')[, 2],
    operator = str_match(other_tags, '"operator"=>"([^"]+)"')[, 2]
  ) |>
  filter(
    shop == "convenience" |
      amenity == "fuel"
  ) |>
  mutate(
    category = case_when(
      shop == "convenience" & amenity == "fuel" ~ "gas_station_with_convenience_store",
      shop == "convenience" ~ "convenience_store",
      amenity == "fuel" ~ "gas_station",
      TRUE ~ "other"
    ),
    chain = case_when(
      !is.na(brand) ~ brand,
      TRUE ~ name
    ),
    chain = str_to_title(chain),
    likely_sells_food = shop == "convenience" |
      str_detect(
        str_to_lower(paste(name, brand, operator, sep = " ")),
        "mart|market|food|convenience|7-eleven|circle k|shell|exxon|chevron|bp|marathon|valero|speedway|buc-ee|casey's|love's|pilot|flying j"
      )
  ) |>
  select(
    osm_id, name, chain, brand, operator,
    category, shop, amenity, likely_sells_food,
    geometry
  )

nrow(tx_food_retail)

texas_mapbox <- tx_food_retail |>
  select(osm_id, name, chain, category, likely_sells_food, geometry)

st_write(
  texas_mapbox,
  "tx_mapbox_food_retail.geojson",
  delete_dsn = TRUE
)



#CALIFORNIA

ca_points <- oe_get(
  "California",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

ca_food_retail <- ca_points |>
  mutate(
    shop = str_match(other_tags, '"shop"=>"([^"]+)"')[, 2],
    amenity = str_match(other_tags, '"amenity"=>"([^"]+)"')[, 2],
    brand = str_match(other_tags, '"brand"=>"([^"]+)"')[, 2],
    operator = str_match(other_tags, '"operator"=>"([^"]+)"')[, 2]
  ) |>
  filter(
    shop == "convenience" |
      amenity == "fuel"
  ) |>
  mutate(
    category = case_when(
      shop == "convenience" & amenity == "fuel" ~ "gas_station_with_convenience_store",
      shop == "convenience" ~ "convenience_store",
      amenity == "fuel" ~ "gas_station",
      TRUE ~ "other"
    ),
    chain = case_when(
      !is.na(brand) ~ brand,
      TRUE ~ name
    ),
    chain = str_to_title(chain),
    likely_sells_food = shop == "convenience" |
      str_detect(
        str_to_lower(paste(name, brand, operator, sep = " ")),
        "mart|market|food|convenience|7-eleven|circle k|shell|exxon|chevron|bp|marathon|valero|speedway|buc-ee|casey's|love's|pilot|flying j"
      )
  ) |>
  select(
    osm_id, name, chain, brand, operator,
    category, shop, amenity, likely_sells_food,
    geometry
  )

nrow(ca_food_retail)

ca_mapbox <- ca_food_retail |>
  select(osm_id, name, chain, category, likely_sells_food, geometry)

st_write(
  ca_mapbox,
  "ca_mapbox_food_retail.geojson",
  delete_dsn = TRUE
)






#ALASKA

ak_points <- oe_get(
  "Alaska",
  provider = "geofabrik",
  layer = "points",
  quiet = FALSE
)

ak_food_retail <- ak_points |>
  mutate(
    shop = str_match(other_tags, '"shop"=>"([^"]+)"')[, 2],
    amenity = str_match(other_tags, '"amenity"=>"([^"]+)"')[, 2],
    brand = str_match(other_tags, '"brand"=>"([^"]+)"')[, 2],
    operator = str_match(other_tags, '"operator"=>"([^"]+)"')[, 2]
  ) |>
  filter(
    shop == "convenience" |
      amenity == "fuel"
  ) |>
  mutate(
    category = case_when(
      shop == "convenience" & amenity == "fuel" ~ "gas_station_with_convenience_store",
      shop == "convenience" ~ "convenience_store",
      amenity == "fuel" ~ "gas_station",
      TRUE ~ "other"
    ),
    chain = case_when(
      !is.na(brand) ~ brand,
      TRUE ~ name
    ),
    chain = str_to_title(chain),
    likely_sells_food = shop == "convenience" |
      str_detect(
        str_to_lower(paste(name, brand, operator, sep = " ")),
        "mart|market|food|convenience|7-eleven|circle k|shell|exxon|chevron|bp|marathon|valero|speedway|buc-ee|casey's|love's|pilot|flying j"
      )
  ) |>
  select(
    osm_id, name, chain, brand, operator,
    category, shop, amenity, likely_sells_food,
    geometry
  )

nrow(ak_food_retail)

ak_mapbox <- ak_food_retail |>
  select(osm_id, name, chain, category, likely_sells_food, geometry)

st_write(
  ak_mapbox,
  "ak_mapbox_food_retail.geojson",
  delete_dsn = TRUE
)
