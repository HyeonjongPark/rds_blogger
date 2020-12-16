
rm(list = ls())


library(readr)
library(rlang)
library(dplyr)
library(tidyverse)
library(data.table)
library(stringr)

getwd()
chat_raw = read_lines("./data/06_real_estate_talk.txt")
chat_raw = as.data.frame(chat_raw)
chat_raw %>% head

colnames(chat_raw)[1] = "text"
chat_raw$text = as.character(chat_raw$text)
chat_raw %>% head

chat_raw = chat_raw %>% filter(substr(text, 1, 4) == "2020" | substr(text, 1, 4) == "2019" | substr(text, 1, 4) == "2018" | substr(text, 1, 4) == "2017") 
chat_raw$ind = NA
# test
chat_raw$text = iconv(chat_raw$text , 'UTF-8') 
chat_raw_2 = chat_raw %>% filter(!is.na(text))

chat_raw_2 %>% head
chat_raw_2 %>% tail

chat_raw_2$ind = 1:nrow(chat_raw_2)
rownames(chat_raw_2) = 1:nrow(chat_raw_2)




chat_1 = chat_raw_2
chat_1 = chat_1[!grepl("http", chat_1$text),]


#chat_1 = chat_1 %>% head(100)
chat_1$text = gsub('[ㄱ-ㅎ]','',chat_1$text)
chat_1$text = gsub('[ㅏ-ㅣ]','',chat_1$text)
chat_1$text = gsub('"','',chat_1$text)

chat_1 %>% head

str_extract(chat_1$text, ", .")
regmatches(chat_1$text, regexpr("([, ].+[.][ : ])", chat_1$text)) %>% head


ind_real = chat_1$ind[grepl("[0-9]+. [0-9]+. [0-9]+. [가-힣]+. [0-9]+:[0-9]+.", chat_1$text)]
ind_real %>% length
ind_real %>% tail
date = str_extract(chat_1$text[chat_1$ind %in% ind_real], "[0-9]+. [0-9]+. [0-9]+. [가-힣]+. [0-9]+:[0-9]+.")
speaker = gsub(" ","",substr(gsub("[0-9]+. [0-9]+. [0-9]+. [가-힣]+. [0-9]+:[0-9]+.", "", chat_1$text[chat_1$ind %in% ind_real]),1,4)) 
speaker %>% length
text = gsub("[0-9]+. [0-9]+. [0-9]+. [가-힣]+. [0-9]+:[0-9]+., [가-힣][가-힣][가-힣] : ", "", chat_1$text[chat_1$ind %in% ind_real]) 
text %>% length

chat2 = cbind(ind_real, date, speaker, text) %>% as.data.frame() 
colnames(chat2)[1] = "ind"



chat_1$text[chat_1$text == "삭제된 메시지입니다."] = NA
chat_1$text[chat_1$text == "이모티콘"] = ""
chat_1$text[chat_1$text == "사진"] = NA
chat_1$text[chat_1$text == "동영상"] = NA

chat_1$text <- gsub('[~!@#$%^&*()_+=?^]<>','',chat_1$text)
