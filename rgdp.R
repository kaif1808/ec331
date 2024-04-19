rgdp <- rgdp[-c(1:32), ]
rgdp$Date <- NULL
rgdp.ts <- ts(rgdp, frequency = 4, start = c(2005, 1))
dY <- diff(log(rgdp.ts))
