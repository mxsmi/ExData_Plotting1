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

# Set up the plotting area to be a 2x2 grid
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

# Create the grid of plots
with(data, {
  # Plot Global Active Power and Weekday
  plot(data$Time, data$Global_active_power, type = "l", 
       ylab = "Global Active Power", xaxt = "n", xlab = "")
  # Customize x-axis labels to show the weekdays
  axis(1, at = seq(min(data$Time), max(data$Time) + days(1), by = "1 day"),
       labels = c("Thu", "Fri", "Sat"), las = 1)
  
  plot(data$Time, data$Voltage, type = "l",
       ylab = "Voltage", xlab = "datetime", xaxt = "n", yaxt = "n")
  # Customize x-axis labels to show the weekdays
  axis(1, at = seq(min(data$Time), max(data$Time) + days(1), by = "1 day"),
       labels = c("Thu", "Fri", "Sat"), las = 1)
  axis(2, at = seq(234, 246, by = 4), las = 1)
  
  # Plot Global Active Power and Weekday
  plot(data$Time, data$Sub_metering_1, type = "l", 
       ylab = "Energy sub metering", xaxt = "n", xlab = "")
  # Customize x-axis labels to show the weekdays
  axis(1, at = seq(min(data$Time), max(data$Time) + days(1), by = "1 day"),
       labels = c("Thu", "Fri", "Sat"), las = 1)
  # Add lines for Sub_metering_2 and Sub_metering_3
  lines(data$Time, data$Sub_metering_2, col = "red")
  lines(data$Time, data$Sub_metering_3, col = "blue")
  # Add a legend with colors for each sub-metering
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"), lty = 1)
  
  plot(data$Time, data$Global_reactive_power, type = "l",
       ylab = "Global_reactive_power", xlab = "datetime", xaxt = "n")
  # Customize x-axis labels to show the weekdays
  axis(1, at = seq(min(data$Time), max(data$Time) + days(1), by = "1 day"),
       labels = c("Thu", "Fri", "Sat"), las = 1)
})

# Save the current plot as a .png file
dev.copy(png, file = "plot4.png", width = 480, height = 480)

# Close graphics device
dev.off()
