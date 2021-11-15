#웹스크래핑과 공공데이터 활용하기
install.packages("rvest")
library(xml2)
library(rvest)

#9-2 html 문서 가져오기
url <- 'https://www.melon.com/chart/week/index.htm'
html <- read_html(url)
#에러가 발생하는게 정상입니다.
#이 에러를 해결하려면 헤더 정보에 'useragent'정보를 포함해서 웹서버에 전송하면 해결
#해결을 위해 curl패키지 필요

#9-3 html 문서 가져오기
install.packages("curl")
library(curl)
url <- 'https://www.melon.com/chart/week/index.htm'
html <- read_html(curl(url, handle = new_handle("useragent"= "Chrome")))
html

#9-4 css 값을 이용한 [가요제목]노드 추출
music_contents <- html_nodes(html,css='div.ellipsis.rank01')
music_nodes <- html_nodes(music_contents, 'a')
head(music_nodes)

#9-5 xpath 값을 이용한 노드 추출
music_contents1 <- html_nodes(html, xpath= '//*[@id="lst50"]/td[6]/div/div/div[1]/span/a')
head(music_contents1)

#9-6 가요제목 텍스트 추출
music_text_css <- html_text(music_nodes)          #css에 의한 결과
head(music_text_css,10)
music_text_xpath<-html_text(music_contents1)      #xpath에 의한 결과과
head(music_text_xpath,10)

#9-7 아티스트 텍스트 추출-xpath
artist_contents1 <- html_nodes(html,xpath='//*[@id="lst50"]/td[6]/div/div/div[2]/a')
artist_text_xpath<-html_text(artist_contents1)
head(artist_text_xpath,10)

#9-8 아티스트 텍스트 추출-css
artist_contents <- html_nodes(html,css='div.ellipsis.rank02')
artist_nodes<-html_nodes(artist_contents, 'a')
artist_text_css<-html_text(artist_nodes)
head(artist_text_css,10)

#9-9 아티스트 텍스트 추출-css-수정 (같은팀이 같이 안나오고 따로나옴)
artist_contents <- html_nodes(html,css='div.ellipsis.rank02')
artist_nodes<-html_nodes(artist_contents,'span')
artist_nodes1<-html_nodes(artist_nodes,'a')
artist_text_css1<-html_text(artist_nodes1)
head(artist_text_css1,10)


##################################################################
#아티스트 텍스트 추출-css-수정-교과서 수정(checkellipsis만 추출)
artist_contents <- html_nodes(html,'.checkEllipsis')
#텍스트 추출
artist_text_css1<-html_text(artist_contents, trim=TRUE)
head(artist_text_css1,10)

#한꺼번에
artist_text_css3=html %>% html_nodes('.checkEllipsis') %>% html_text(trim=TRUE)
head(artist_text_css3,10)
#################################################################


#9-10 앨범 이미지의 img 노드 값 추출
url <- 'https://www.melon.com/chart/week/index.htm'
img_html <- read_html(curl(url,handle = new_handle("useragent"="Chrome")))
img_html
img_nodes<-html_nodes(img_html,'img')
head(img_nodes)

#9-11 앨범 이미지 저장하기
img_src=vector()            #src 값을 저장할 벡터를 선언
for(i in 3:12) {
  img_src[i-2] <- html_attr(img_nodes[i],"src")
  download.file(img_src[i-2], paste("./output/img",i-2,".jpg",sep=""), mode = 'wb')   #output폴더는 미리 생성되어있어야함
}

#9-12 구글에서 고양이 이미지 스크래핑하기
library(xml2)
library(rvest)
#google 이미지 검색 url
url <- 'https://www.google.com/search?q=%EA%B3%A0%EC%96%91%EC%9D%B4&rlz=1C1CHBD_koKR969KR975&source=lnms&tbm=isch&sa=X&ved=2ahUKEwiEobnToJn0AhVirlYBHTFHA-EQ_AUoAXoECAEQAw&biw=1920&bih=969&dpr=1'
html <- session(url)
head(html)
contents<- html_nodes(html,'img')
head(contents)
img_url=vector()
for(i in 2:21){
  img_url[i] <- html_attr(contents[i],"src")
  print(img_url[i])
  download.file(img_url[i], paste("./cat_out/cat",i-1,".jpg",sep=""), mode = "wb")
}
