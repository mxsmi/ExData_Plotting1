# Read in the data
data <- read.table("household_power_consumption.txt", 
                   sep = ";", header = TRUE, na.strings = "?")

# Convert first column to class date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the data to just 2007-02-01 through 2007-02-02
data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Convert Time column to class time using strptime
data$Time <- strptime(paste(data$Date, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Create a new column with the weekday (abbreviated) for each observation
data$Weekday <- weekdays(data$Date, abbreviate = TRUE)

# Start windows graphics device
windows()

# Plot Global Active Power and Weekday
plot(data$Time, data$Global_active_power, type = "l", 
     ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "")

# Customize x-axis labels to show the weekdays
axis(1, at = seq(min(data$Time), max(data$Time) + days(1), by = "1 day"),
     labels = c("Thu", "Fri", "Sat"), las = 1)

# Save the current plot as a .png file
dev.copy(png, file = "plot2.png", width = 480, height = 480)

# Close graphics device
dev.off()




