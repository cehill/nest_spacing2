data<-read.csv("nest_card_data20220731.csv")#read in data
library(dplyr)#load dplyr
data <- dplyr::rename(data, TERRITORY = NESTING_TERRITORY)#rename one column
data2<-subset(data, VALID_NEST==TRUE)#keep only "valid nests" in data2
data2<-subset(data2, HD_YEAR>2018 & HD_YEAR<2022) #keep only the three best years of data, 2019-2021
data3 <- subset(data2, select = c(NEST_NUMBER,TERRITORY,VALID_NEST,LAT,LONG,HATCH_DATE, HD_YEAR))#keep only seven columns in data.3
write.csv(data3, "data3.csv", row.names = FALSE)#write a copy of data3 to my hard drive.
library(sf)
data4 <- st_as_sf(data3, coords = c("LAT", "LONG"), 
                  crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")#create an sf file data4, which uses the LAT  and LONG columns for locations, and supplies the datum
dist.mat <- st_distance(data4)#calculate the distance matrix
num.1500 <- apply(dist.mat, 1, function(x) {
  sum(x < 1500) - 1
})#this defines a function to determine how many nests are within 1500m
nn.index <- apply(dist.mat, 1, function(x) { order(x, decreasing=F)[2] })#define a function to get the nearest nest index.
n.data <- data3#this line and the next 8 add new columns about the nearest nest to data3, creating data5
colnames(n.data)[1] <- "neighbor"
colnames(n.data)[2:ncol(n.data)] <- 
  paste0("n.", colnames(n.data)[2:ncol(n.data)])
data5 <- data.frame(data3,
                    n.data[nn.index, ],
                    n.distance = nn.dist,#calls nn.dist function defined above
                    radius1500 = num.1500)#calls num.1500 function defined above
rownames(data5) <- seq(nrow(data5))
write.csv(data5, "data5.csv", row.names = FALSE)# write the file to my hard drive as a data5.csv