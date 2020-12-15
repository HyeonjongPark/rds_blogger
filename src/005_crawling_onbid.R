# install.packages("RSelenium")


rm(list=ls())

# cd c:\selenium
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.0.jar -port 4449

ch=wdman::chrome(port=4569L) #크롬드라이버를 포트 4449번에 배정
remDr=remoteDriver(remoteServerAddr = "localhost", port=4449L, browserName='chrome') #remort설정
remDr$open() #크롬 Open
remDr$navigate("http://www.dailypharm.com/Users/") # 홈페이지 이동

library(RSelenium)
library(rvest)
library(stringr)
library(RSelenium)
library(rJava)
library(XML)
library(binman)
library(stringr)
library(dplyr)
library(glue)

chromeversion <- toString(dir(path = 'C:/Program Files (x86)/Google/Chrome/Application/')) %>% 
  str_extract(., '^\\d+\\.\\d+\\.\\d+\\.') %>% 
  str_replace_all(., '\\.', '\\\\.')  


chromedriver <-  str_extract_all(toString(list_versions("chromedriver")), paste0(chromeversion, '\\d+'), simplify = TRUE) %>% 
  as.numeric_version(.) %>% 
  min(.)

rD1 <- rsDriver(browser = "chrome", port = 8986L, geckover = NULL, 
                chromever =  toString(chromedriver), iedrver = NULL, 
                phantomver = NULL, verbose = TRUE)
remDr <- rD1[["client"]] 


remDr$navigate("https://www.onbid.co.kr/op/dsa/main/main.do") # 홈페이지 이동


## 부동산 -> 부동산 HOME 클릭
btn_home = remDr$findElement(using = "xpath" , value = '//*[@id="gnb"]/ul/li[1]/a')
btn_home$clickElement() # 검색

Sys.sleep(5)


## 기간 선택
start_date = "2020-09-04"
end_date = "2020-12-04"

start_date_word = remDr$findElement(using = "xpath" , value = '//*[@id="searchBegnDtm"]')
start_date_word$clearElement()
start_date_word$sendKeysToElement(list(start_date)) # 검색어 입력

end_date_word = remDr$findElement(using = "xpath" , value = '//*[@id="searchClsDtm"]')
end_date_word$clearElement()
end_date_word$sendKeysToElement(list(end_date)) # 검색어 입력



## 용도 선택

# 토지
btn_toji = remDr$findElement(using = "xpath" , value = '//*[@id="firstCtgrId2"]')
btn_toji$clickElement() # 체크박스 선택

# # 주거
# btn_jugeo = remDr$findElement(using = "xpath" , value = '//*[@id="firstCtgrId33"]')
# btn_jugeo$clickElement() # 체크박스 선택
# 
# # 상가
# btn_sangga = remDr$findElement(using = "xpath" , value = '//*[@id="firstCtgrId52"]')
# btn_sangga$clickElement() # 체크박스 선택
# 
# # 산업
# btn_sanup = remDr$findElement(using = "xpath" , value = '//*[@id="firstCtgrId76"]')
# btn_sanup$clickElement() # 체크박스 선택
# 
# # 용도
# btn_yongdo = remDr$findElement(using = "xpath" , value = '//*[@id="firstCtgrId83"]')
# btn_yongdo$clickElement() # 체크박스 선택

  
## 용도 상세 (토지편)

# yongdo_count = "00" # 전체 선택
yongdo_count = c("01", "03", "05", "08") # 체크 선택

# # 전체      0
# btn_0 = remDr$findElement(using = "xpath" , value = glue('//*[@id="secondCtgrId_101',yongdo_count,'"]'))
# btn_0$clickElement() # 체크박스 선택


for(i in 1:length(yongdo_count)) {
  
  ind = yongdo_count[i]
  
  btn_0 = remDr$findElement(using = "xpath" , value = glue('//*[@id="secondCtgrId_101',ind,'"]'))
  btn_0$clickElement() # 체크박스 선택
}


## 유찰횟수 선택

# 1 : 전체
# 2 : 0회
# 3 : 2회
# 4 : 4회
# 5 ; 6회
# 6 : 8회
# 7 : 10회
youchal_min_count = 3
btn_youchal_min = remDr$findElement(using = "xpath" , value = paste0('//*[@id="searchFromUsbdCnt"]/option[',youchal_min_count,']'))
btn_youchal_min$clickElement() # 체크박스 선택

# 1 : 전체
# 2 : 2회
# 3 : 4회
# 4 ; 6회
# 5 : 8회
# 6 : 10회
youchal_max_count = 6
btn_youchal_max = remDr$findElement(using = "xpath" , value = paste0('//*[@id="searchToUsbdCnt"]/option[',youchal_max_count,']'))
btn_youchal_max$clickElement() # 체크박스 선택




## 검색

btn_search = remDr$findElement(using = "xpath" , value = '//*[@id="searchBtn"]/span')
btn_search$clickElement() # 검색

Sys.sleep(3) # 검색중.. 


# 
# # 전체 페이지 crawling
# frontPage = remDr$getPageSource()
# 
# ## 물건 번호 가져오기
# serial_number = read_html(frontPage[[1]]) %>% html_nodes('.info') %>% html_nodes('dt') %>% html_text()
# 
# # 물건명 가져오기
# location = read_html(frontPage[[1]]) %>% html_nodes('.info') %>% html_nodes('.fwb') %>% html_text()
# 
# # # 가격 가져오기
# # price = read_html(frontPage[[1]]) %>% html_nodes('.ar') %>% html_text()
# # price = gsub("\n", "", price)
# # price = gsub("\t", "", price)
# # price = gsub(" ", "", price)
# # 
# # lower_price = 
# # expect_price = 
# 
# # 유찰횟수 가져오기
# youchal_count = read_html(frontPage[[1]]) %>% html_nodes('.op_tbl_type1') %>% html_nodes('.fwb') %>% html_text()
# youchal_count = youchal_count[seq(3,length(youchal_count), 3)]
# 
# 
# #read_html(frontPage[[1]]) %>% html_nodes('//*/table/tbody/td/span[@class="fwb"]') %>% html_text()
# 
# # 조회수 가져오기
# 
# view_count = read_html(frontPage[[1]]) %>% html_nodes('.op_tbl_type1') %>% html_nodes('td') %>% html_text()
# 
# view_count = gsub("\n", "", view_count)
# view_count = gsub("\t", "", view_count)
# view_count = gsub(" ", "", view_count)
# 
# view_count = view_count[seq(5,length(view_count), 6)]


# 페이지 넘기기
each_count = read_html(frontPage[[1]]) %>% html_nodes('.cm_paging.cl') %>% html_nodes('p') %>% html_text()
each_count = as.numeric(str_extract(each_count, "[:digit:]+"))  / 10

page_count = floor(each_count) + 1

df = data.frame()

for(i in 1:page_count) {
  btn_page = remDr$findElement(using = "xpath" , value = glue('//*[@id="collateralSearchForm"]/div[3]/a[',i,']/span'))
  btn_page$clickElement() # 체크박스 선택
  
  
  # 전체 페이지 crawling
  frontPage = remDr$getPageSource()
  
  ## 물건 번호 가져오기
  serial_number = read_html(frontPage[[1]]) %>% html_nodes('.info') %>% html_nodes('dt') %>% html_text()
  
  # 물건명 가져오기
  location = read_html(frontPage[[1]]) %>% html_nodes('.info') %>% html_nodes('.fwb') %>% html_text()
  
  # # 가격 가져오기
  # price = read_html(frontPage[[1]]) %>% html_nodes('.ar') %>% html_text()
  # price = gsub("\n", "", price)
  # price = gsub("\t", "", price)
  # price = gsub(" ", "", price)
  # 
  # lower_price = 
  # expect_price = 
  
  # 유찰횟수 가져오기
  youchal_count = read_html(frontPage[[1]]) %>% html_nodes('.op_tbl_type1') %>% html_nodes('.fwb') %>% html_text()
  youchal_count = youchal_count[seq(3,length(youchal_count), 3)]
  
  
  #read_html(frontPage[[1]]) %>% html_nodes('//*/table/tbody/td/span[@class="fwb"]') %>% html_text()
  
  # 조회수 가져오기
  
  view_count = read_html(frontPage[[1]]) %>% html_nodes('.op_tbl_type1') %>% html_nodes('td') %>% html_text()
  
  view_count = gsub("\n", "", view_count)
  view_count = gsub("\t", "", view_count)
  view_count = gsub(" ", "", view_count)
  
  view_count = view_count[seq(5,length(view_count), 6)]
  
  
  each_df = as.data.frame(cbind(serial_number, location, youchal_count, view_count))
  df = rbind(df, each_df)
  
  print(i)
  Sys.sleep(3)
}

df













search = remDr$findElement(using = "xpath" , value = '/html/body/div[2]/div[3]/div/form/div/input')
search$sendKeysToElement(list("얼라이언스")) # 검색어 입력
# /html/body/div[2]/div[3]/div/form/div/img
btn = remDr$findElement(using = "xpath" , value = '/html/body/div[2]/div[3]/div/form/div/img')
btn$clickElement() # 검색

btn2 = remDr$findElement(using = "xpath" , value = '/html/body/div[3]/div/div[2]/div[2]/form/div[6]/div[2]/input[5]')
btn2$clickElement() # 3년 지정

btn3 = remDr$findElement(using = "xpath" , value = '/html/body/div[3]/div/div[2]/div[2]/form/input')
btn3$clickElement() # 재검색

frontPage = remDr$getPageSource()
frontPage[[1]]
total_contents = read_html(frontPage[[1]]) %>% html_nodes('.seachBox')%>% html_text()
total_contents = gsub("\n","",total_contents)
total_contents = gsub("\t","",total_contents)
total_contents = gsub("뉴스 \\(총","",total_contents)
total_contents = trimws(gsub("건 검색\\)","",total_contents))
total_contents = as.integer(total_contents)


last_page = read_html(frontPage[[1]]) %>% html_nodes('.PageNav') %>%html_text()
last_page = gsub("\t" , "" ,last_page)
last_page = gsub("\n" , "" ,last_page)
last_page
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}


last_page = as.integer(substrRight(last_page,1))


df = data.frame(title = rep(NA,total_page) , main = rep(NA,total_page))
for(i in 0:last_page-1) {
  for(j in 1:10) {
    
    btn4 = remDr$findElement(using = "xpath" , value = paste0('/html/body/div[3]/div/div[2]/div[3]/ul/li[',j,']/a'))
    btn4$clickElement() # 페이지 내부 접속
    frontPage = remDr$getPageSource()
    df$main[(i*10 + j)] = read_html(frontPage[[1]]) %>% html_nodes('.newsContents.font1')%>% html_text()
    df$main[(i*10 + j)] = gsub("\n","",df$main[(i*10 + j)])
    df$main[(i*10 + j)] = gsub("\t","",df$main[(i*10 + j)])
    df$main[(i*10 + j)] = trimws(gsub("<U+.*>", "", df$main[(i*10 + j)])) # <U~~> 제거
    df$main[(i*10 + j)] = trimws(gsub("//슬라이드.*리스트보기카드보기","",df$main[(i*10 + j)]))
    
    df$title[(i*10 + j)] = read_html(frontPage[[1]]) %>%  html_nodes('.newsTitle') %>% html_text()
    df$title[(i*10 + j)] = gsub("\t","",df$title[(i*10 + j)])
    df$title[(i*10 + j)] = gsub("\n","",df$title[(i*10 + j)])
    df$title[(i*10 + j)] = trimws(gsub("<U+.*>", "", df$title[(i*10 + j)]))
    
    Sys.sleep(3)
    remDr$goBack() # 뒤로가기
    
  }
  btn5 = remDr$findElement(using = "xpath" , value = paste0('/html/body/div[3]/div/div[2]/div[3]/div[2]/a[',(i+2),']')) # 페이지 이동
  btn5$clickElement()
  Sys.sleep(3)
}

remDr$close() #크롬 Close
df

setwd("C:/Users/guswh/Desktop/잡동")
write.csv(df,"dailypharm.csv")




## 연습
df[1]
kkk = df[1,2]
gsub("//슬라이드.*리스트보기카드보기      ","",kkk)
trimws(gsub(".*.리스트보기카드보기","",kkk))

trimws(gsub("^\\s*<U\\+\\w+>|-", "", df$title[(i*10 + j)]))

abc = "abcd<U+00A0>asdasdasd"
gsub("<U+.*>", "",abc)
trimws(gsub("^\\s*<U\\+\\w+>|-", " ", abc))

read_html(frontPage[[1]]) %>%  html_nodes('.newsTitle') %>% html_text()

btn4 = remDr$findElement(using = "xpath" , value = '/html/body/div[3]/div/div[2]/div[3]/ul/li[1]/a')
btn4$clickElement()

frontPage = remDr$getPageSource() #페이지 전체 소스 가져오기

abc = read_html(frontPage[[1]]) %>% html_nodes('.newsContents.font1')%>% html_text()
gsub("\\<-\\>","", abc)


btn5 = remDr$findElement(using = "xpath" , value = paste0('/html/body/div[3]/div/div[2]/div[3]/div[2]/a[',(2),']'))
btn5$clickElement()

remDr$close() #크롬 Close

###