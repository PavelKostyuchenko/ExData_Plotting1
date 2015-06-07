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
data_sub$Date<-date_upd
data_sub$Sub_metering_1<-as.numeric(as.character(data_sub$Sub_metering_1))
data_sub$Sub_metering_2<-as.numeric(as.character(data_sub$Sub_metering_2))
data_sub$Sub_metering_3<-as.numeric(as.character(data_sub$Sub_metering_3))

##Step 7: Choosing base and deciding to store as png file 
library(datasets)
png(file = "plot3.png")

##Step 8: Setting format of the output
par(mar = c(2, 4, 3, 1), bg="transparent", oma = c(2, 0, 0, 0))

##Step 9: putting all the data on the graph but without color
with(data_sub, plot(c(date_upd,date_upd,date_upd),
                    c(Sub_metering_1,Sub_metering_2,Sub_metering_3), 
                    type = "n", ylab = "Energy sub metering"))

##Step 10: adding different colors to diff data and providing a legent
with(subset(data_sub, date_upd > 0), lines(date_upd, Sub_metering_1, col = "black"))
with(subset(data_sub, date_upd > 0), lines(date_upd, Sub_metering_2, col = "red"))
with(subset(data_sub, date_upd > 0), lines(date_upd, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Step 11: closing png
dev.off()
