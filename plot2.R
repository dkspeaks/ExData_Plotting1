# Extract only the rows matching the 2 dates - 2007-02-01 and 2007-02-02.
library(sqldf)
epc <- "household_power_consumption.txt"
epcdata <- read.csv.sql(epc, 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", header=TRUE, sep=";", na.strings="?")
closeAllConnections()

epcdata$DateTime <- paste(epcdata$Date,epcdata$Time)
epcdata$DateTime <- as.POSIXct(epcdata$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Plot2
png(filename="plot2.png")
plot(epcdata$DateTime,epcdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

