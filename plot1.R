# Extract only the rows matching the 2 dates - 2007-02-01 and 2007-02-02.
library(sqldf)
epc <- "household_power_consumption.txt"
epcdata <- read.csv.sql(epc, 
                      sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007' ", header=TRUE, sep=";", na.strings="?")
closeAllConnections()


# Plot 1
png(filename="plot1.png")
hist(epcdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power", font.axis=1
)

dev.off()

