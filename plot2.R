data_all<-read.table("household_power_consumption.txt", sep=";", header = TRUE)
data_all$Date<-strptime(data_all$Date, "%d/%m/%Y")
data_all$Date<-as.Date(data_all$Date)

temp_vector<-data_all$Date=="2007-02-01" | data_all$Date=="2007-02-02"
data_sub<-data_all[temp_vector,]
Sys.setlocale('LC_TIME', 'C')
merge_time<-paste(data_sub$Date, data_sub$Time)
date_upd<-strptime(merge_time, "%Y-%m-%d %H:%M:%S")
data_sub$Global_active_power<-as.numeric(as.character(data_sub$Global_active_power))
library(datasets)
png(file = "plot2.png")
par(mar = c(2, 4, 3, 1), bg="transparent", oma = c(2, 0, 0, 0))
with(data_sub, {
  plot(date_upd, Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l")
})
dev.off()
