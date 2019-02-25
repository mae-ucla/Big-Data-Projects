rm(list=ls())

###########################Scraper###########################
library(gtrendsR)
setwd('/Users/patrick/Desktop/MAE Lab/Projects/Google Trends')

queries<-as.vector(read.csv("us-inflation_rate.csv", header=F)$V1)

get.trends<-function(queries=NA, geo="US", time="all", path=getwd()){
  for(i in 1:length(queries)){
    keyword=queries[i]
    data=gtrends(keyword=keyword, geo=geo, time=time)$interest_over_time[,1:4]
    if(length(data$hits)<100 | class(data$hit)!="integer"){
      next
    }
    colnames(data)[2]<-data[2,3]
    data<-data[,1:2]
    file.name=paste(path, "/", keyword, ".csv", sep="")
    write.csv(x=data, file=file.name, row.names=F)
  }
}


path='/Users/patrick/Desktop/MAE Lab/Projects/Google Trends/Inflation_2'
get.trends(queries, path=path)



###########################Merge Data###########################

load.data<-function(pattern=NA, path=getwd(), merge=FALSE){
  library(purrr)
  setwd(path)
  if(is.na(pattern)){
    list<-system("ls", intern=T)
    list<-paste(path, "/", list, sep="")
  }else{
    list<-system("ls", intern=T)
    list<-list[grep(pattern=pattern, x=list)]
    list<-paste(path, "/", list, sep="")
  }
  data.list<-list()
  df.names<-paste("df", 1:length(list), sep="")
  for(i in 1:length(list)){
    data<-read.csv(list[i])
    data.list<-append(data.list, list(assign(df.names[i], data)))
  }
  if(merge==FALSE){
    names(data.list)<-df.names
    return(data.list)
  }else{
    data.merged<-data.list[[1]]
    critical.len<-length(data.list[[1]][,1])
    for(i in 2:length(data.list)){
      data.merged<-merge(data.merged, data.list[[i]])
      if(length(data.merged[,1])<critical.len){
        return(cat("Error happens at ", list[i], "."))
      }
    }
    return(data.merged)
  }
}

df<-load.data(path=path, merge=T)
#df<-load.data(path=path, merge=F)
#data<-reduce(df, merge)
write.csv(x=df, file="/Users/patrick/Desktop/MAE Lab/Projects/Google Trends/us_inflation_panel.csv", row.names=F)

#multmerge = function(mypath){
  #filenames=list.files(path=mypath, full.names=TRUE)
  #datalist = lapply(filenames, function(x){read.csv(file=x,header=T)[,2:3]})
  #Reduce(function(x,y) {merge(x,y)}, datalist)
#}

#df<-multmerge(path)
#write.csv(x=df, file="inflation_panel.csv")
