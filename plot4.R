
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

png(filename="plot4.png", width=480, height=480,bg = "transparent")

par(mfrow=c(2,2))
with(dt, { 

	 # plot2
      	    plot(datetime, Global_active_power, type="n", 
	         xlab="", ylab="Global Active Power (kilowatts)")
            lines(datetime, Global_active_power)

	 # new plot

	   plot(datetime, Voltage, type="n")
	   lines(datetime, Voltage)

	 # plot3

	   plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
	   lines(datetime, Sub_metering_1, col="black")
	   lines(datetime, Sub_metering_2,col="red")
	   lines(datetime, Sub_metering_3,col="blue")
	   legend("topright", col=c("black","red","blue"), 
	          legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
 		  lty="solid", box.lty="blank")

	 # new plot

	   plot(datetime, Global_reactive_power, type="n")
	   lines(datetime, Global_reactive_power)

	 }
)

dev.off()
