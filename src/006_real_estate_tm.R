
rm(list = ls())

#install.packages('leaflet')
# install.packages("widgetframe")
library(leaflet)
library(widgetframe)

library(tibble)
library(readr)
library(rlang)
library(dplyr)
library(tidyverse)
library(data.table)
library(stringr)
library(RColorBrewer)


getwd()
congress = read.csv("./data/data006/국회의원21대.csv")
congress$name = gsub(" \\(.*?\\)", "", congress$name)
congress = rbind(congress, data.frame(name = "문재인", dang = "더불어민주당"))


property_2020 = fread("./data/data006/newstapa-jaesan-2020/정기공개/CSV/newstapa-jaesan-2020-records.csv", encoding = "UTF-8")
# property_2019 = fread("./data/data006/newstapa-jaesan-2019/CSV/newstapa-jaesan-2019-records.csv")
# property_2018 = fread("./data/data006/newstapa-jaesan-2018/CSV/newstapa-jaesan-2018-records.csv")

property_2020 = property_2020[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]
# property_2019 = property_2019[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]
# property_2018 = property_2018[,c("연도", "이름", "소속", "직위", "본인과의 관계", "재산 대분류", "재산의 종류", "소재지 면적 등 권리의 명세", "현재가액")]


property = property_2020


# property = rbind(property_2018, property_2019)


colnames(property) = c("year", "name", "belong", "spot", "relationship",
                       "category", "kinds", "detail", "price")
property$price = as.double(property$price)
property = left_join(property, congress, by = c("name" = "name"))

property$dang = as.character(property$dang)
property$dang[is.na(property$dang) == T] = "공직자"


property$kinds %>% unique

property_toji = property %>% filter(category == "토지")
property_toji %>% head(100)
property_toji %>% tail
property_toji = property_toji[grepl("번지",property_toji$detail),]



property_toji$address = regmatches(property_toji$detail, regexpr(".+[번]+[지]", property_toji$detail))
property_toji$address = enc2utf8(property_toji$address)
property_toji$address = as.character(property_toji$address)

property_toji %>% head
source("./src/998_api_key.R")
register_google(map_key)
lng_lat_2020_800 = geocode(property_toji$address[1:800])
#write.csv(lng_lat_2020_800, "./out/lng_lat_2020_800.csv", row.names = FALSE)

lng_lat_2020_800 = cbind(property_toji[1:800,],lng_lat_2020_800)


# 300개의 데이터를 활용한 prototype
leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addMarkers(lng=~lon, lat=~lat, label=~address)
  #addCircles(lng=~lon, lat=~lat, color='#006633')


leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addCircles(lng=~lon, lat=~lat, color='#006633')


leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('CartoDB.Positron') %>%
  addMarkers(clusterOptions = markerClusterOptions()) %>% 
  addTiles()
  


leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles('Stamen.Watercolor') %>%
  addCircles(lng=~lon, lat=~lat, color='#006633')


library(RColorBrewer)
display.brewer.all(colorblindFriendly = T)

brewe

cof <- colorFactor(c(brewer.pal(12, "Paired"), brewer.pal(5, "Dark2")), domain=unique(lng_lat_2020_800$kinds))
leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles(providers$CartoDB.DarkMatter) %>%
  #addProviderTiles('CartoDB.Positron') %>%
  #addProviderTiles('Stamen.Watercolor') %>%
  addCircles(lng=~lon, lat=~lat, color=~cof(kinds), popup = lng_lat_2020_800$kinds, weight = 3, radius = 5000 , 
             stroke = F, fillOpacity = 0.5) %>% 
  addMarkers(clusterOptions = markerClusterOptions()) %>%
  addLegend("bottomright", colors= c(brewer.pal(12, "Paired"), brewer.pal(5, "Dark2")),
            labels=unique(lng_lat_2020_800$kinds), title="kinds of real estate") 




#display.brewer.all(colorblindFriendly = T)

cof <- colorFactor(c(brewer.pal(12, "Paired"), brewer.pal(5, "Dark2")), domain=unique(lng_lat_2020_800$kinds))
leaflet(lng_lat_2020_800) %>%
  setView(lng=126.9784, lat=36.566, zoom=7) %>%
  addProviderTiles(providers$CartoDB.DarkMatter) %>%
  #addProviderTiles('CartoDB.Positron') %>%
  addCircles(lng=~lon, lat=~lat, color=~cof(kinds), popup = lng_lat_2020_800$kinds, weight = 3, radius = (lng_lat_2020_800$price/50) , 
             stroke = F, fillOpacity = 0.5) %>% 
  addLegend("bottomright", colors= c(brewer.pal(12, "Paired"), brewer.pal(5, "Dark2")),
            labels=unique(lng_lat_2020_800$kinds), title="kinds of real estate") 




property %>% str
property = property %>% filter(!is.na(price))
property %>% group_by(year) %>% summarise(wealth = mean(price))

property %>% head
property %>% group_by(name,spot,dang) %>% summarise(wealth_total = sum(price)) %>% arrange(desc(wealth_total)) %>% head(20)
property %>% group_by(name,spot,dang) %>% summarise(wealth_total = sum(price)) %>% arrange(wealth_total) %>% head(20)




#Top 10 high wealth dang
property %>%
  group_by(dang) %>%
  summarise(Mean=mean(price)) %>%
  arrange(desc(Mean)) %>%
  top_n(n=10) %>%
  hchart(type="bar",hcaes(x=dang,y=Mean, color = dang)) %>%
  hc_title(text="Top 10 high wealth",style = list(color = "#2b908f", fontWeight = "bold"))



property %>%
  group_by(name) %>%
  summarise(Sum=sum(price)) %>%
  arrange(desc(Sum)) %>%
  top_n(n=10) %>%
  hchart(type="bar",hcaes(x=name,y=Sum, color = name)) %>%
  hc_title(text="Top 10 wealth",style = list(color = "#2b908f", fontWeight = "bold"))


property %>%
  group_by(name) %>%
  summarise(Sum=sum(price)) %>%
  arrange(desc(Sum)) %>%
  tail(10) %>%
  hchart(type="bar",hcaes(x=name,y=Sum, color = name)) %>%
  hc_title(text="Bottom 10 wealth",style = list(color = "#2b908f", fontWeight = "bold"))






