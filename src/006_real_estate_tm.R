
rm(list = ls())

#install.packages('leaflet')
# install.packages("widgetframe")
library('leaflet')
library(widgetframe)

library(tibble)
library(readr)
library(rlang)
library(dplyr)
library(tidyverse)
library(data.table)
library(stringr)


getwd()

property_2020 = fread("./data/data006/newstapa-jaesan-2020/정기공개/CSV/newstapa-jaesan-2020-records.csv", encoding = "UTF-8")
property_2019 = fread("./data/data006/newstapa-jaesan-2019/CSV/newstapa-jaesan-2019-records.csv")
property_2018 = fread("./data/data006/newstapa-jaesan-2018/CSV/newstapa-jaesan-2018-records.csv")

property_2020 = property_2020[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]
property_2019 = property_2019[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]
property_2018 = property_2018[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]


property = rbind(property_2018, property_2019)
colnames(property) = c("year", "name", "belong", "spot", "relationship",
                       "category", "kinds", "detail", "price")


property$`재산 대분류` %>% unique

property_toji = property %>% filter(category == "토지")
property_toji %>% head(100)
property_toji %>% tail
property_toji = property_toji[grepl("번지",property_toji$detail),]

property_toji$adress = regmatches(property_toji$detail, regexpr(".+[번]+[지]", property_toji$detail))
property_toji$adress = enc2utf8(property_toji$adress)
property_toji$adress = as.character(property_toji$adress)

property_toji %>% head
source("./src/998_api_key.R")
register_google(map_key)
# lng_lat_300 = geocode(property_toji$adress[1:300])
#write.csv(lng_lat_300, "./out/lng_lat_300.csv", row.names = FALSE)

toji_300 = cbind(property_toji[1:300,],lng_lat_300)

toji_300$price = as.double(toji_300$price)


# 300개의 데이터를 활용한 prototype
leaflet(toji_300) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addMarkers(lng=~lon, lat=~lat, label=~adress)
  #addCircles(lng=~lon, lat=~lat, color='#006633')


leaflet(toji_300) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addCircles(lng=~lon, lat=~lat, color='#006633')


leaflet(toji_300) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addMarkers(clusterOptions = markerClusterOptions()) %>% 
  addTiles()
  


leaflet(toji_300) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('Stamen.Watercolor') %>%
  addCircles(lng=~lon, lat=~lat, color='#006633')


