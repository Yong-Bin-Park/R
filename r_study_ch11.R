#11-1 데이터 파일 읽어 데이터 구조 알아보기
birth<-read.csv("202007_birth.csv", header=TRUE,sep=",")        #파일읽기기
class(birth)
str(birth)
summary(birth)
head(birth)

#11-2 1행 제거와 컬럼 이름 변경
library(dplyr)
#1행 제거
new_birth <- birth
new_birth <- new_birth[-1,]
#컬럼이름 변경
new_birth <- new_birth %>% 
  rename("남자"="X2020년07월_남자인구수",
         "여자"="X2020년07월_여자인구수",
         "계"="X2020년07월_계")
head(new_birth)

#11-3 행정구역 컬럼의 () 데이터 제거
for (i in c(1:length(new_birth$"행정구역")) ) {
  new_birth$행정구역[i] <- strsplit(new_birth$행정구역[i],split=" ")[[1]][1]
}
head(new_birth)

#11-4 남자, 여자, 계 칼럼의 type 변환
for(i in c(1:length(new_birth$남자))) {
  new_birth$'남자'[i] <- gsub(',','',new_birth$'남자'[i])
  new_birth$'여자'[i] <- gsub(',','',new_birth$'여자'[i])
  new_birth$'계'[i] <- gsub(',','',new_birth$'계'[i])
}
new_birth$'남자'=as.numeric(new_birth$'남자')
new_birth$'여자'=as.numeric(new_birth$'여자')
new_birth$'계'=as.numeric(new_birth$'계')
str(new_birth)


#11-5 행정구역별 출생 인구의 막대그래프
library(ggplot2)
ggplot(data=new_birth, aes(x=행정구역,y=계)) +
  geom_bar(stat='identity') +
  coord_flip() +
  ggtitle("행정구역별 인구 출생수:2020년 7월") +
  labs(x='행정구역',y='인구수') +
  theme(plot.title=element_text(size=17, face='bold', color = 'blue',hjust=0.5))


#11-6 행정구역별 출생 인구의 막대그래프-정렬
ggplot(data=new_birth, aes(x=reorder(행정구역,계),y=계)) +
  geom_bar(stat='identity') +
  coord_flip() +
  ggtitle("행정구역별 출생인구 :2020년 7월") +
  labs(x='행정구역',y='인구수') +
  theme(plot.title=element_text(size=17, face='bold', color = 'blue',hjust=0.5))


#11-7 행정구역별 남/여 출생인구수의 선그래프
ggplot(data=new_birth, aes(x=행정구역,y=남자,group=1)) +
  geom_line(color='blue') +
  geom_line(aes(y=여자), color='red') +
  ggtitle("행정구역별 출생인구 :2020년 7월") +
  labs(x='행정구역',y='인구수') +
  theme(plot.title=element_text(size=17, face='bold', color = 'blue',hjust=0.5),
        axis.text.x = element_text(face='bold',angle = 90, hjust = 1, vjust = 0.5))


#11-8 남아와 여아 출생 인구비율의 파이 챠트
rate <- c(mean(new_birth$남자),mean(new_birth$여자))
rate <- round(rate/(rate[1]+rate[2]),2)
names(rate) <- c("남아","여아")
pie(rate, col=round(rate*5),labels = paste(names(rate),round(rate*100),'%'))


#11-9 전체 출생 인구수와 행정구역으로 데이터 프레임 생성
library(ggmap)
library(ggplot2)
#google API 키 등록
register_google(key="AIzaSyDFnHiauDjCBHd9gmeCbCePVU5Y9xITuos")

t_birth <- new_birth[,c(1,4)]      #행정구역과 인구수로 데이터 프레임 생성
head(t_birth)


#11-10 행정구역의 위도와 경도 구하기
#위도와 경도를 합한 데이터 프레임 생성
cities <- t_birth$행정구역
gc <- geocode(enc2utf8(cities))
df <- data.frame(지역명=cities,
                    인구수=t_birth$계,
                    lon=gc$lon,
                    lat=gc$lat,
                    stringsAsFactors=F)
df[df$지역명=='세종특별자치시',]
df[df$지역명=='세종특별자치시',3] = (df[df$지역명=="충청남도",3]+df[df$지역명=="충청북도",3])/2
df[df$지역명=='세종특별자치시',3]


#11-11 지도 그리기
#지도의 중심점 구하기
cen <- c(mean(df$lon), mean(df$lat))

#지도 그리기
map <- get_googlemap(center= cen, zoom=7)
gmap <- ggmap(map)

#버블표시하기
s=(df$인구수/(max(df$인구수)-min(df$인구수)))
gmap +
  geom_point(data= df,
             aes(x=lon,y=lat),
             color = rainbow(length(df$인구수)),
             size=s*10)


#11-12 XML 패키지 설치 및 로드
install.packages("XML")
library(XML)


#11-13 XML패키지 설치 및 로드
uri <- "http://openapi.seoul.go.kr:8088/sample/xml/CardSubwayStatsNew/1/1000/20200801"
uri

#11-13(1) URI 구성하기
base_url <- 'http://openapi.seoul.go.kr:8088'
apikey <- '4f4e4461636479643637685a454163'
type <- 'xml'
service <- 'CardSubwayStatsNew'
start_index <- 1
end_index <- 1000
used_dt <- '20200801'
uri <- paste(base_url,apikey,type,service,start_index,end_index,used_dt,sep='/')
uri


#11-14 웹데이터 가져오기
xmldata <- xmlParse(uri)
xmlRoot(xmldata)


#11-15 데이터 프레임 생성하기
subway_df <- xmlToDataFrame(getNodeSet(xmldata,"//CardSubwayStatsNew /row"))
head(subway_df,3)
str(subway_df)
summary(subway_df)


#11-16 데이터를 정제한 데이터 프레임
df <- subway_df[,c(-1,-6)]
names(df) <- c("Line","station","ride","alight")
df$ride <- as.numeric(df$ride)
df$alight <- as.numeric(df$alight)
str(df)


#11-17 호선별 승하차 인원 평균으로 구성된 데이터 프레임 생성하기
library(dplyr)
Line_df <- df %>% 
  group_by(Line) %>% 
  summarise(m_ride=mean(ride), m_alight=mean(alight))
str(Line_df)


#11-18 호선별 승하차인원 막대그래프 그리기
#승차인원 그래프
ggplot(data=Line_df,aes(x=reorder(Line,m_ride),y=m_ride,fill=rainbow(length(Line)))) +
  geom_bar(stat='identity') +
  coord_flip() +
  ggtitle("2020년 8월 1일 지하철 승차인원") +
  labs(x='호선',y='인원') +
  theme(plot.title=element_text(size=17, face='bold', color='blue',hjust=0.5))

#하차인원 그래프
ggplot(data=Line_df,aes(x=reorder(Line,m_alight),y=m_alight,fill=rainbow(length(Line)))) +
  geom_bar(stat='identity') +
  coord_flip() +
  ggtitle("2020년 8월 1일 지하철 하차인원") +
  labs(x='호선',y='인원') +
  theme(plot.title=element_text(size=17, face='bold', color='blue',hjust=0.5))


#11-19 호선별 승하차인원 선그래프 그리기
ggplot(data=Line_df,aes(x=Line,y=m_ride,group=1)) +
  geom_line(color='blue') +
  geom_line(aes(y=m_alight), color='red') +
  ggtitle("2020년 8월 1일 지하철 승하차 인원") +
  labs(x='호선',y='인원') +
  theme(plot.title=element_text(size=17, face='bold', color='blue',hjust=0.5),
        axis.text.x = element_text(face='bold',angle = 90, hjust = 1, vjust =0.5))
