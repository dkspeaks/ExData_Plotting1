# Extract only the rows matching the 2 dates - 2007-02-01 and 2007-02-02.
library(sqldf)
epc <- "household_power_consumption.txt"
epcdata <- read.csv.sql(epc, 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", header=TRUE, sep=";", na.strings="?")
closeAllConnections()

epcdata$DateTime <- paste(epcdata$Date,epcdata$Time)
epcdata$DateTime <- as.POSIXct(epcdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Plot4
png(filename="plot4.png")
par(mfrow=c(2,2))
with(epcdata,{
  plot(epcdata$DateTime,epcdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  plot(epcdata$DateTime,epcdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(epcdata$DateTime,epcdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(epcdata$DateTime,epcdata$Sub_metering_2, type="l", col ="red")
  lines(epcdata$DateTime,epcdata$Sub_metering_3, type="l", col ="blue")
  legend( "topright",pch = "____", col = c( "black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(epcdata$DateTime,epcdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()