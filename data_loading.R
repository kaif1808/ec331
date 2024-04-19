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
