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

# Convert the Global_active_power into double type
powerConsumeStudy$Global_active_power <- as.double(as.character(powerConsumeStudy$Global_active_power))

# Plot the history, with red fill color
with(powerConsumeStudy, plot(dateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

# Write the plot to png file
dev.copy(png, file = "plot2.png")
dev.off()
