install.packages("ggplot2")
library(ggplot2)
#패키지 부착

ggplot(data = mtcars)

#aes()함수를 이용한 x축, y축 데이터 지정
ggplot(data = mtcars, map = aes(x = disp, y = mpg))
#ggplot(data = mtcars,aes(x = disp, y = mpg)) 
#ggplot(data = mtcars, mapping = aes(x = disp, y = mpg))  같은 예임

#7-2 geom_point() 함수 추가하기
ggplot(data = mtcars,aes(x=disp, y=mpg)) + geom_point()

#7-3 aes()함수의 파라메터 설정을 이용한 그래프 꾸미기
ggplot(data = mtcars,aes(x=disp, y=mpg)) + geom_point(aes(color='red',size=3))

#7-4 그래프에 다양한 설정 적용하기
ggplot(data = mtcars,aes(x=disp, y=mpg)) + geom_point()+
  xlim(30,500) +    #x축 데이터 범위
  ylim(10,40) +     #y축 데이터 범위
  theme_bw()+       #배경테마를 변경
  ggtitle("mpg&disp scatter point")    #그래프의 제목 설정

#7-5 그래프 제목 및 축 제목 등의 상세 설정
ggplot(data = mtcars,aes(x=disp, y=mpg)) + geom_point()+
  xlim(30,500) +    #x축 데이터 범위
  ylim(10,40) +     #y축 데이터 범위
  theme_bw()+       #배경테마를 변경
  ggtitle("mpg&disp scatter point")+    #그래프의 제목 설정
  labs(x='배기량',y='연비') +
  theme(plot.title=element_text(size=17, face='bold',color='violetred',hjust=0.5),
        #그래프 제목의 크기, 컬러, 위치 조정  (hjust(가로))
        axis.title=element_text(size=13),      #x축 제목의 크기 변경
        axis.title.y=element_text(angle=0,vjust=0.5))      #y축 제목의 위치변경(vjust(세로))

#7-6 x축 값만 지정한 막대그래프
ggplot(data=mtcars, aes(cyl))+ geom_bar()

#7-7 x축 y축 값을 모두 지정한 막대그래프
ggplot(data=Orange, aes(x=age, y=circumference))+
  geom_bar(stat='identity',width=80,fill='red')

#7-8 막대그래프의 상세 설정
ggplot(data=Orange, aes(x=age, y=circumference))+
  geom_bar(stat='identity',width=80,fill='green')+
  ggtitle('나무의 나이에 따른 나무둘레')+
  labs(x='나무의 나이',y='나무둘레')+
  theme(plot.title=element_text(size=20,face='bold',color='violetred',hjust=0.5),
        axis.title=element_text(size=15),
        axis.title.y=element_text(angle=0,vjust=0.5))

#7-9 데이터의 종류를 한 그래프 안에 나눠서 표시
ggplot(data=Orange, aes(x=age, y=circumference,fill=Tree))+
  geom_bar(stat='identity')

#7-10 e데이터의 종류를 나눠 다른 위치에 표시
ggplot(data=Orange, aes(x=age, y=circumference,fill=Tree))+
  geom_bar(stat='identity',position='dodge')

#7-11 막대그래프를 수평으로 그리기
ggplot(data=Orange, aes(x=age, y=circumference,fill=Tree))+
  geom_bar(stat='identity') +
  coord_flip()


#7-12 mpg를 히스토그램으로 그리기
ggplot(data=mtcars, aes(mpg))+
  geom_histogram(binwidth=2)

#7-13 히스토그램 상세설정
ggplot(data=mtcars, aes(mpg))+
  geom_histogram(fill='yellow',color='green',binwidth=2)+
  ggtitle('연비의 히스토그램')+
  labs(x='연비',y='빈도')+
  theme(plot.title=element_text(size=20, face='bold',color='violetred',hjust=0.5),
        axis.title=element_text(size=15),
        axis.title.y=element_text(angle=0,vjust=0.5))

