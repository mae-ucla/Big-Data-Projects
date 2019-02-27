###########################Scraper###########################
get.trends<-function(queries=NA, geo="US", time="all", path=getwd()){
  library(gtrendsR)
  for(i in 1:length(queries)){
    keyword=queries[i]
    data=gtrends(keyword=keyword, geo=geo, time=time)$interest_over_time[,1:4]
    if(length(data$hits)==0){
      next
    }
    colnames(data)[2]<-data[2,3]
    data<-data[,1:2]
    file.name=paste(path, "/", keyword, ".csv", sep="")
    write.csv(x=data, file=file.name, row.names=F)
  }
}

#Function call: get.trends(queries=, geo="US", time="all", path=)

#This function automatically stores Google Trends time series in 
#separate csv files in a given directory. Note that this function
#will automatically set the names of the time series to the query
#terms.

#queries should be a vector of terms to get google trends for.

#path indicates where the csv files should be stored. Default is
#the current working directory.



###########################Merge Data###########################

load.data<-function(pattern=NA, path=getwd(), merge=FALSE){
  setwd(path)
  list<-list.files(path)
  if(is.na(pattern)){
    list<-paste(path, "/", list, sep="")
  }else{
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

#Function call: load.data(path=, merge=F)

#This function automatically loads all the csv files in a directory.
#If a pattern is specified, only files with names that match the pattern
#will be loaded. If merge is set to be FALSE, the data frames will be 
#stored in a list. If merge is set to be TRUE, the data frames will 
#be merged. Make sure that there is one and only one column in the data frames
#that have a common name before setting merge=T.