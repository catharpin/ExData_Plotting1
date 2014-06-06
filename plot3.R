message( "Exploratory Data Analysis - Assignment 1 - Plot 3" )

## Prepare a folder for the unpacked data files if it isn't already there.
if(!file.exists("./data")){
    dir.create("./data")
}

## Download the data file if it isn't already there.

if (!file.exists("./power.zip")){
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./power.zip")
} else {
    message("Raw data archive already present.")
}

## Unzip the data file if it hasn't already been done.

if (!file.exists("./data/household_power_consumption.txt")){
    unzip("power.zip",exdir="./data")
} else {
    message ("Unpacked data present.")
}


powerdata <- read.csv(file="./data/household_power_consumption.txt",sep=";",
                      na.strings="?",skip=66636,nrow=2880,
                      colClasses=c("character","character","numeric","numeric",
                                   "numeric","numeric",
                                   "numeric","numeric","numeric"),
                      col.names=c("Date","Time",
                                  "Global_active_power","Global_reactive_power",
                                  "Voltage","Global_intensity",
                                  "Sub_metering_1","Sub_metering_2",
                                  "Sub_metering_3"))

## Convert the date and time columns from strings

powerdata$timeStamp <- strptime(
    paste(powerdata$Date,powerdata$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")

## ----------------- Plot begins here

png(file="plot3.png",width=480,height=480)

plot(powerdata$timeStamp,powerdata$Sub_metering_1,type="n",
    xlab=NA,ylab="Energy sub metering")

lines(powerdata$timeStamp,powerdata$Sub_metering_1,type="l",col="black")
lines(powerdata$timeStamp,powerdata$Sub_metering_2,type="l",col="red")
lines(powerdata$timeStamp,powerdata$Sub_metering_3,type="l",col="blue")

legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
   lty=c(1,1),lwd=c(1,1),col=c("black","red","blue"))

dev.off()
