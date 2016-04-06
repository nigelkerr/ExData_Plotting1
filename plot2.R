
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

png(filename="plot2.png", width=480, height=480,bg = "transparent")

with( dt, { 
      	    plot(datetime, Global_active_power, type="n", 
	         xlab="", ylab="Global Active Power (kilowatts)")
            lines(datetime, Global_active_power); 
	  }
)

dev.off()
