#3-1 if~else 문을이용한 짝수 판별
x<-10
if(x%%2==0) {
  print('x는 짝수')
} else {
  print('x는 홀수')
}

blood <- 'B'
if(blood == 'A'){
  print("혈액형은 A형")
} else if(blood == 'B'){
  print("혈액형은 B형")
} else if(blood == 'AB'){
  print('혈액형은 AB형')
} else {
  print("혈액형은 O형")
}

# p.89
x <- 10
even <- ifelse(x%%2 == 0, 'x는 짝수', 'x는 홀수')
print(even)

# p.90
for(i in 1:5){
  print('x')
}

sum <- 0
for(i in 1:10){
  sum <- sum+i
  print(sum)
}

# p. 92
data <- mtcars
class(data)
ncol(data)
colnames(data)
c_name <- colnames(data)
class(c_name)
for( name in c_name){
  print(name)
}

# p.94
sum <- 0
i <- 1
while(i <= 10){
  sum <- sum+i
  print(sum)
  i <- i+1
}

#3-16 두 수를 더하는 함수 add()의 작성과 실행
#add 함수 작성
add<-function(x,y){
  result<-x+y
}
#add 함수의 실행
z<-add(3,5)         #함수의 결과값을 변수에 저장
print(z)


#3-17 함수의 기본값 설정하기
add<-function(x,y){
  result<-x+y
  return (result)
}
z<- add(3)      #error 기본값이 없는 인수 "y"가 누락

#기본값 설정
add<-function(x,y=5){
  result<-x+y
  return (result)
}
z<-add(3)
print(z)
z1<-add(3,10)
print(z1)


calc<-function(x,y=5){
  add<-x+y
  sub<-x-y
  mul<-x*y
  div<-x/y
  return (list(add=add,sub=sub,mul=mul,div=div))    #결과를 리스트로 변환
}
result1<-calc(3,5)
print(result1)

#결과 활용하기
add<-result1$add
sub<-result1$sub
mul<-result1$mul
div<-result1$div
cat('add:',add,' sub:',sub,' mul:',mul,' div:',div)


#3-20 mtcars 데이터셋의 기본 정보 확인하기
dim(mtcars)            #차원을 출력
nrow(mtcars)           #행의 수를 출력
ncol(mtcars)           #열의 수를 출력
colnames(mtcars)       #열의 이름을 출력
rownames(mtcars)       #행의 이름을 출력
head(mtcars)           #처음 6행을 출력
tail(mtcars)           #마지막 6행을 출력
str(mtcars)            #타입과 열 정보를 출력
summary(mtcars)        #열의 요약 통계량을 출력
table(mtcars[,'gear']) #'gear'의 수에 따른 빈도를 출력


#3-21 데이터의 구조 확인 및 변경하기
is.matrix(mtcars)
is.data.frame(mtcars)
x<-matrix(1:15,3,5)
class(x)
df_x<-as.data.frame(x)
class(df_x)


#3-22 apply() 함수의 적용 예
x <- cbind(x1=3,x2=c(4:1,2:5))
col.sums <-apply(x,2,sum)          #열의 합
col.sums
row.sums <-apply(x,1,sum)          #행의 합
row.sums
