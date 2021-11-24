#10-1 워드클라우드에 필요한 패키지 설치
install.packages("tm")              #text mining
install.packages("SnowballC")       #text stemming
install.packages("wordcloud")       #word-cloud
install.packages("RColorBrewer")    #color palettes

#10-2 패키지 로드 및 파일 읽기
library(tm)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)

readtxt <- readLines("obama.txt")

#10-3 데이터 정제
#Corpus 생성
txt <- Corpus(VectorSource(readtxt))
#내용확인
inspect(txt)

#데이터정제
#공백제거
txt <- tm_map(txt,stripWhitespace)
#소문자로변경
txt <- tm_map(txt, tolower)
#숫자 제거
txt <- tm_map(txt, removeNumbers)
#불용어 제거
txt <- tm_map(txt, removeWords, stopwords("english"))
#구두점 제거
txt <- tm_map(txt, removePunctuation)
#어근 추출: SnowballC 패키지 필요
txt <- tm_map(txt, stemDocument)


#10-4 DTM 생성 및 단어의 데이터 프레임 생성
#DTM 생성
dtm <- DocumentTermMatrix(txt)
#행렬로 변환
mat_DTM=as.matrix(dtm)
#단어의 빈도에 의한 내림차순정렬
sort_mat_DTM=sort(colSums(mat_DTM),decreasing = TRUE)
#데이터 프레임 생성
word_df=data.frame(word=names(sort_mat_DTM),freq=sort_mat_DTM)


#10-5단어의 빈도 막대그래프
library(ggplot2)
library(dplyr)
word_df %>% 
  filter(freq>3) %>%                     #빈도가 3이상인단어만추출
  ggplot(aes(reorder(word,freq),freq))+  #빈도로 정렬
  geom_col()+
  xlab(NULL)+
  coord_flip()                           #수평그래프


#10-6 단어의 워드클라우드
wordcloud(words=word_df$word,
          freq=word_df$freq,
          max.words=100,                      #최대 100개의 빈도 
          random.order=FALSE,                 #단어 빈도에 따라 중앙부터 출력
          rot.per=0.35,                       #수직으로 보여줄 단어 : 35%
          colors=brewer.pal(8, "Dark2"))
