oil$date <- paste0("01-", oil$date)
oil$date <- as.Date(oil$date, format = "%d-%b-%Y")
oil$avg <- (oil$wti + oil$brent) / 2
oil$wti <- NULL
oil$brent <- NULL
oil$date <- as.Date(oil$date, format="%Y-%m-%d")

oil_xts <- xts(oil$avg, order.by=oil$date)
oil_xts <- apply.quarterly(oil_xts, mean)

oil.ts=ts(oil_xts, frequency = 4,
           start = c(2004, 4))
