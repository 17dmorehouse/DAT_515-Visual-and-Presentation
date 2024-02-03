rm(list=ls())

library(readxl)
library(dplyr)
library(tidyr)
library(stringr)
library(reshape2)

movies<-read_excel("C:/Users/dev46/OneDrive/Desktop/School Documents/Spring 2024/Visualization and Presentation/Data/movie_metadata.xlsx",sheet=1) %>%
  filter(!duplicated(movies))

genres<-str_split(movies$genres,"\\|",simplify=TRUE)

genres_title<-as.data.frame(cbind(movies$movie_title,movies$title_year,genres)) %>% 
  rename(movie_title=V1,title_year=V2,genre1=V3,genre2=V4,genre3=V5,genre4=V6,
         genre5=V7,genre6=V8,genre7=V9,genre8=V10)

movies_final<-merge(movies,genres_title,by=c("movie_title","title_year"),all.x=TRUE) %>%
  melt(id=c(1:28)) %>%
  rename(genre_num=variable,genre_name=value) %>%
  filter(genre_name!="") 

#movies_final<-merge(movies,genres_title,by=c("movie_title","title_year"),all.x=TRUE) %>%
#  gather(key="genre_num",value="genre_name",29:36) %>%
#  filter(genre_name!="")
  
write.csv(movies_final,"movies_metadata_reshaped.csv")

