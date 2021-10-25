#결측치
mycin <-as.data.frame(Puromycin)
head(mycin)
str(mycin)
summary(mycin)
mycin[2,1] <- NA
mycin[5,2] <- NA
mycin[7,3] <- NA
head(mycin,7)
is.na(mycin)
is.na(mycin$conc)
is.na(mycin[1:5,])
sum(mycin$conc,na.rm=TRUE)
mean(mycin$rate, na.rm=TRUE)
mycin_omit<-na.omit(mycin)
head(mycin_omit,7)
mycin_rm <-mycin[complete.cases(mycin),]
head(mycin_rm,7)
head(mycin$conc)
mycin$conc[is.na(mycin$conc)]=0
head(mycin$conc)
head(mycin$rate)
mycin$rate[is.na(mycin$rate)]=mean(mycin$rate, na.rm=T)
head(mycin$rate)


#이상치
orange<-as.data.frame(Orange)
head(orange,8)
str(orange)
summary(orange)
table(orange$age)
orange$age[10]<-1100
orange$age[20]<-2000
table(orange$age)
orange$age <- ifelse(orange$age == 1100 | orange$age==2000,NA, orange$age)
table(orange$age)
table(is.na(orange$age))



#극단치
install.packages("dplyr")
library(dplyr)
mtcar1 <-mtcars
head(mtcar1)
str(mtcar1)

select(mtcar1, mpg, cyl, vs)
select(mtcar1, -am, -gear, -carb)
mtcar1 %>% select(mpg, cyl, vs)
mtcar1 %>% select(-am, -gear, -carb)

mtcar1 %>% filter(cyl==6)
mtcar1 %>% filter(mpg>21)
mtcar1 %>% filter(gear==4 &mpg>21)
mtcar1 %>% filter(gear ==3 | gear ==5)

mtcar1 %>% filter(gear==4) %>% select(mpg, cyl, disp)
mtcar1 %>% filter(mpg>21) %>% select(disp, hp, wt)

mtcar1 %>% slice(3:7)

mtcar1 %>% arrange(mpg)
mtcar1 %>% arrange(desc(mpg))

mtcar1 %>% arrange(cyl, mpg)

mtcar1 %>% distinct(cyl)
mtcar1 %>% distinct(cyl,gear)

duplicated(mtcar1$cyl)
duplicated(mtcar1$cyl) %>% table()
duplicated(table(mtcar1$cyl))

mtcar1 %>% mutate(sec=qsec*4) %>% head
mtcar1 %>% mutate(valid = ifelse(mpg >= mean(mpg), "pass","fail")) %>% head

mtcar1 %>% summarise(mean(mpg))
mtcar1 %>% summarise(mean=mean(mpg))
mtcar1 %>%
  group_by(cyl) %>%
  summarise(n=n(),
            mean=mean(mpg))

mtcar1 %>%
  group_by(vs,cyl) %>%
  summarise(vs_cyl_mpg_mean=mean(mpg))

mtcar1 %>%
  filter(am==0) %>%
  select(mpg,hp,wt) %>%
  arrange(desc(mpg)) %>%
  head
