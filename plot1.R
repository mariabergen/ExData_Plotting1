##Read the data
power <- read.table("household_power_consumption.txt", head=TRUE, sep=";") 

## Modify the format of the dates
power$Date <- strptime(power$Date, format = "%d/%m/%Y")

## Create two tables with the data from Feb 01 and Feb 02
newData <- subset(power, Date=="2007-02-01")
newData2 <- subset(power, Date == "2007-02-02")

## Combine the data of the two new tables
finalData <- rbind(newData, newData2)

## Modify the class of dateTime to POSIXct (instead of character)
dateTime<-as.POSIXct(dateTime)

## Paste the new column to the preexisting table
finalFinalData <- cbind(finalData, dateTime)

## Rename the variable (to save typing time)
gap <- finalData$Global_active_power

## Modify the class of the variable to numeric
gap <- as.numeric(levels(gap))[gap]

## Create the png file 
png(file="plot1.png",width=480,height=480)
hist(gap,col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()


