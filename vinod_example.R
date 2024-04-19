rm(list=ls())
options(prompt = " ", continue = " ", width = 68,
        useFancyQuotes = FALSE)
print(date())

m2q=function(x, cum=T){
  # Input= x monthly series, OUTPUT= quar as quarterly
  #version
  #of x
  y2=x; n=length(x)
  start.year=start(x)[1]
  new.year=start.year
  start.month=start(x)[2]
  end.month=end(x)[2]
  end.year=end(x)[1]
  if (start.month==1) new.start=1
  if (start.month==2) {new.start=2
  #delete Feb and March first two data points
  y2=window(x, start=c(new.year,4))}
  if (start.month==3) {new.start=2
  #delete March first 1 data point
  y2=window(x, start=c(new.year,4))}
  if (start.month==4) new.start=2
  if (start.month==5) {new.start=3
  #delete May and June 2 data point
  y2=window(x, start=c(new.year,7))}
  if (start.month==6) {new.start=3
  #delete June 1 data point
  y2=window(x, start=c(new.year,7))}
  if (start.month==7) new.start=3
  if (start.month==8) {new.start=4
  #delete Aug and Sept 2 data points
  y2=window(x, start=c(new.year,10))}
  if (start.month==9) {new.start=4
  #delete Sept 1 data point
  y2=window(x, start=c(new.year,10))}
  if (start.month==10) new.start=4
  if (start.month==11) {new.start=1
  #delete NOV and DEC first 2 data points
  new.year=start.year+1
  y2=window(x, start=c(new.year,1))}
  if (start.month==12) {new.start=1
  #delete DEC first 1 data point
  new.year=start.year+1
  y2=window(x, start=c(new.year,1))}
  eyy2=end(y2)[1]
  emy2=end(y2)[2]
  nn=length(y2)
  if((nn%%3)!=0) y2=window(y2, end=c(eyy2-1,12))
  print(c("starting value for selected monthly series",
          start(y2)),q=F)
  print(c("ending value for selected monthly series",
          end(y2)),q=F)
  n=length(y2)
  y=matrix(y2,nrow=3);
  #print(y) #for details remove the # at the start of
  #this line
  if (cum) quar=apply(y,2,sum, na.rm=F)
  if (cum==F) quar=apply(y,2,mean, na.rm=F)
  quar=ts(quar, start=c(new.year,new.start), frequency=4)
  print(c("starting value for quarterly series",
          start(quar)),q=F)
  print(c("ending value for quarterly series",
          end(quar)),q=F)
  list(quar=quar)} #function m2q ends here

#get inflation data from FRED website
library(fImport)
#producerPriceIndexMonthly
cnd=fredImport(query="PPIACO", file = "tempfile",
               source = "http://research.stlouisfed.org/fred2/series/",
               save = FALSE, sep = ";", try = TRUE)
cnd2=ts(data.frame(cnd@data)$PPIACO,
        start=c(1913,1),frequency = 12)
head(cnd2)
#convert to quarterly data
ppiq=m2q(cnd2)$quar
head(ppiq)
tail(ppiq)
ppi=ts(ppiq, frequency = 4,
       start = c(1913, 1))
head(ppi)
tail(ppi)
#get profit data from FRED website
cnd=fredImport(query="A466RD3Q052SBEA", file = "tempfile",
               source = "http://research.stlouisfed.org/fred2/series/",
               save = FALSE, sep = ";", try = TRUE)

cnd2=ts(data.frame(cnd@data)$A466RD3Q052SBEA,
        start=c(1947,1),frequency = 4)
head(cnd2)
profit=ts(cnd2,frequency = 4, start=c(1947,1))
head(profit)
tail(profit)
length(profit)
length(ppi)
profitppi=ts.intersect(profit,ppi)
profit1=profitppi[,1]
ppi1=profitppi[,2]
length(profit1)
length(ppi1)
head(profitppi)

profit2=profit*5000 #rescale profit for plotting
ts.plot(cbind(profit2,ppi), main="Quarterly profits (solid line)
and producer price index (dashed line)", lty=1:2, lwd=2,
        ylab="profits and inflation")

library(generalCorr)
options(np.messages=FALSE)
print("causation for data for all 300 quarters from 1960")
causeSummary(profitppi)
causeSummBlk(profitppi)
print("causation for data from 1960 except last 10 quarters")
causeSummary(profitppi[1:290,])
causeSummBlk(profitppi[1:290,])
causeSummary(profitppi[291:300,])
 
cnd=fredImport(query="CPIAUCSL", file = "tempfile",
               source = "http://research.stlouisfed.org/fred2/series/",
               save = FALSE, sep = ";", try = TRUE)
cnd2=ts(data.frame(cnd@data)$CPIAUCSL,
        start=c(1947,1),frequency = 12)
head(cnd2)
tail(cnd2)
cpiq=m2q(cnd2)$quar
head(cpiq)
tail(cpiq)
cpi=ts(cpiq, frequency = 4,
       start = c(1947, 1))
head(cpi)
tail(cpi)
profitcpi=ts.intersect(Pi,cpih.ts)

profit1=profitcpi[,1]
cpi1=profitcpi[,2]
length(profit1)
length(cpi1)
head(profitcpi)
apply(profitcpi,2,mean)
Pi2=Pi/775
#profit data units changed for graphics
ts.plot(cbind(Pi2, cpih.ts), main="Quarterly profits (solid line) and consumer prices (dashed line)", lty=1:2,
        lwd=2, ylab="profits and inflation")

library(generalCorr)
options(np.messages=FALSE)
c1=causeSummary(profitcpi)
c2=causeSummary2(profitcpi[64:74,])
c3=causeSummBlk(profitcpi)
c4=causeSummBlk(profitcpi [64:74,])
library(xtable)
c14=rbind(c1,c2)
c14
xtable(c14)
c1=causeSummBlk(profitcpi)
c2=causeSummBlk(profitcpi [64:74,])