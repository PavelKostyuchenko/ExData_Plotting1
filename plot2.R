## Step 1: Reading data from the file
data_all<-read.table("household_power_consumption.txt", sep=";", header = TRUE)

## Step 2: Format of data is not standard so read the date in proper format 
data_all$Date<-strptime(data_all$Date, "%d/%m/%Y")
data_all$Date<-as.Date(data_all$Date)

##Step 3: Subset from all data only data related to 
##2007-02-01 and 2007-02-02 as required
temp_vector<-data_all$Date=="2007-02-01" | data_all$Date=="2007-02-02"
data_sub<-data_all[temp_vector,]

##Step 4: Changing into English as days of week must be in English
Sys.setlocale('LC_TIME', 'C')
merge_time<-paste(data_sub$Date, data_sub$Time)

##Step 5: Merge date and time as need for the graph 
date_upd<-strptime(merge_time, "%Y-%m-%d %H:%M:%S")

##Step 6: Changing type of data into numeric
data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))

##Step 7: Choosing base and deciding to store as png file 
library(datasets)
png(file = "plot2.png")

##Step 8: Setting format of the output
par(mar = c(2, 4, 3, 1), bg="transparent", oma = c(2, 0, 0, 0))

##Step 9: drawing a graph of required type with Y-axis named
with(data_sub, {
  plot(date_upd, Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l")
})

##Step 10: closing png 
dev.off()
