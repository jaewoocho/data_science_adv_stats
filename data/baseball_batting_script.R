# Load packages
library(baseballr)
library(fpp3)

# Player
player <- "Dansby Swanson"

# Set up weeks (e.g., 2021 season)
start_weeks <- seq.Date(
  as.Date("2021/4/1"),
  as.Date("2021/10/7"),
  by = 7
)
end_weeks <- seq.Date(
  as.Date("2021/4/7"),
  as.Date("2021/10/7"),
  by = 7
)

# Get batting average data
weekly_average <- matrix(
  0, nrow = length(end_weeks),
  ncol = 2
)

# Obtain batting statistics for the 2021 season
for(i in 1:length(end_weeks)){
  
  # Get batters
  batters <- bref_daily_batter(
    start_weeks[i],
    end_weeks[i]
  )
  
  # Obtain Dansby Swanson
  target <- which(batters$Name == player)
  
  # Obtain batting average
  weekly_average[i,2] <- batters$H[target] / batters$AB[target]
  
  # Week ending
  weekly_average[i,1] <- end_weeks[i]
}

# Convert to date frame
weekly_df <- as.data.frame(weekly_average)

# Set names
colnames(weekly_df) <- c("Week", "Average")

# Make tsibble
batting_ts <- tsibble(
  Week = ymd(end_weeks),
  Average = weekly_df$Average,
  index = Week
)

# Save data
save(
  batting_ts,
  file = "dansby2021batting.RData"
)

