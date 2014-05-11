
# Read in the household_power_consumption file
powerConsume <- read.table("household_power_consumption.txt", header=T, sep=";")

# Create a new column which contains both Date and Time
# Conver into the POSIX time object
powerConsume$dateTime <- strptime(paste(powerConsume$Date, powerConsume$Time), format="%d/%m/%Y %H:%M:%s")

# Variable to hold starting date and ending date for study
startDate <- as.Date("01/02/2007", "%d/%m/%Y")
endDate <- as.Date("02/02/2007", "%d/%m/%Y")

# Retrieve the data between starting date and ending date
powerConsumeStudy <- subset(powerConsume, as.Date(powerConsume$dateTime) >= startDate & as.Date(powerConsume$dateTime) <= endDate)

# Convert the related data into double type
powerConsumeStudy$Global_active_power <- as.double(as.character(powerConsumeStudy$Global_active_power))
powerConsumeStudy$Sub_metering_1 <- as.double(as.character(powerConsumeStudy$Sub_metering_1))
powerConsumeStudy$Sub_metering_2 <- as.double(as.character(powerConsumeStudy$Sub_metering_2))
powerConsumeStudy$Sub_metering_3 <- as.double(as.character(powerConsumeStudy$Sub_metering_3))
powerConsumeStudy$Voltage <- as.double(as.character(powerConsumeStudy$Voltage))
powerConsumeStudy$Global_reactive_power <- as.double(as.character(powerConsumeStudy$Global_reactive_power))


# Plot the history, with red fill color
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(powerConsumeStudy, {
  plot(dateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  plot(dateTime, Voltage, xlab="datetime", type="l")
  plot(dateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering")
  lines(dateTime, Sub_metering_2, col="red")
  lines(dateTime, Sub_metering_3, col="blue")
  legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.4, bty="n")
  plot(dateTime, Global_reactive_power, xlab="datetime", type="l")
})


# Write the plot to png file
dev.copy(png, file = "plot4.png")
dev.off()
