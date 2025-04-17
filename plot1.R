# Read in the data
data <- read.table("household_power_consumption.txt", 
                   sep = ";", header = TRUE, na.strings = "?")

# Convert first column to class date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the data to just 2007-02-01 through 2007-02-02
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Convert Time column to class time using strptime
data$Time <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Start windows graphics device
windows()

# Make the tick marks on the y axis range from 0 to 12 with a tick every 200
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

# Save the current plot as a .png file
dev.copy(png, file = "plot1.png", width = 480, height = 480)

# Close graphics device
dev.off()
