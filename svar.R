A <- ts.intersect(dP, dPi, dI, dExp, dY)

lin.mod <- lm(dExp ~ time(dExp))
lin.trend <- lin.mod$fitted.values
linear <- ts(lin.trend, start = c(2005, 2), frequency = 4)
lin.cycle <- dExp - linear

adf.lin <- ur.df(lin.cycle, type = "none", selectlags = c("AIC"))
summary(adf.lin)

lin.mod <- lm(cpih.ts ~ time(cpih.ts))
lin.trend <- lin.mod$fitted.values
linear <- ts(lin.trend, start = c(2005, 2), frequency = 4)
lin.cycle <- cpih.ts - linear

adf.lin <- ur.df(lin.cycle, type = "none", selectlags = c("AIC"))
summary(adf.lin)

par(mfrow = c(1, 1), mar = c(2.2, 2.2, 1, 1), cex = 0.6)
plot.ts(lin.cycle)

info.var <- VARselect(A, lag.max = 10, type = "both")
info.var$selection

var.est1 <- VAR(A, p = 10, type = "const")
summary(var.est1)

a.mat <- diag(5)
diag(a.mat) <- NA
a.mat[2, 1] <- NA
a.mat[3, 1] <- NA
a.mat[3, 2] <- NA
a.mat[4, 1] <- NA
a.mat[4, 2] <- NA
a.mat[4, 3] <- NA
a.mat[5, 1] <- NA
a.mat[5, 2] <- NA
a.mat[5, 3] <- NA
a.mat[5, 4] <- NA
print(a.mat)
b.mat <- diag(5)
diag(b.mat) <- NA
print(b.mat)

svar.one <- SVAR(var.est1, Amat = a.mat, Bmat = b.mat, max.iter = 10000, 
                 hessian = TRUE)
svar.one

one.int <- irf(svar.one, response = "dP", impulse = "dPi", 
               n.ahead = 40, ortho = TRUE, boot = TRUE)
par(mfrow = c(1, 1), mar = c(2.2, 2.2, 1, 1), cex = 0.6)
plot(one.int)

lagselect <- VARselect(A, lag.max = 8, type = "both")
lagselect$selection
lagselect$criteria
