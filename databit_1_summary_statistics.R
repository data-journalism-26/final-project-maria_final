# Food Desert Analysis Project
# Data source: USDA Food Access Research Atlas 2019

# Load packages
library(readxl)
library(dplyr)
library(ggplot2)

# Read in the data
food_data <- read_excel("FoodAccessResearchAtlasData2019.xlsx", 
                        sheet = "Food Access Research Atlas")

dim(food_data)
names(food_data)

# Food deserts = low income + low access (1 mile urban or 10 mile rural)
food_desert_tracts <- food_data %>%
  filter(LILATracts_1And10 == 1)


total_tracts <- nrow(food_data)
total_fd_tracts <- nrow(food_desert_tracts)
pct_fd_tracts <- (total_fd_tracts / total_tracts) * 100

#Food desert overview
cat("Total census tracts:", scales::comma(total_tracts), "\n")
cat("Food desert tracts:", scales::comma(total_fd_tracts), "\n")
cat("Percentage:", sprintf("%.1f%%", pct_fd_tracts), "\n\n")


# How many people live in food deserts
total_pop_affected <- sum(food_desert_tracts$Pop2010, na.rm = TRUE)
total_low_income_pop <- sum(food_desert_tracts$TractLOWI, na.rm = TRUE)
pct_low_income <- (total_low_income_pop / total_pop_affected) * 100

#Population affected
cat("Total population in food deserts:", scales::comma(total_pop_affected), "\n")
cat("Low-income population:", scales::comma(total_low_income_pop), "\n")
cat("Percentage low-income:", sprintf("%.1f%%", pct_low_income), "\n\n")


# Poverty rates comparison
avg_poverty_fd <- mean(food_desert_tracts$PovertyRate, na.rm = TRUE)
avg_poverty_all <- mean(food_data$PovertyRate, na.rm = TRUE)
poverty_difference <- avg_poverty_fd - avg_poverty_all
poverty_pct_higher <- (avg_poverty_fd / avg_poverty_all - 1) * 100

cat("Food desert poverty rate:", sprintf("%.1f%%", avg_poverty_fd), "\n")
cat("National poverty rate:", sprintf("%.1f%%", avg_poverty_all), "\n")
cat("Difference:", sprintf("+%.1f percentage points", poverty_difference), "\n")
cat("Percent higher:", sprintf("%.0f%%", poverty_pct_higher), "higher\n\n")


# Income comparison (num conversion, previous character)
median_income_fd <- median(as.numeric(food_desert_tracts$MedianFamilyIncome), na.rm = TRUE)
median_income_all <- median(as.numeric(food_data$MedianFamilyIncome), na.rm = TRUE)
income_gap <- median_income_all - median_income_fd

#Income stats
cat("Median income in food deserts:", scales::dollar(median_income_fd), "\n")
cat("National median income:", scales::dollar(median_income_all), "\n")
cat("Income gap:", scales::dollar(income_gap), "\n\n")


# Vehicle access
total_no_vehicle_hh <- sum(food_desert_tracts$TractHUNV, na.rm = TRUE)
pop_no_vehicle_low_access <- sum(as.numeric(food_desert_tracts$lahunv1), na.rm = TRUE)
pct_no_vehicle <- (pop_no_vehicle_low_access / total_pop_affected) * 100

cat("Households without vehicle:", scales::comma(total_no_vehicle_hh), "\n")
cat("People with low access AND no vehicle:", scales::comma(pop_no_vehicle_low_access), "\n")
cat("Percentage of food desert population:", sprintf("%.1f%%", pct_no_vehicle), "\n\n")


# SNAP (food stamps)
total_snap <- sum(food_desert_tracts$TractSNAP, na.rm = TRUE)
pct_snap <- (total_snap / total_pop_affected) * 100

cat("SNAP recipients in food deserts:", scales::comma(total_snap), "\n")
cat("Percentage of food desert population:", sprintf("%.1f%%", pct_snap), "\n\n")


# Demographics breakdown
total_white <- sum(food_desert_tracts$TractWhite, na.rm = TRUE)
total_black <- sum(food_desert_tracts$TractBlack, na.rm = TRUE)
total_hispanic <- sum(food_desert_tracts$TractHispanic, na.rm = TRUE)
total_asian <- sum(food_desert_tracts$TractAsian, na.rm = TRUE)

pct_white <- (total_white / total_pop_affected) * 100
pct_black <- (total_black / total_pop_affected) * 100
pct_hispanic <- (total_hispanic / total_pop_affected) * 100
pct_asian <- (total_asian / total_pop_affected) * 100

#Racial demographics
cat("White:", scales::comma(total_white), sprintf("(%.1f%%)", pct_white), "\n")
cat("Black:", scales::comma(total_black), sprintf("(%.1f%%)", pct_black), "\n")
cat("Hispanic:", scales::comma(total_hispanic), sprintf("(%.1f%%)", pct_hispanic), "\n")
cat("Asian:", scales::comma(total_asian), sprintf("(%.1f%%)", pct_asian), "\n\n")


# Urban vs rural split
urban_fd <- food_desert_tracts %>% filter(Urban == 1)
rural_fd <- food_desert_tracts %>% filter(Urban == 0)

urban_pop <- sum(urban_fd$Pop2010, na.rm = TRUE)
rural_pop <- sum(rural_fd$Pop2010, na.rm = TRUE)
pct_urban <- (urban_pop / total_pop_affected) * 100
pct_rural <- (rural_pop / total_pop_affected) * 100

cat("Urban food desert population:", scales::comma(urban_pop), sprintf("(%.1f%%)", pct_urban), "\n")
cat("Rural food desert population:", scales::comma(rural_pop), sprintf("(%.1f%%)", pct_rural), "\n\n")


summary_stats <- data.frame(
  metric = c(
    "total_fd_tracts",
    "pct_fd_tracts", 
    "total_pop_affected",
    "pct_low_income",
    "avg_poverty_fd",
    "median_income_fd",
    "median_income_gap",
    "pct_urban",
    "total_no_vehicle_hh",
    "total_snap",
    "pct_black",
    "pct_hispanic"
  ),
  value = c(
    total_fd_tracts,
    pct_fd_tracts,
    total_pop_affected,
    pct_low_income,
    avg_poverty_fd,
    median_income_fd,
    income_gap,
    pct_urban,
    total_no_vehicle_hh,
    total_snap,
    pct_black,
    pct_hispanic
  )
)

print(summary_stats)


#State breakdown 
state_summary <- food_desert_tracts %>%
  group_by(State) %>%
  summarise(
    food_desert_tracts = n(),
    total_population = sum(Pop2010, na.rm = TRUE),
    low_income_pop = sum(TractLOWI, na.rm = TRUE),
    avg_poverty_rate = mean(PovertyRate, na.rm = TRUE),
    median_income = median(as.numeric(MedianFamilyIncome), na.rm = TRUE),
    households_no_vehicle = sum(TractHUNV, na.rm = TRUE)
  ) %>%
  arrange(desc(total_population))

# Total tracts per state for percentages
state_totals <- food_data %>%
  group_by(State) %>%
  summarise(total_tracts = n())

state_summary <- state_summary %>%
  left_join(state_totals, by = "State") %>%
  mutate(
    pct_fd_tracts = (food_desert_tracts / total_tracts) * 100
  ) %>%
  select(State, food_desert_tracts, total_tracts, pct_fd_tracts, 
         total_population, low_income_pop, avg_poverty_rate, 
         median_income, households_no_vehicle)

#States ranked by population 
cat(paste(rep("=", 80), collapse=""), "\n\n")

for(i in 1:nrow(state_summary)) {
  cat(sprintf("%2d. %-20s | %s people | %s tracts (%.1f%%) | Poverty: %.1f%% | Income: %s\n",
              i,
              state_summary$State[i],
              scales::comma(state_summary$total_population[i]),
              scales::comma(state_summary$food_desert_tracts[i]),
              state_summary$pct_fd_tracts[i],
              state_summary$avg_poverty_rate[i],
              scales::dollar(state_summary$median_income[i])))
}

# Top 10 states with most people affected
cat(paste(rep("=", 80), collapse=""), "\n")
print(state_summary %>% 
        select(State, total_population, food_desert_tracts, pct_fd_tracts, avg_poverty_rate) %>%
        head(10))

# Which states have the biggest problem relative to their size
cat(paste(rep("=", 80), collapse=""), "\n")
state_by_pct <- state_summary %>%
  arrange(desc(pct_fd_tracts)) %>%
  select(State, pct_fd_tracts, food_desert_tracts, total_population, avg_poverty_rate) %>%
  head(10)
print(state_by_pct)


#Correlations for statistical significance
#Create dataset with all tracts grouped by state
state_analysis <- food_data %>%
  group_by(State) %>%
  summarise(
    total_tracts = n(),
    fd_tracts = sum(LILATracts_1And10 == 1, na.rm = TRUE),
    avg_poverty_rate = mean(PovertyRate, na.rm = TRUE),
    median_income = median(as.numeric(MedianFamilyIncome), na.rm = TRUE),
    pct_low_income = mean(LowIncomeTracts, na.rm = TRUE) * 100
  ) %>%
  mutate(
    pct_fd_tracts = (fd_tracts / total_tracts) * 100
  ) %>%
  filter(!is.na(median_income))

#food vs poverty
cat(paste(rep("=", 80), collapse=""), "\n\n")

#Food desert % vs poverty rate
cor_poverty <- cor(state_analysis$pct_fd_tracts, 
                   state_analysis$avg_poverty_rate, 
                   use = "complete.obs")

cat("   Correlation coefficient:", round(cor_poverty, 3), "\n")
#helper for interpretation
cat("   Interpretation:", 
    ifelse(abs(cor_poverty) > 0.7, "STRONG",
           ifelse(abs(cor_poverty) > 0.4, "MODERATE", "WEAK")),
    ifelse(cor_poverty > 0, "positive", "negative"), "correlation\n\n")

#Food desert % vs median income
cor_income <- cor(state_analysis$pct_fd_tracts, 
                  state_analysis$median_income, 
                  use = "complete.obs")

cat("   Correlation coefficient:", round(cor_income, 3), "\n")
cat("   Interpretation:", 
    ifelse(abs(cor_income) > 0.7, "STRONG",
           ifelse(abs(cor_income) > 0.4, "MODERATE", "WEAK")),
    ifelse(cor_income > 0, "positive", "negative"), "correlation\n\n")


# statistical significance test
poverty_test <- cor.test(state_analysis$pct_fd_tracts, 
                         state_analysis$avg_poverty_rate)
cat("  p-value:", format.pval(poverty_test$p.value), "\n")

income_test <- cor.test(state_analysis$pct_fd_tracts, 
                        state_analysis$median_income)
cat("  p-value:", format.pval(income_test$p.value), "\n")
                             

#linear regression models with interpertation helper

#M1: Can poverty rate predict food desert prevalence?
model_poverty <- lm(pct_fd_tracts ~ avg_poverty_rate, data = state_analysis)
cat("MODEL 1: Food Desert % = f(Poverty Rate)\n")
cat("  R-squared:", round(summary(model_poverty)$r.squared, 3), 
    "- Poverty explains", round(summary(model_poverty)$r.squared * 100, 1), 
    "% of variance\n")
cat("  Coefficient:", round(coef(model_poverty)[2], 3), "\n")
cat("  Interpretation: For every 1% increase in poverty rate,\n")
cat("                  food desert prevalence increases by", 
    round(coef(model_poverty)[2], 2), "percentage points\n\n")

# M2: Can income predict food desert prevalence?
model_income <- lm(pct_fd_tracts ~ median_income, data = state_analysis)
cat("  R-squared:", round(summary(model_income)$r.squared, 3), 
    "- Income explains", round(summary(model_income)$r.squared * 100, 1), 
    "% of variance\n")
cat("  Coefficient:", round(coef(model_income)[2], 6), "\n")
cat("  Interpretation: For every $10,000 increase in median income,\n")
cat("                  food desert prevalence decreases by", 
    abs(round(coef(model_income)[2] * 10000, 2)), "percentage points\n\n")


# Which states don't fit the pattern?
cat("\nOUTLIERS (States that don't fit the pattern)\n")
cat(paste(rep("=", 80), collapse=""), "\n\n")

state_analysis$residual <- residuals(model_poverty)

outliers <- state_analysis %>%
  arrange(desc(abs(residual))) %>%
  head(5) %>%
  select(State, pct_fd_tracts, avg_poverty_rate, median_income, residual)

cat("Top 5 states that deviate from expected pattern:\n\n")
print(outliers)


