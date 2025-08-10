# plot1.R - Global Active Power histogram 

# Load data
source("data_load.R")

# Create plot
png("./figure/plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(power$Global_active_power,
     col = "red",  # Keep red bars
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     breaks = 12,
     xlim = c(0, 6),
     ylim = c(0, 1200),
     col.main = "black",  # Black title
     col.lab = "black",   # Black axis labels
     col.axis = "black",  # Black axis numbers
     fg = "black"        # Black border/box
        )

dev.off()