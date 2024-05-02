library(reticulate)
library(jsonlite)
library(tidyverse)
library(randomForest)
library(xgboost)
library(data.table)
library(arrow)
library(duckdb)
library(stringr)
library(lubridate)
library(ggplot2)
library(generalCorr)
library(onsr)
library(ggfortify)
library(xts)
library(zoo)
library(vars)
library(gridExtra)

rm(list = ls())

uk_firm <- as.data.table(fread("uk_firm_data.csv", dec = ".", sep = ",", colClasses = list(character = "uksic")))
uk_firm$date <- as.numeric(format(as.Date(uk_firm$date, format="%d/%m/%Y"),"%Y"))
cols_to_convert <- c("cogs", "adminexp", "interestpaid", "numemp", "rent", "rd", "totopren", "hireplant", "intanassets", "div", "capinv", "turnover")
uk_add <- as.data.table(read_csv("additional_data.csv"))
uk_add$date <- as.numeric(format(as.Date(uk_add$date, format="%d/%m/%Y"),"%Y"))
# Merge uk_firm with uk_add based on 'rnum' (character) and 'date' (numeric)
uk_firm <- merge(uk_firm, uk_add, by = c("rnum", "date"), all.x = TRUE)
rm(uk_add)

head(uk_firm %>% group_by(date) %>% summarize(n = n()))



#cpih data preparation
cpih <- ons_get("cpih01")
source("cpih.R")

inf_exp <- fread("inflation_expectations.csv")
source("inf_exp.R")

profits <- fread("uk_profits.csv")
source("profits.R")

rgdp <- fread("realgdp.csv")
source("rgdp.R")

#oil data preparation
oil <- fread("oil.csv")
source("oil.R")


#base rate preparation
base_rate <- fread("Bank Rate history.csv")
source("base_rate.R")

#refinitiv api
Eikon <- EikonConnect(Eikonapplication_id = "93ee18c61e184f099ce9039349b9becdf8585721", PythonModule = "JSON")
RD <- RDConnect(application_id = "93ee18c61e184f099ce9039349b9becdf8585721", PythonModule = "JSON")
