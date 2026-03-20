
source("getSentences.R")
source("randomSentence.R")

text2show<-getSentences()
# text2show<-getWords()

theText2show<-randomSentence(text2show)
print(theText2show)

