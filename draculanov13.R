dracula<-gutenberg_download(245)

dracula_words<-dracula%>%
  unnest_tokens(word,text)

bing<-get_sentiments('bing')

dracula_words<-inner_join(dracula_words,bing)
dracula_words$gutenberg_id<-NULL 

dracula_words<-dracula_words%>%
  group_by(word)%>%
  summarise(freq=n(),sentiment=first(sentiment)) #summarise by word count, and retain sentiment

wordcloud(dracula_words$word,dracula_words$freq,min.freq = 15)

wordcloud2(dracula_words,fig='bat2.jpg')

letterCloud(dracula_words,'Dracula')

#row~col/fill NA w/0
dracula_matrix<-acast(dracula_words,word~sentiment,value.var='freq',fill=0)

comparison.cloud(dracula_matrix,colors=c('black','orange'),max.words = 100)

