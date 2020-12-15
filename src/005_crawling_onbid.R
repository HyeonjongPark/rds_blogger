# install.packages("RSelenium")


rm(list=ls())

# cd c:\selenium
# java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.9.0.jar -port 4449

# ch=wdman::chrome(port=4569L) #크롬드라이버를 포트 4449번에 배정
# remDr=remoteDriver(remoteServerAddr = "localhost", port=4449L, browserName='chrome') #remort설정
# remDr$open() #크롬 Open
# remDr$navigate("http://www.dailypharm.com/Users/") # 홈페이지 이동

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

df$year = substr(df$serial_number, 1, 4)




remDr$close() #크롬 Close









library(rvest)
library(stringr)

##다음 기사 주소##
url = "https://news.v.daum.net/v/20190414215757617"
news <-read_html(url)   ##news에 gtml을 넣게됨##
node <-html_nodes(news,".thumb_g_article")   ##.thumb_g_article을 찾아 node에 넣게됨##

imgurl<-html_attr(node,'src')   ##node의 src를 imgurl에 넣게됨##
index=1   ##image파일을 저장할때 파일에 붙는 번호를 위한 변수 ex) image1, image2, image3##

for(urls in imgurl){ ## imgurl만큼 반복##
  download.file(urls,destfile= paste0("C:/Users/guswh/Desktop/data-analysis/rds_blogger/out/image",index,".jpg"),method='curl')#curl 이미지를 다운받는 함수  
  index=index+1
}



