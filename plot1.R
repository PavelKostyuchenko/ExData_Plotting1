data_all<-read.table("household_power_consumption.txt", sep=";", header = TRUE)
data_all$Date<-strptime(data_all$Date, "%d/%m/%Y")
data_all$Date<-as.Date(data_all$Date)
temp_vector<-data_all$Date=="2007-02-01" | data_all$Date=="2007-02-02"
data_sub<-data_all[temp_vector,]
data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))
library(datasets)
png(file = "plot1.png")
par(mar = c(4, 4, 3, 1), bg="transparent", oma = c(0, 0, 0, 0))
  hist(data_sub$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col="red", main = "Global Active Power")
dev.off()