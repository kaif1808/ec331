inf_exp$Date <- NULL
inf_exp <- inf_exp[-c(1:21)]
exp.ts <- ts(inf_exp, start = c(2005,1), frequency = 4)
