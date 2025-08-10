# plot4.R - Multi-panel Energy Plots

# Load data
source("data_load.R")

# Create plot
png("./figure/plot4.png", width = 480, height = 480, bg = "transparent")

# Set Up 2x2 Plot Grid
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 0, 0))

# Panel 1: Global Active Power (Top-left)
plot(power$datetime, power$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n"
     )
# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)

# Panel 2: Voltage (Top-right)
plot(power$datetime, power$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n"
     )
# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)

# Panel 3: Energy Sub-metering (Bottom-left)
plot(power$datetime, power$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n"
     )
# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)
lines(power$datetime, power$Sub_metering_2, col = "red")
lines(power$datetime, power$Sub_metering_3, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       box.lty = 0,
       cex = 0.9)

# Panel 4: Global Reactive Power (Bottom-right)
plot(power$datetime, power$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n")
# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)

# 8. Close Device
dev.off()