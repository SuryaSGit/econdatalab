library(censobr)

# Download population-level variables
df_population <- read_population(
  year = 2010,
  columns = c("V0300",   # Control (for merging)
              "V0010",   # Sample Weight
              "V0656",   # Retirement/pension income
              "V0657",   # Bolsa Família income
              "V0658",   # Other social program income
              "V0659",   # Other income sources
              "V6591",   # Total value of other income
              "V6529",   # Household income (BRL)
              "V0627",   # Literacy (reads/writes)
              "V6400",   # Education level
              "V5040",   # Family indicator
              "V5060"),  # Number of people in family
  add_labels = NULL,
  as_data_frame = TRUE,
  showProgress = TRUE,
  cache = TRUE,
  verbose = TRUE
)

# Download household-level variables
df_households <- read_households(
  year = 2010,
  columns = c("V0300",   # Control (for merging)
              "V0010",   # Sample Weight
              "V0204",   # Number of bedrooms
              "V0206",   # Toilet/waste hole existence
              "V0211",   # Electric energy existence
              "V0216",   # Refrigerator existence
              "V0217",   # Cell phone existence
              "V0219",   # Microcomputer existence
              "V0221",   # Motorcycle existence
              "V0222"),  # Car existence
  add_labels = NULL,
  as_data_frame = TRUE,
  showProgress = TRUE,
  cache = TRUE,
  verbose = TRUE
)

# Merge using V0300 (Control)
df_merged <- df_population |>
  merge(df_households, by = c("V0300"), all = TRUE)

# Check the result
nrow(df_merged)
ncol(df_merged)
head(df_merged)
summary(df_merged)


# Keep V0010 from population, drop the duplicate
df_merged$V0010 <- df_merged$V0010.x
df_merged$V0010.x <- NULL
df_merged$V0010.y <- NULL

# Save
write.csv(df_merged, "df_merged.csv", row.names = FALSE)
saveRDS(df_merged, "df_merged.rds")

getwd()

