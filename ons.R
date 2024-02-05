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

#get inflation data from ONS website
library(fImport)
library(onsr)
datasets <- ons_datasets()

ons_browse_qmi(id = "cpih01")
fullCPIHDataset <- ons_get(id = "cpih01")
