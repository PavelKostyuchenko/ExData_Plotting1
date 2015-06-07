## Step 1: Reading data from the file
data_all<-read.table("household_power_consumption.txt", sep=";", header = TRUE)

## Step 2: Format of data is not standard so read the date in proper format 
data_all$Date<-strptime(data_all$Date, "%d/%m/%Y")
data_all$Date<-as.Date(data_all$Date)

##Step 3: Subset from all data only data related to 
##2007-02-01 and 2007-02-02 as required
temp_vector<-data_all$Date=="2007-02-01" | data_all$Date=="2007-02-02"
data_sub<-data_all[temp_vector,]

##Step 4: Changing type of data into numeric
data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))

##Step 5: Choosing base and deciding to store as png file 
library(datasets)
png(file = "plot1.png")

##Step 6: Setting format of the output
par(mar = c(4, 4, 3, 1), bg="transparent", oma = c(0, 0, 0, 0))

##Step 7: drawing a graph of required type with X and Y -axis named, with the title
  hist(data_sub$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col="red", main = "Global Active Power")

##Step 8: closing png
dev.off()