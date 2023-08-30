# Set up Neuroticism data

# Load data
load("./esm_time_series.RData")

# Obtain data
esm_data <- bfi_items_wide_mi[,c(1:61)]
colnames(esm_data)[1] <- "ID"

# Remove all NA rows
all_NA <- apply(esm_data[,-1], 1, function(x){
  all(is.na(x))
})
esm_data <- esm_data[!all_NA,]

# Check for at least 20 measurement points
time_points <- table(esm_data$ID) >= 20
IDs <- names(time_points)[time_points]
esm_data <- esm_data[!is.na(match(esm_data$ID, IDs)),]

# Remove networks with densities
# less than 0.15
bad_IDs <- formatC(
  c(
    101, 117, 136, 137,
    139, 179, 217, 34,
    44, 52, 56, 59, 71,
    90, 92, 89, 98, 42,
    14, 72, 95, 80, 165,
    76, 132, 180, 17,124,
    166, 45, 32, 03, 85,
    115, 184, 211, 23, 81, 82
  ), digits = 1, flag = "0",
  format = "d"
)
esm_data <- esm_data[is.na(match(esm_data$ID, bad_IDs)),]

# Convert to data frame
esm_data <- as.data.frame(esm_data)

# Obtain neuroticism items only
neuroticism <- esm_data[
  , c(
    which(colnames(esm_data) == "ID"),
    grep("neuroticism", colnames(esm_data))
  )
]

# Rename items
colnames(neuroticism) <- c(
  "ID",
  "Stays optimistic after experiencing a setback",
  "Often feels sad",
  "Worries a lot",
  "Tends to feel depressed, blue",
  "Is relaxed, handles stress well",
  "Keeps their emotions under control",
  "Is moody, has up and down mood swings",
  "Can be tense",
  "Is emotionally stable, not easily upset",
  "Feels secure, comfortable with self",
  "Rarely feels anxious or afraid",
  "Is temperamental, gets emotional easily"
)

# Save neuroticism data
save(
  neuroticism,
  file = "neuroticism_esm.RData"
)



