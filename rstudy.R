#167p 3번
class(quakes)
head(quakes)
stem(quakes$lat) #위도
stem(quakes$long) #경도

#강도에 대한 히스토그램
mag<-quakes$mag
hist(mag)

hist(mag, breaks=seq(4,6.5,by=0.5)) #지진강도를 4~6.5까지 0.5간격으로

boxplot(quakes$mag)
boxplot(quakes$mag)$stats


#167p 4번
help(women)
str(women) #구조와 열이름 확인

plot(women)#선그래프

#168p 5번
str(iris)
summary(iris)
boxplot(iris$Petal.Length)

sl<-iris$Sepal.Length
sw<-iris$Sepal.Width
pl<-iris$Petal.Length
pw<-iris$Petal.Width
data<-data.frame(sl,sw,pl,pw)
pairs(data,main="iris 데이터셋의 산점도 표현")


#168p 6번
install.packages("readxl")
setwd("C:/Users/dydql/OneDrive/문서")
library(readxl)
grade=read_excel("grade.xlsx") #엑셀파일 읽기
str(grade) #파일 구조와 열이름 출력
grade2<-table(grade$grade) #grade의 빈도 구하기
barplot(grade2)  #막대그래프로 표현

pct <- round(grade2/sum(grade2)*100.0)
pie(grade2, main="변수의 값을 파이챠트로 표현",
    col=rainbow(length(grade2)))  #파이챠트로 표현

#변수의 값을 히스토그램으로 표현 단, 2행2열로
par(mfrow=c(2,2))
hist(grade$korea)
hist(grade$english)
hist(grade$math)
hist(grade$avg)

#변수의 값을 한화면의 선그래프로 표현, 범례추가
par(mfrow=c(1,1)) #전단계에서 2행2열로 나눴던것을 다시 한칸으로 만듬
plot(grade$korea,type='o',col='red',pch=1,lty=1,xlab='x',ylab='y')
lines(grade$english,type='o',col='green',pch=2,lty=2)
lines(grade$math,type='o',col='blue',pch=3,lty=3)
lines(grade$avg,type='o',col='black',pch=4,lty=4)
#범례추가하기
legend("topright",legend=c("korea","english","math","avg"),
       col=c("red","green","blue","black"),cex=0.8,pch=1:4,lty=1:4)

#168p 7번
install.packages("ggplot2")
setwd("C:/Users/dydql/OneDrive/문서")
library(ggplot2)
df_mpg <- as.data.frame(ggplot2::mpg) #ggplot2의 mpg데이터를 데이터 프레임 형태로 불러오기
str(df_mpg)
help(mpg) #데이터셋의 내용조사

#변수 'cyl','drv','fl'의 값을 막대그래프로 표현 단, 1행 3열의 그래프로 한화면의 출력
par(mfrow=c(1,3))
cyl2<-table(df_mpg$cyl)
drv2<-table(df_mpg$drv)
fl2<-table(df_mpg$fl)
barplot(cyl2)
barplot(drv2)
barplot(fl2)

#변수 class값을 원그래프로 표현하고 어느정도 비율인지 나타내시오.
par(mfrow=c(1,1))
class2<-table(df_mpg$class)
pct <-round(class2/sum(class2)*100.0)
class2_lable <- paste("class ", names(class2))
class2_lable <- paste(class2_lable, ':',pct, "%")
pie(class2,labels=class2_lable,col=rainbow(length(class2)))

#'hwy'의 값을 히스토그램으로 표현
hwy <- df_mpg$hwy
hist(hwy)

#cty와 displ 변수의 산점도를 그리고 관계를 분석
cty <- df_mpg$cty
displ <- df_mpg$displ
data <- data.frame(cty,displ)
pairs(data,col='red',main="cty와 displ의 산점도 분석")


#연료의 종류(fl)에 따른 배기량(displ)과 도시연비(cty)를 산점도로 표현, 범례추가
fl <- as.factor(df_mpg$fl)
fl_var <-as.numeric(fl)
color <- rainbow(5)
plot(displ,cty,main="연료의 종류(fl)에 따른 배기량(displ)과 도시연비(cty)",
     pch=(fl_var),col=color[fl_var])
legend("topright",legend=c("c","d","e","p","r"),
       col=color,cex=1,pch=1:5)


#고속도로 연비(hwy)와 도시연비(cty)에 따른 배기량의 변화를 버블그래프로 표현
bubble <-sqrt(df_mpg$disp/pi)
symbols(df_mpg$hwy,df_mpg$cty, bubble, fg="white",bg="red", inches=0.3,
        main="연비와 도시연비에 따른 배기량의 변화",xlab="연비",ylab="도시연비")


#구동방식(drv)에 따른 도시연비(cty)를 상자그림으로 표현
boxplot(formula=cty~drv,data=df_mpg,col=c("yellow","green"))
