## Read the data
power <- read.table("household_power_consumption.txt", head=TRUE, sep=";") 

## Modify the format of the dates 
power$Date <- strptime(power$Date, format = "%d/%m/%Y")

## Create two tables with the data from Feb 01 and Feb 02
newData <- subset(power, Date=="2007-02-01")
newData2 <- subset(power, Date == "2007-02-02")

## Combine the data of the two new tables
finalData <- rbind(newData, newData2)

## Create a new column combining Date and Time
dateTime <- paste (finalData$Date, finalData$Time, sep=" ")

## Modify the class of dateTime to POSIXct (instead of character)
dateTime<-as.POSIXct(dateTime)

## Paste the new column to the preexisting table
finalFinalData <- cbind(finalData, dateTime)

## Rename the variables (to save typing time)
datime <- finalFinalData$dateTime
volt <- finalFinalData$Voltage
grp <- finalFinalData$Global_reactive_power
gap <- finalFinalData$Global_active_power
sub1 <- finalFinalData$Sub_metering_1
sub2 <- finalFinalData$Sub_metering_2
sub3 <- finalFinalData$Sub_metering_3 

## Modify the class of the variables to numeric (if needed)
volt <- as.numeric(levels(volt))[volt]
grp <- as.numeric(levels(grp))[grp]
gap <- as.numeric(levels(gap))[gap]
sub1 <- as.numeric(levels(sub1))[sub1]
sub2 <- as.numeric(levels(sub2))[sub2]


## Create the png file 
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(finalFinalData$dateTime, gap, type="n", xlab="", ylab = "Global Active Power")
lines(finalFinalData$dateTime, gap, type="l")
plot(datime, volt, type="n", xlab="datetime", ylab="Voltage")
lines(datime, volt, type="l")
plot(datime, sub1, type="n", ylab="Energy sub metering", xlab="")
lines(datime, sub1, type="l")
lines(datime, sub2, type="l", col="red")
lines(datime, sub3, type="l", col="blue")
legend("topright", lty=c(1,1,1), bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(datime, grp, type="n", xlab= "datetime", ylab="Global_reactive_power")
lines(datime,grp,type="l")
dev.off()
