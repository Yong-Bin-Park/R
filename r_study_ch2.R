x<-6
a<-x^2
b<-x*4
y1<-5
y2<-8
a2<-y1*y2
b2<-2*(y1+y2)
if(a2>a) {
  print("TRUE")
}
a<-1:100
b<-101:200
a_even<-a[seq(2,100,2)]
b_3times<-b[seq(2,100,3)]
sum(a>40 & a<70)
sum(b)
max(a)
min(a)
b<-b[b%%5==0]*2  # 5의 배수의 값만을 2배시키는건 잘모르겠다 
#지금한것은 5의 배수의값을 추출하여 2배시킨것


#변수명의 첫 글자는 영문자와 마침표(.)로 시작해야 한다.
x1_<-7
x1_
.info<-5
.info
_x1<-7    #error
1x<-5     #error


#대소문자를 구별한다.
x<-7
x
X     #소문자에 넣었는데 대문자로 불러들여서 에러

#언더바(_), 마침표(.)를 제외한 특수문자를 사용할 수 없다.
x_<-5
x_
x@<-5   #error


#변수명 중간에 빈칸을 넣을 수 없다.
x 1<-5   #error



#예약어는 변수명으로 사용할 수 없다.
for<-5   #error
if<-5   #error


#seq()함수를 이용한 벡터의 생성
v1<-seq(from=1,to=5,by=1)  #1을 시작값으로 1씩 증가해서 5를 마지막 값으로

v1
v2<-seq(1,5,1)
v2
v3<-seq(1,5)
v3
v4<-seq(10,20,2)
v4
v5<-seq(100,101,0.1)
v5


#rep()함수를 이용한 벡터의 생성
v1<-rep(1:3,times=3)    #(1,2,3)벡터를 3번 반복해서 벡터 v1 생성
v1
v2<-rep(1:3,each=3)    #(1,2,3)벡터의 개별 원소를 3번 반복해서 벡터 v2 생성
v2
v3<-rep(c(1:3),times=2)
v3
v4<-rep(c(1:3),each=2)
v4


#2-19 팩터 생성 예
#범주형 벡터와 레벨 벡터를 생성해서 팩터 생성
x=c('male','female','female','female','male')
x
class(x)
glevel=c('male','female')    #레벨 벡터 생성
glevel
class(glevel)
gender1 <- factor(x, levels=glevel)     #팩터 생성
gender1
class(gender1)
#범주형 벡터와 레벨 벡터를 factor() 함수에 직접 적용
gender2 <- factor(c('male','female','female','female','male'),c('male','female'))
gender2
class(gender2)
#팩터 생성 시 레벨을 생략한 경우: 범주형 벡터를 이용해 자동 생성
gender3 <- factor(c('male','female','female','female','male'))
gender3
class(gender3)


#2-20 팩터 함수 예
nlevels(gender1)
levels(gender1)
is.factor(gender1)


#2-21 팩터의 값 활용하기
gender1[1]                       #gender1[1]의 값 확인
gender1[1]<-"female"            #gender[1]의 값 변경
gender1                        #변경된 값 확인
gender2[2:3]
gender2[2:3]<-c("male","male")
gender2
gender3[6]<-"female"             #gender3의 마지막 위치에 데이터 삽입
gender3                         #삽입된 값 확인
gender3[7] <- "girl"           #레벨에 없는 값을 삽입:에러발생 NA 생성
gender3


#2-22 레벨의 변경과 팩터 데이터의 추가
levels(gender3) <-c("male","female","girl")    #레벨의 변경
levels(gender3)                                #변경된 레벨 확인
gender3[7] <- "girl"                         #gender3에 새로운 데이터 삽입
gender3                                    #삽입된 값 확인


#2-23 팩터의 숫자데이터 변경
levels(gender3)
as.integer(gender3)         #levels에 나오는 문자열 순서대로 숫자가 된다.


#2-26matrix()의 행과 열에 이름 부여하기
x<- matrix(seq(1:15),3,5)
x
rownames(x)<-c("first","second","third")      #매트릭스 x의 행에 이름부여
colnames(x)<-c("t1","t2","t3","t4","t5")     #매트릭스 x의 열에 이름부여
x
rownames(x)                 #행 이름 확인
colnames(x)                 #열 이름 확인
ncol(x)                   #열의 수
nrow(x)                   #행의 수
dim(x)                    #매트릭스 x의 차원 확인


#2-28 배열 만들기
x=array(1:24,c(3,2,4))   #1부터 24까지의 수를 3행 2열로 4개의 차원만들기
x
dim(x)


#2-29 배열의 원소 값 추출
#코드 [2-28]의 배열 x를 이용
x[1,2,1]            #매트릭스 1의 1행 2열의 값
x[,,2]              #매트릭스 2의 모든행과 모든열의 값
x[2,,2]             #매트릭스 2의 2행의 모든 열의 값
x[,1,3]             #매트릭스 3의 1열의 모든 행의 값


#2-30 데이터 프레임 만들기
#벡터생성 후 데이터 프레임 만들기
name <-c("김철수","이수지","유소영","장일순")
kor <-c(96,94,84,67)
eng <-c(97,92,85,79)
math<-c(93,88,86,68)
grade <-factor(c("A","A","B","C"))
score<-data.frame(name,kor,eng,math,grade,stringsAsFactors = FALSE)
score


#2-31 데이터 프레임 기본조작(1)
#코드 [2-30]의 score 데이터 프레임 이용
rownames(score)<-c("st1","st2","st3","st4")    #score에 이름부여하기
rownames(score)
ncol(score)            #score의 열의 개수 확인
nrow(score)            #score의 행의 개수 확인


#2-32 데이터 프레임 기본조작(2)
#코드 [2-30]의 score 데이터 프레임 이용
number<-c("201101","201102","201103","201104")
number
score<-cbind(score,number,stringsAsFactors = FALSE)
score
st5<-c("이광일",88,78,82,"B","201105")
score<-rbind(score,st5,stringsAsFactors = FALSE)
score


#2-33 데이터 프레임 기본조작(3)
#코드 [2-30]의 score 데이터 프레임 이용
score$name        #name열 출력
score[1,]         #1행 출력
score[,3]         #3열 출력
#score의 name열이 "이수지"인 행 출력
score[score$name =="이수지"]
#score의 name열이 "이광일"인 경우 "kor"과" math" 출력
score[score$name=="이광일",c("kor","math")]


#2-34 리스트 만들기(1)
data1 <- 1:4          #벡터 data1 생성
data2 <- matrix(1:6,3, byrow=T)    #매트릭스 data2 생성
data3 <- array(1:24,c(3,4,2))      #배열 data3 생성
# 데이터 프레임 data4 생성
data4 <- data.frame(id=c(1,2,3,4), name=c("LEE","PARK","KIM","SHIN"))
list1 <- list(data1,data2,data3,data4)       #리스트 list1 생성
list1


#2-35 리스트 만들기(2)
#코드 [2-34]의 data1~data4 사용
#리스트 list2 생성: 각 데이터에 이름을 부여
list2 <- list(data1=data1,data2=data2,data3=data3,data4=data4)
list2


#2-36 리스트 원소 접근하기
#코드 [2-35]의 list2이용
#list2의 data1에 접근하는 다양한 방법
list2$data1             #$와 원소의 이름 입력
list2[[1]]              #원소의 인덱스 입력
list2[["data1"]]        #[[]]에 "이름" 입력
