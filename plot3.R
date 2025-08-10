# plot3.R - Energy Sub Metering Line Plot

# Load data
source("data_load.R")

# Create plot
png("./figure/plot3.png", width = 480, height = 480, bg = "transparent")

# Create Base Plot (Sub_metering_1)
plot(power$datetime, power$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black",
     xaxt = "n")  # Disable default x-axis

# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)

# Add Additional Lines
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")

# Add Legend
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       box.lty = 0  # Remove legend border
        )


dev.off()