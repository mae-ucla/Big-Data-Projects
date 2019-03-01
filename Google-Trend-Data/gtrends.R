###########################Scraper###########################
get.trends<-function(queries=NULL, geo="US", time="all", path=getwd()){
  library(gtrendsR)
  if(is.null(queries)){
    print("Error: no queries provided.")
  }else{
    num.queries=as.numeric(length(queries))
    num.files=0
    failures=vector()
    for(i in 1:length(queries)){
    keyword=queries[i]
    if(class(try(df<-gtrends(keyword=keyword, geo=geo, time=time)[[1]][,1:4], T))[1]!="try-error"){
      data<-df
    }else{
      keyword<-paste("'", keyword, "'", " ", sep="")
      failures<-append(failures, keyword)
      next
    }
    if(is.null(data)){
      keyword<-paste("'", keyword, "'", " ", sep="")
      failures<-append(failures, keyword)
      next
    }
    colnames(data)[2]<-attr(factor(data$keyword), "level")
    data<-data[,1:2]
    file.name=paste(path, "/", keyword, ".csv", sep="")
    write.csv(x=data, file=file.name, row.names=F)
    num.files=num.files+1
  }
  num.omit=num.queries-num.files
  cat(num.queries, " queries submitted in total.", "\n",num.files, " queries processed and downloaded in ", "'", path, "'", ".", "\n", num.omit, " queries omitted. ", "\n", sep="")
  if(num.omit!=0){
    cat("These are: ")
    cat(failures)
  }
  }
}




###########################Merge Data###########################

load.data<-function(pattern=NULL, path=getwd(), merge=FALSE){
  setwd(path)
  list<-list.files(path)
  if(is.null(pattern)){
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

