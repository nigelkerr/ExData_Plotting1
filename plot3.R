
library(dplyr)
library(lubridate)
#
dt <- tbl_df(read.csv2("household_power_consumption.txt", header = FALSE, dec=".", colClasses=c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), na.strings = "?", skip=66637, nrows=2880))

names(dt) = c("Date",
"Time",
"Global_active_power",
"Global_reactive_power",
"Voltage",
"Global_intensity",
"Sub_metering_1",
"Sub_metering_2",
"Sub_metering_3")

dt <- mutate(dt, datetime = parse_date_time(paste(Date,Time), "dmyHMS"))

png(filename="plot3.png", width=480, height=480,bg = "transparent")

with(dt, { 
	   plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
	   lines(datetime, Sub_metering_1, col="black")
	   lines(datetime, Sub_metering_2,col="red")
	   lines(datetime, Sub_metering_3,col="blue")
	   legend("topright", col=c("black","red","blue"), 
	          legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
 		  lty="solid")
	 }
)

dev.off()
