# File Descriptions

The google trend time series collected in `US_Employment_Panel.csv` and `US_Inflation_Panel.csv` are correlated with search queries related to US labor market employment status and changes in inflation rate, respectively. Given the development in the labor market, people demonstrate specific searching behaviors that are highly correlated with one another. Individuals who got recently laid off, for example, might be more likely to search for information regarding unemployment benefits, leading to an increase in the frequency of queries of related terms. Hence, queries related to unemployment benefits should be highly correlated with development in the labor market. The originial query terms are stored in `us-inflation_rate.csv` and `us-unemployment.csv` respectively.



The file `gtrends.R` stores functions used to download and store Google Trends data and merge them into a panel dataset. The function `get.trends()` downloads time series from Google Trends based on a list of queries provided by the user, and stores them as .csv files either under the current working directory or elsewhere as speficied otherwise. Arguments of the function include `geo` and `time`, which indicate the geo graphic region and time span for the queries respectively. Note that empty time series returned by Google Trends will be ignored. Example codes using the function are provided below. 

```
list<-c("unemployment", "us unemployment")  #A vector of queries; could be read from a file as well
dir="~/Documents"                           #The directory under which the time series should be stored
get.trends(queries=list, geo="US", 
           time="all", path=dir)            #Run the code
```

The function `load.data()` automatically loads .csv files, either under the current working directory or the directory specified by the user, as data frames. If a `pattern` is specified, only files with names matching the pattern will be loaded. The argument `merge` is used to indicate whether the data frames should be stored in a single list (if `merge=FALSE`) or merged together in one data frame (if `merge=TRUE`). The user should make sure that there is one and only one column in each data frame that shares a common variable name before using the merging function. R has trouble processing variable names that contain certain special characters, and this might interfere with the merging function. If this happens, the function will stop running and reporting where the error takes place. 

```
dir="~/Documents/Google_Trends"              #The directory under which the files are stored
data<-load.data(path=dir, merge=T)           #Load the files and merge the data into a single data frame
write.csv(data, "Google_trends.csv")         #Write the data frame into a csv file
```