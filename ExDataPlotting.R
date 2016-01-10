# Basic set-up
basePath <- getwd()
path <- paste0(basePath, "/Expl_Data_Analyses/ExData_Plotting1/figure/")
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

if (!file.exists(path)) {
  cat("Folder does NOT exist!\n")
}

#######################
# Create 1rst png plot
#######################
png(file= paste0(path, "plot1.png"), 
    width=widthPng, height=heightPng, units="px")
with(myData, hist(Global_active_power, 
                 breaks=12, col="red", 
                 xlab = "Global Active Power (kilowatts)",
                 main = "Global Active Power"))
dev.off()

#######################
# Create 2nd png plot
#######################
png(file= paste0(path, "plot2.png"), 
    width=widthPng, height=heightPng, units="px")
with(myData, plot(DateTime, Global_active_power,
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)",
                  type = "l"))
dev.off()

#######################
# Create 3rd png plot
#######################
png(file= paste0(path, "plot3.png"), 
    width=widthPng, height=heightPng, units="px")
# Base plot with 1rst data series
with(myData, plot(DateTime, Sub_metering_1,
                  xlab = "",
                  ylab = "Energy sub metering",
                  type = "l"))
# Keeping plot and adding 2nd data series
par(new = FALSE)
with(myData, lines(DateTime, Sub_metering_2,
                  col = "red",
                  type = "l"))
# Keeping plot and adding 3rd data series
par(new = FALSE)
with(myData, lines(DateTime, Sub_metering_3,
                  col = "blue",
                  type = "l"))

legend("topright", lty=1, 
       col= c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

#######################
# Create 4th png plot
#######################
png(file= paste0(path, "plot4.png"), 
    width=widthPng, height=heightPng, units="px")
# Specifying plot area with 2 rows and 2 columns with plots
par(nfrow = c(2,2))

# 1rst plot of 4
with(myData, plot(DateTime, Global_active_power,
                  xlab = "",
                  ylab = "Global Active Power (kilowatts)",
                  type = "l"))

# 2nd plot of 4
with(myData, plot(DateTime, Voltage,
                  xlab = "",
                  ylab = "Voltage",
                  type = "l"))

# 3rd plot of 4
# Base plot with 1rst data series
with(myData, plot(DateTime, Sub_metering_1,
                  xlab = "",
                  ylab = "Energy sub metering",
                  type = "l"))
# Keeping 3rd plot of 4 and adding 2nd data series
par(new = FALSE)
with(myData, lines(DateTime, Sub_metering_2,
                   col = "red",
                   type = "l"))
# Keeping 3rd plot of 4 and adding 3rd data series
par(new = FALSE)
with(myData, lines(DateTime, Sub_metering_3,
                   col = "blue",
                   type = "l"))
legend("topright", lty=1, 
       col= c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 4th plot of 4
with(myData, plot(DateTime, Global_reactive_power,
                  xlab = "",
                  ylab = "Global_reactive_power",
                  type = "l"))

dev.off()