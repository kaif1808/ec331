base_rate$Date.Changed <- as.Date(base_rate$Date.Changed, format = "%d-%b-%y")

base_rate_xts <- xts(base_rate$Rate, order.by = base_rate$Date.Changed)

base_rate_xts <- apply.quarterly(base_rate_xts, last)

quarterly_dates <- seq(as.Date("1975-01-01"), as.Date("2023-06-30"), by="quarter")

# Create an empty xts object with these dates
empty_xts <- xts(x=rep(NA, length(quarterly_dates)), order.by=quarterly_dates)

# Merge the empty xts with the original to ensure all quarters are represented
full_base_rate_xts <- merge(base_rate_xts, empty_xts, fill=NA)
full_base_rate_xts <- na.locf(full_base_rate_xts)
full_base_rate_xts[1] <- 10.00
full_base_rate_xts$empty_xts <- NULL
base_rate_xts <- to.quarterly(full_base_rate_xts, OHLC = FALSE)
rm(list = c("base_rate", "empty_xts", "full_base_rate_xts", "quarterly_dates", "quarterly_base_rate_xts"))
base_rate_xts <- base_rate_xts['2005-01-01 /']
base_rate.ts <- ts(base_rate_xts, frequency = 4, start = c(2004 , 4))
dI <- diff(log(base_rate.ts))
