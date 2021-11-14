#8장 257page 연습문제 2번
#(1)
install.packages("ggmap")
library(ggmap)
#구글 API 키 등록
register_google(key="구글 API키 입력")
library(ggplot2)
names <- c("서울특별시","인천광역시","부산광역시","대구광역시","광주광역시","대전광역시","울산광역시")
gc <- geocode(enc2utf8(names))
#지명이름, 경도, 위도가 포함된 데이터 프레임 생성
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <-get_googlemap(center = cen,
                    maptype = 'roadmap',
                    zoom= 8,
                    marker = gc)     #지도 위에 각 위치마다 마커 표시시
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),   #축 설정
                 size=3,
                 label = df$name)   # 지명 이름으로 라벨링


#(2)
jeju <- c("성산일출봉","한라산","금오름","천지연폭포","용두암","중문관광단지")
gc <- geocode(enc2utf8(jeju))
df<-data.frame(name=jeju, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 8,
                     marker =gc)
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),
                 size =3,
                 label = df$name)



#3번의 (1)
birth <- read.csv("seoul_birth_202007.csv")
#(2)처음 10행의 내용을 출력하고 구조와 요약 통계량을 출력
head(birth,10)
str(birth)
summary(birth)

#(3)
seoul<- c("강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구",
          "동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구",
          "영등포구","용산구","은평구","종로구","중구","중랑구")
gc <- geocode(enc2utf8(seoul))
df<-data.frame(name=seoul, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 11,
                     marker =gc)
gmap <- ggmap(map)
gmap + geom_text(data = df,
                 aes(x = lon, y = lat),
                 size =3,
                 label = df$name)

#(4)
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 11)
gmap <- ggmap(map)
gmap + geom_point(data = df,
                  aes(x = lon, y = lat),
                  color = 'blue')


#(5)
top10 <- head(birth,10)   #상위 10개 구를 추출해서 top10이라는 데이터 프레임 만들기
str(top10)     #구조 확인

#(6)
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 11)
gmap <- ggmap(map)
gc <- geocode(enc2utf8(top10$'행정구역'))
df<-data.frame(name=top10$'행정구역', lon = gc$lon, lat = gc$lat)
gmap + geom_point(data = df,
                  aes(x = lon, y = lat),
                  color = 'blue',
                  size = top10$'출생인구수'/10,
                  alpha = 0.5)

#(7)
gmap + geom_point(data = df,
                  aes(x = lon, y = lat),
                  color = rainbow(10),     #상위10개의 구 색상 모두 다르게
                  size = top10$'출생인구수'/10,   #인구수 크기가 크므로 10으로 나누어줌
                  alpha = 0.5)


#4번의 (1)
find_dust <- read.csv("finedust_PM10__1910_2003.csv")
str(find_dust)

#(2)
head(find_dust,5)
str(find_dust)
summary(find_dust)

#(3)
library(dplyr)   #select함수를 쓰기위한 dplyr 부착
dust_2020 <- select(find_dust,시도별.1.,시도별.2.,X2020..01,X2020..02,X2020..03)

#(4)
names(dust_2020) <- c("province","city","month1","month2","month3")
dust_2020$month1 <- as.numeric(dust_2020$month1)
dust_2020$month2 <- as.numeric(dust_2020$month2)
dust_2020$month3 <- as.numeric(dust_2020$month3)
#정수형으로 변환

#(5) 결측치 확인
is.na(dust_2020$month1)
is.na(dust_2020$month2)
is.na(dust_2020$month3)

#(6)
dust_2020$sum <- rowSums(dust_2020[3:5], na.rm = TRUE)
dust_2020$avg <- rowMeans(dust_2020[3:5], na.rm = TRUE)
str(dust_2020)    #데이터가 잘 들어갔는지 확인

#(7)
dust_province <- dust_2020 %>% group_by(province) %>% summarise(mean = mean(avg,na.rm=TRUE))
str(dust_province)    #데이터가 잘 들어갔는지 확인

#(8)
library(ggmap)
#구글 API 키 등록
register_google(key="구글 API 키 입력")
library(ggplot2)
province <- c("강원도","경기도","경상남도","경상북도","광주광역시","대구광역시","대전광역시","부산광역시","서울특별시","세종시",
              "울산광역시","인천광역시","전라남도","전라북도","제주도","충청남도","충청북도")
gc <- geocode(enc2utf8(province))
df<-data.frame(name=province, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon),mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 7)
gmap <- ggmap(map)
gmap + geom_point(data = df,
                  aes(x = lon, y = lat),
                  color = rainbow(17),     #색상 모두 다르게
                  size = dust_province$mean/5,   #미세먼지에 비례해서 사이즈도 다르게
                  alpha = 0.5)
