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

# Plot the history, with red fill color
with(powerConsumeStudy, plot(dateTime, Sub_metering_1, type="l", xlab="", ylab = "Energy sub metering"))
with(powerConsumeStudy, lines(dateTime, Sub_metering_2, col="red"))
with(powerConsumeStudy, lines(dateTime, Sub_metering_3, col="blue"))
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.6)


# Write the plot to png file
dev.copy(png, file = "plot3.png")
dev.off()
