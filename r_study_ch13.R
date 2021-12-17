#chapter 13 딥러닝 
# 데이터셋 정의
# 13-1 mlbench 패키지 설치와 Sonar 데이터 로드
install.packages("mlbench")
library(mlbench)

data("Sonar", package = "mlbench")

str(Sonar)

# 13-2 훈련데이터와 검증데이터 정의
ind <- c(1:50, 81:130, 151:200)

# 13-3 모델 정의 
install.packages("keras")
library(keras)

model <- keras_model_sequential() %>%
  layer_dense(units = 24, activation = 'relu', input_shape = c(60)) %>%
  layer_dense(units = 10, activation = 'relu') %>%
  layer_dense(units = 1, activation = 'sigmoid')



# 13-4 컴파일 및 환경 설정 
# 모델 컴파일
model %>% compile(
  optimizer = 'adam',
  loss = 'binary_crossentropy',
  metrics = c("accuracy")
)

# 13-5 모델 내용 확인
summary(model)

# 13-6 모델 훈련
history <- model %>% fit(
  train.x,
  train.y,
  epochs = 200,
  batch_size = 10,
  validation_data = list(test.x, test.y),
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)

# 13-7 plot 함수를 이용한 훈련 및 테스트 데이터의 결과
plot(history)

res <- model %>% evaluate(test.x, test.y, verbose = 0)
res

# 13-8 모델을 이용한 데이터 예측
model %>% predict_classes(test.x[1:10, ])

# 광석분류의 전체 코드 
install.packages("mlbench")
library(mlbench)

library(keras)

# Sonar 데이터 로딩
data("Sonar", package = "mlbench")

str(Sonar)

# 신경망의 출력 값 1과 2를 레이블 0과 1로 변경
Sonar[,61] <- as.numeric(Sonar[,61])-1

# 데이터셋을 학습데이터와 검증데이터로 분할
# 학습데이터의 인덱스
ind <- c(1:50, 81:130, 151:200)

train.x <- as.matrix(Sonar[ind,1:60])
train.y <- Sonar[ind,61]
test.x <- as.matrix(Sonar[-ind,1:60])
test.y <- Sonar[-ind,61]

model <- keras_model_sequential() %>%
  layer_dense(units = 24, activation = 'relu', input_shape = c(60)) %>%
  layer_dense(units = 10, activation = 'relu') %>%
  layer_dense(units = 1, activation = 'sigmoid')

model %>% compile(
  optimizer = 'adam',
  loss = 'binary_crossentropy',
  metrics = c("accuracy")
)

summary(model)

history <- model %>% fit(
  train.x,
  train.y,
  epochs = 200,
  batch_size = 10,
  validation_data = list(test.x, test.y),
  loss = "binary_crossentropy",
  metrics = c("accuracy")
)

plot(history)

res <- model %>% evaluate(test.x, test.y, verbose = 0)
res

model %>% predict(test.x[1:10,]) %>% `>`(0.5) %>% k_cast("int32")

# 13-9 데이터 로드와 산점도 그리기
library(keras)

# 데이터 불러오기
df_iris <- iris
# iris 특징의 산점도 행렬 그리기
pairs(~Sepal.Length + Sepal.Width + Petal.Width,
      main = "Scattor plot of Iris", pch = 21, bg = c('red', 'blue', 'green'),data=df_iris)

# 13-10 상관관계 그래프 작성하기
# 패키지 설치와 부착
install.packages('corrplot')
library(corrplot)

# 수치형 데이터를 상관관계수로 변환하기
M <- cor(df_iris[,1:4])
# 상관관계 그래프 작성하기
corrplot(M, method = 'circle')

# 13-11 데이터 정의하기
head(df_iris)
# 팩터를 수치형으로 변환
df_iris$Species <- as.numeric(df_iris$Species)-1


#데이터 프레임을 매트릭스로 변환
mat_iris <- as.matrix(df_iris)

ind <- sample(1:nrow(mat_iris), nrow(mat_iris)*0.7, replace = F)

train.x <- mat_iris[ind, 1:4]
train.y <- mat_iris[ind,5]
train.y1 <- to_categorical(train.y)
test.x <- mat_iris[-ind, 1:4]
test.y <- mat_iris[-ind, 5]
test.y1 <- to_categorical(test.y)

# 13-12 모델 정의 및 컴파일
model <- keras_model_sequential() %>%
  layer_dense(units = 16, activation = 'relu', input_shape = c(4)) %>%
  layer_dense(units = 3, activation = 'softmax')

model %>% compile(
  optimizer = 'adam',
  loss = 'categorical_crossentropy',
  metrics = c("accuracy")
)

# 13-13 모델 훈련
history <- model %>% fit(
  trin.x,
  trin.y1,
  epochs = 50,
  batch_size = 5,
  validation_data = list(test.x, test.y)
)

# 모델의 저장과 로드 
# 모델의 저장
model %>% save_model_hdf5("my_model.h5")
# 모델 로드
model <- load_model_hef5("my_model.h5")

# K겹교차 검증
# 데이터를 섞는다
ind <- samole(1:nodw(mat_iris))
# 전체 데이터를 3부분으로 나눈다.
folds <- cut(1:length(ind), breaks = k, labels = FALSE)
all_scores <- c()

n_scores <- c()

for (i in 1:k) {
  cat(i, "fold", '\n')
  #검증데이터의 인덱스
  val_ind <- ind[folds == i]
  #검증데이터와 레이블을 변수에 저장
  val_data <- mat_iris[val_ind, 1:4]
  val_label <- to_categorical(mat_iris[val_ind, 5])
  # 학습데이터와 레이블을 변수에 저장
  train_data <- mat_iris[-val_ind, 1:4]
  train_lbale <- to_categorical(mat_iris[-val_ind, 5])
  # 모델 정의 및 컴파일
  model <- keras_model_sequential() %>%
    layer_dense(units = 16, activation = 'relu', input_shape = c(4)) %>%
    layer_dense(units = 3, activation = 'softmax')
  
  model %>% compile(
    optimizer = 'adam',
    loss = 'categorical_crossentropy',
    metrics = c('accuracy')
  )
  # 모델학습
  model %>% fit(
    train_data,
    train_lbale,
    epochs = n_epochs,
    batch_size = 5
  )
  # 검증데이터에서 모델 평가
  res <- model %>% evaluate(test.x, test.y1, vebose = 0)
  # 평가 결과를 저장
  all_scores <- c(all_scores, res)
  
}

# 13-15 평가 결과 확인
all_scores

mean(all_scores$accuracy)
mean(all_scores$loss)

# 13-16 드랍아웃
ind <- sample(1:nrow(mat_iris), nrow(mat_iris)*0.7, replace = F)

train.x <- mat_iris[ind, 1:4]
train.y <- to_categorical(mat_iris[ind,5])
test.x <- mat_iris[-ind, 1:4]
test.y <- to_categorical(mat_iris[-ind,5])

model <- keras_model_sequential() %>%
  layer_dense(units = 16, activation = 'relu', input_shape = c(4)) %>%
  layer_dropout(rate = 0.2) %>%
  layer_dense(units = 16, activation = 'relu') %>%
  layer_dense(units = 16, activation = 'softmax')

model %>% compile(
  optimizer = 'adam',
  loss = 'categorical_crossentropy',
  metrics = c('accuracy')
)
# 모델학습
model %>% fit(
  train.x,
  train.y,
  epochs = 50,
  batch_size = 5,
  validation_data = list(test.x, test.y)
)

res <- model %>% evaluate(test.x, test.y, verbose = 0)
res

# 13-17 보스턴 하우징 데이터셋을 이용한 선형회귀
library(keras)

datas <- dataset_boston_housing()

# %<% 연산자를 이용해 리스트의 값을 변수에 저장 
c(c(train.x, train.y), c(test.x, test.y)) %<% datas
mean <- apply(train.x, 2, mean)
std <- apply(train.x, 2, sd)
train.x <- scale(train.x, center = mean, scale = std)
train.y <- scale(test.x, center = mean, scale = std)

# 과적합 방지
k <- 4 
ind <- sample(1:nrow(train.x))

folds <- cut(1:length(ind), breaks = k, labels = FALSE)
all_scores <- c()

n_epochs <- 100
for(i in 1:k) {
  cat(i, 'fold', '\n')
  val_ind <- ind[folds ==i]
  val-data <- train.x[val_ind,]
  val_lable <- train.y[val_ind]
  train_data <- train.x[-val_ind,]
  train_lable <- train.y[-val_ind]
  
  model <- keras_model_sequential() %>%
    layer_dense(units = 30, activation = 'relu', input_shape = c(13)) %>%
    layer_dense(units = 6, activation = 'relu')
  layer_dense(units = 1)
  
  model %>% compile(
    optimizer = 'adam',
    loss = 'mse',
    metrics = c('mae')
  )
  
  model %>% fit(
    train_data,
    train_lable,
    epochs = n_epochs,
    batch_size = 5
  )
  
  res <- model %>% evaluate(val_data, val_lable, varbose = 0)
  all_scores <- c(all_scores, res)
}

all_scores
mean(all_scores$mae)

# 보스턴 하우징 데이터의 구조
str(datas)

# %<-% 연산자를 이용해 리스트의 값을 변수에 저장
c(c(train.x, trian,y), c(test.x, test.y)) %<-% datas

# 데이터의 정규화
mean <- apply(train.x, 2, mean)
std <- apply(train.x, 2, sd)
train.x <- scale(train.x, center = mean, scale= std)
test.x <- scale(test.x, center = mean , scale=std)


# 테스트 데이터를 이용한 모델의 성능 확인
res <- model %>% evaluate(test.x, test.y)
res