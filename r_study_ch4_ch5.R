a<-scan()
1
1
3 4 5

b=scan(what="")
a
bcd

readline()
1 2 3 4 5
x<-readline()
1 2 3 4 5
x

install.packages("readxl")
library(readxl)
data<-read_excel("grade.xlsx")
data


#4-22 regexpr() 함수
number<-c("2020011042","2019010015","2020009030","2018011024")
regexpr("2020",number)
regexpr("R"," I love R. R is very good!!")

#4-23 gregexpr() 함수
number<-c("2020011042","2019010015","2020009030","2018011024")
gregexpr("2020",number)

#5-4 mpg 데이터의 히스토그램 구하기
mpg<-mtcars$mpg
hist(mpg)             #첫 번째 히스토그램
#breaks : 히스토그램 계급의 구간 main : 글미의 제목 xlab:x축 제목, ylab:y축 제목
hist(mpg, breaks=seq(10,34,by=6), col=rainbow(4),main="mpg의 히스토그램", xlab = "연비",
     ylab="측정값")     #두 번째 히스토그램램


#5-5 gear의 수에 따른 자동차종 빈도 구하기
gear<-table(mtcars$gear)          #gear의 빈도 구하기
#막대그래프 구하기
barplot(gear, main="gear의 수에 의한 자동차의 수",
        xlab="gear",ylab="자동차수",col=rainbow(length(gear)))
#수평 막대그래프 구하기
barplot(gear, main="gear의 수에 의한 자동차의 수",
        xlab="gear",ylab="자동차수",col=rainbow(length(gear)),xlim=c(0,16),horiz=TRUE)



#5-6 파이챠트로 gear의 수에 따른 자동차의 비율 파악하기
gear <-table(mtcars$gear)
pct <-round(gear/sum(gear)*100.0)
#pie 챠트에 표시할 레이블 값 생성
for (i in 1: length(gear)) {
  gear_lable[i] <-paste("gear " ,as.character(i+2),':', pct[i],"%")
}
pie(gear, main="gear의 수에 의한 자동차의 점유율",
    labels = gear_label,col=rainbow(length(gear)))



#5-8 산점도 행렬을 이용한 자동차 특성 분석
mpg<-mtcars$mpg
cyl<-mtcars$cyl
wt<-mtcars$wt
hp<-mtcars$hp
data<-data.frame(mpg,cyl,hp,wt)
pairs(data,main="자동차 산점도 행렬",col='red')


#5-9 sepal.width와 sepal.length의 품종별 산점도
iris_SL <- iris$Sepal.Length
iris_SW <- iris$Sepal.Width
species <- as.numeric(iris$Species)             #품종을 숫자로 변경: 색과 pch 표현
color <- c("red","green","blue")
plot(iris_SW,iris_SL,main="Spepal.Width와 Sepal.Length의 품종별 산점도",
     pch=(species),col=color[species])

#5-10 무게와 연비에 따른 배기량
bubble <-sqrt(mtcars$disp/pi)
symbols(mtcars$wt, mtcars$mpg,bubble, fg="white",bg="red", inches=0.3,main="중량과
        연비에 따른 배기량",xlab="중량",ylab="연비비")



boxplot(mtcars$mpg)
boxplot(mtcars$mpg)$stats             #처음부터 하위경계값,1사분위수, 2사분위수(중앙값),
                                      #3사분위수, 상위 경계값



#5-11 변속기어에 따른 연비의 분포
boxplot(formula=mpg~am,data=mtcars,
        col=c("yellow","green"),           #그룹별 색상 지정
        xlim=c(0.5,2.5),                   #x축y축 범위 지정
        ylim=c(5,40),
        main="Box plot",                   #제목 지정
        xlab="Transmission",
        ylab="Miles/(US) gallon",
        names=c("automatic","manual"))     #names= 범주 이름


#5-12 선그래프 모양
par(mfrow=c(3,3))                 #그래프의 배치 설정 c(행의 수, 열의 수)
x=1:10
y=c(10,20,30,40,50,60,70,80,90,100)

plot(x,y,type='p', main= "type='p'(점)")
plot(x,y,type='l', main= "type='l'(선)")
plot(x,y,type='b', main= "type='b'(점과 선)")
plot(x,y,type='c', main= "type='c'('b'의 선)")
plot(x,y,type='o', main= "type='o'(점 위의 선)")
plot(x,y,type='h', main= "type='h'(수직선)")
plot(x,y,type='s', main= "type='s'(계단형)")
plot(x,y,type='S', main= "type='S'(계단형)")
plot(x,y,type='n', main= "type='n'(나타나지 않음)")


#5-14 선그래프의 중첩과 범례표시
x=1:10
y1=c(10,20,30,40,50,60,70,80,90,100)
y2=c(5,15,25,35,45,55,65,75,85,95)
y3=c(23,14,7,36,87,92,68,51,77,46)
xrange<-c(0,10)
yrange<-c(0,100)
#빈그래프 생성: 그래프의 틀 만들기 type='n'
plot(xrange,yrange,type='n',xlab='x',ylab='y',main="선그래프의 중첩과 범례표시")
lines(x,y1,type='o',col='red',pch=1, lty=1)   #x-y1그래프 추가하기
lines(x,y2,type='o',col='green',pch=2, lty=2)   #x-y2그래프 추가하기
lines(x,y3,type='o',col='blue',pch=3, lty=3)   #x-y3그래프 추가하기

#범례 추가하기
legend(xrange[1],yrange[2],legend=c("Y1","Y2","Y3"),col=c("red","green","blue"),
       cex=0.8,pch=1:3,lty=1:3)


#5-15선그래프를 이용한 나이의 변화에 따른 다섯종의 오렌지 나무의 성장
tree<-as.numeric(Orange$Tree)
xrange <- range(Orange$age)
yrange <- range(Orange$circumference)

plot(xrange,yrange,type='n',xlab="Age",ylab="Circumference")
n<-max(tree)
colors<-rainbow(n)
linetype <- c(1:n)
pchs<-c(1:n)

for( i  in  1:n) {
  temp <- subset(Orange,Tree==i)
  lines(temp$age, temp$circumference, type='b',
        lwd=2,lty=linetype[i],
        col=colors[i],pch=pchs[i])
}

title("Tree Growth graph")

legend(xrange[1],yrange[2],legend=1:n,
       col=colors,cex=0.8,pch=pchs,lty=linetype)
