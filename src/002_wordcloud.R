
version



library(KoNLP)
library(wordcloud2)
library(devtools)
library(wordcloud2)
library(RColorBrewer)


# data 출처 : https://www1.president.go.kr/petitions/592084

simu <- readLines('./data/simu7.txt',encoding = 'UTF-8')

simu2 <- sapply(simu,extractNoun,USE.NAMES = F)

simu3 <- unlist(simu2)

# 숫자 제거
simu4 <- gsub('\\d+','',simu3)
simu4 <- gsub('""','',simu4)
simu4 <- gsub('-','',simu4)
simu4 <- gsub('하시','',simu4)
simu4 <- gsub('것이옵니','',simu4)
simu4 <- gsub('있겠사옵니','',simu4)
simu4 <- gsub('빼앗','',simu4)
simu4 <- gsub('않사옵니','',simu4)
simu4 <- gsub('없사옵니','',simu4)


simu4 = gsub("[[:punct:]]", "", simu4)
# string이 2이상인 것만 필터링
simu4 <- Filter(function(x) {nchar(x)>=2}, simu4) 

#write(unlist(simu4),'yeungnam1.txt')
#simu5 <- read.table('yeungnam1.txt')

wordcount <- table(simu4)
wordcount <- head(sort(wordcount,decreasing=T),300)
wordcount

wordcloud2(data=wordcount,fontFamily = '나눔바른고딕', size = 2)

wordcloud2(data=wordcount,color = "random-dark", backgroundColor = "black", fontFamily = '나눔바른고딕', size= 2)


