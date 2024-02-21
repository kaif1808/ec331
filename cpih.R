cpih$date <- paste0("01-", cpih$`mmm-yy`)
cpih$date <- as.Date.character(cpih$date, format = "%d-%b-%y")
agg_cpih <- cpih[cpih$cpih1dim1aggid == "CP00", ]
agg_cpih$val <- agg_cpih$v4_0

agg_cpih <- agg_cpih[c("date", "val")]

cpih_xts <- xts(agg_cpih$val, order.by=agg_cpih$date)
cpih_xts <- apply.quarterly(cpih_xts, mean)

cpih_xts <- cpih_xts['2005-03-01/2023-12-01']
cpih.ts <- ts(cpih_xts, frequency = 4, start = c(2004 , 4))



#agg_cpih <- agg_cpih %>%
#  arrange(date) %>%
#  mutate(monthly_change = (val / lag(val) - 1) * 100 ) %>%
#  filter(year(date) >= 2005) 