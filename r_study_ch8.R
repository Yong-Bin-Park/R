#8-1 ggmap  패키지 설치 및 로드
install.packages("ggmap")
library(ggmap)

#8-2 "서울"을 지도에 표시하기
#google API 키 등록
register_google(key="AIzaSy,,,,,,,~,,,,,,ITuos")     #구글 API 키 등록

#get_map()함수 이용
map <-get_map(location ="서울")
ggmap(map)

#get_googlemap() 함수 이용
map1 <-get_googlemap(center ="서울")
ggmap(map1)

#qmap() 함수를 이용
qmap("서울")


#8-3 "서울"의 위도와 경도를 이용하여 지도 출력하기
qc<-geocode(enc2utf8("서울울"))
qc
cen<-as.numeric(qc)
cen
map<-get_googlemap(center=cen)
ggmap(map)
map<-get_googlemap(center=cen)
ggmap(map)


#8-4 geocode() 함수의 파라메터에 따른 출력결과
#지역명으로 위도와 경도 좌표 얻기
geocode(location = '서울시청',
        output = 'latlon',
        source = 'google')
#지역명으로 위도와 경도 좌표 및 주소 얻기
geocode(location = '서울시청',
        output = 'latlona',
        source = 'google')
#한글 주소를 얻는 방법
#enc2utf8() 함수에 지역명과 '&language=ko'를 붙여써서 지정
geocode(location = enc2utf8(x = '서울시청&language=ko'),
        output = 'latlona',
        source = 'google')
# 'output' 인자에 'more'를 할당
geocode(location = '서울시청',
        output = 'more',
        source = 'google')


#8-5 get_googlemap() 함수의 네가지 지도 유형
gc <- geocode(enc2utf8("강남구"))
gc
cen <- as.numeric(gc)
cen
#maptype="terrain"
map <-get_googlemap(center=cen, maptype="terrain")
ggmap(map)

#maptype="satellite"
map <-get_googlemap(center=cen, maptype="satellite")
ggmap(map)

#maptype="roadmap"
map <-get_googlemap(center=cen, maptype="roadmap")
ggmap(map)

#maptype="hybrid"
map <-get_googlemap(center=cen, maptype="hybrid")
ggmap(map)


#8-6 지도의 크기설정 및 확대와 축소
gc <-geocode(enc2utf8("강남구구"))
gc
cen <-as.numeric(gc)
cen
#size = (320,320) 으로 설정
map <-get_googlemap(center=cen, maptype="roadmap", size=c(320,320))
ggmap(map)

#size = (320,320) 으로 설정, zoom=8
map <-get_googlemap(center=cen, maptype="roadmap", size=c(320,320),zoom=8)
ggmap(map)


#8-7 지도의 컬러 변경
gc <-geocode(enc2utf8("강남구"))
gc
cen <-as.numeric(gc)
cen
#color : 기본값
map <-get_googlemap(center=cen, maptype="roadmap")
ggmap(map)
#color='bw'로 설정
map <-get_googlemap(center=cen, maptype="roadmap", color='bw')
ggmap(map)


#8-8 extent 파라메터 설정에 의한 지도출력
gc <-geocode(enc2utf8("강남구"))
gc
cen <-as.numeric(gc)
cen
map <-get_googlemap(center=cen, maptype="roadmap")
# extent = 'panel'
ggmap(map)
# extent = 'normal'
ggmap(map, extent = 'normal')
# extent = 'device'
ggmap(map, extent = 'device')


#8-9 지도에 마커 출력하기
gc<-geocode(enc2utf8("서울시청"))
gc
cen<-as.numeric(gc)
cen
map<-get_googlemap(center = cen, maptype="roadmap", marker=gc)
ggmap(map)


#8-10 여러 개의 마커 출력하기
names <- c("북한산국립공원","설악산국립공원","오대산국립공원","치악산국립공원",
           "태백산국립공원원")
gc <- geocode(enc2utf8(names))
#지명이름, 경도, 위도가 포함된 데이터 프레임 생성
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 8,
                     marker = gc)        # 지도 위에 각 위치마다 마커 표시
ggmap(map)



#8-11 마커에 명칭 출력하기
library(ggplot2)
names <- c("북한산국립공원","설악산국립공원","오대산국립공원","치악산국립공원",
           "태백산국립공원원")
gc <- geocode(enc2utf8(names))
#지명이름, 경도, 위도가 포함된 데이터 프레임 생성
df <- data.frame(name = names, lon = gc$lon, lat = gc$lat)
cen <- c(mean(df$lon), mean(df$lat))
map <- get_googlemap(center = cen,
                     maptype = 'roadmap',
                     zoom = 8,
                     marker = gc)        # 지도 위에 각 위치마다 마커 표시
gmap <- ggmap(map)
# '+' 기호를 이용하여 geom_text() 함수를 추가
gmap + geom_text(data =df,
                 aes(x = lon, y =lat),     #축설정
                 size =3,
                 label = df$name)          #지명 이름으로 라벨링링
