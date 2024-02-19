rm(list=ls())
options(prompt = " ", continue = " ", width = 68,
        useFancyQuotes = FALSE)
print(date())

cpih <- ons_get("cpih01")

str(cpih)
cpih$date <- paste0("01-", cpih$`mmm-yy`)
cpih$date <- as.Date.character(cpih$date, format = "%d-%b-%y")
agg_cpih <- cpih[cpih$cpih1dim1aggid == "CP00", ]
agg_cpih$val <- agg_cpih$v4_0
agg_cpih <- agg_cpih %>%
  arrange(date) %>%
  mutate(monthly_change = (val / lag(val) - 1) * 100 ) %>%
  filter(year(date) >= 2005) 
agg_cpih <- agg_cpih[c("date", "val")]

cpih.ts<-ts(agg_cpih[,2], start=c(2005,1), end=c(2024,1), frequency=12)

ptheme <- theme(aspect.ratio = 2/3,text=element_text(size=10), 
                axis.title = element_text(size=9))
autoplot(cpih.ts)+ylab("CPIH")+xlab("Year")+ptheme+ggtitle("CPIH")

ggplot(agg_cpih, aes(x = date, y=val)) + geom_line() + labs(x="Date", y="CPIH",
        title = "CPIH between Jan-05 and Feb-24") + theme_minimal()


inf_exp <- fread("inflation_expectations.csv")

inf_exp$Date <- NULL

exp.ts <- ts(inf_exp1, start = c(1999,4), frequency = 4)

ggplot(agg_cpih, aes(x = date, y=val)) + geom_line() + labs(x="Date", y="CPIH",
                  title = "CPIH between Jan-05 and Feb-24") + theme_minimal()
