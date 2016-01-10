## 
# The data file must be placed in the working directory
##

widthPng <- 480
heightPng <- 480
firstDate <- as.Date("01/02/2007", format = "%d/%m/%Y")
# Since I am requiring date < last Date this date is 1 day
# later than the last date that must be included.
lastDate <- as.Date("03/02/2007", format = "%d/%m/%Y")

# Reading data file
myData <- read.table(file = "household_power_consumption.txt", 
                     header = TRUE, 
                     na.strings = "?",
                     sep=";")

# Creating variable with Date Time info (type POSIXct)
# and converting string in Date variable to Date type 
# and converting string in Time variable to type POSIXct
myData$DateTime <- as.POSIXct(
  paste(myData$Date, myData$Time), 
  format = "%d/%m/%Y %H:%M:%S")
myData$Date <- as.Date(myData$Date, format = "%d/%m/%Y")
myData$Time <- strptime(myData$Time, format = "%H:%M:%S")

# Limiting data set to the required date interval
myData <- myData[firstDate<=myData$Date & myData$Date<lastDate,]

#######################
# Create 2nd png plot
#######################
png(file= "plot2.png", 
    width=widthPng, height=heightPng, units="px")
with(myData, plot(DateTime, Global_active_power,
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)",
                  type = "l"))
dev.off()