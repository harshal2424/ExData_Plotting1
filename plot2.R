# plot2.R - Time series of Global Active Power

# Load data
source("data_load.R")

# Create plot
png("./figure/plot2.png", width = 480, height = 480)
plot(power$datetime, 
     power$Global_active_power,
     type = "l",  # Line plot
     xaxt = "n",  # Suppress default x-axis
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Custom x-axis with Thu/Fri/Sat labels
axis.POSIXct(
        1,  # Bottom axis
        at = seq(min(power$datetime), max(power$datetime), by = "day"),
        format = "%a"  # Abbreviated weekday names
)
dev.off()