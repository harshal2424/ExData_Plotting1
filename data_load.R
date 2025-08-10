##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            ~~
##             PEER REVIEWED PROJECT - COURSERA: DATA PLOTTING M1           ----
##                                                                            ~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


rm(list = ls())

##~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Project settings  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~

# Set working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
#setwd("..")

Sys.setlocale("LC_TIME", "en_US.UTF-8")

## Load packages
# List of required packages
packages <- c("tidyverse", 
              "sqldf", 
              "ARTofR")

# Install & load all packages
for (pkg in packages) {
        if (!require(pkg, character.only = TRUE)) {
                install.packages(pkg)
                library(pkg, character.only = TRUE)
        }
}

#Script Aesthetics
xxx_title0("Peer Reviewed Project - Coursera: Data Plotting M1")
xxx_title3 ("Project settings")
xxx_title3 ("Data Download")
xxx_title3 ("Data Load")
xxx_title3 ("Data Cleaning")
xxx_title3 ("Data Exploration")

# if (!dir.exists("data")) {dir.create("data")}

##~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Data Download  ----
##~~~~~~~~~~~~~~~~~~~~~~~

# URL of the dataset
zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Define data folder path
data_dir <- file.path(getwd(), "data")
zip_file <- file.path(data_dir, "exdata_data_household_power_consumption.zip")

# Create 'data' folder if it doesn't exist
if (!dir.exists(data_dir)) {dir.create(data_dir)}

# Only download and extract if dataset doesn't exist
if (!file.exists(file.path(data_dir, "household_power_consumption.txt"))) {
        
        # Download only if zip file doesn't exist
        if (!file.exists(zip_file)) {
                download.file(zip_url, zip_file, method = "curl")
        }
        
        # Extract into the 'data' folder
        unzip(zip_file, exdir = data_dir)
        
        # Remove the zip file
        if (file.exists(zip_file)) {
                file.remove(zip_file)
                message("Temporary zip file removed")
        }
        
} else {
        message("Dataset already exists - using cached version")
}

##~~~~~~~~~~~~~~~~~~~
##  ~ Data Load  ----
##~~~~~~~~~~~~~~~~~~~

system.time({
        power <- read_delim("./data/household_power_consumption.txt", 
                            delim = ";",
                            na = "?",
                            col_types = cols(
                                    Date = col_character(),
                                    Time = col_character()
                            )) %>% 
                filter(Date %in% c("1/2/2007", "2/2/2007"))
})


## Investigate data quality of file
dat <- read_delim("./data/household_power_consumption.txt", delim=";", na="?")
issues <- problems(dat)  # Get detailed error report
View(issues)  # Shows row/col numbers and actual vs expected values
problems(dat) %>% count(expected, actual)  # Most common issues
rm(dat, issues)

glimpse(power)
# Verify expected row count (1 obs per minute for 2 days = 2880 rows)
nrow(power) == 60 * 24 * 2  # Should return TRUE

##~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Data Cleaning  ----
##~~~~~~~~~~~~~~~~~~~~~~~

#Coerce date and time and create a datetime column
power <- power %>%
        mutate(
                Date = dmy(Date),  # Handles day/month/year automatically
                datetime = as.POSIXct(paste(Date, Time))  # Simpler syntax
        )
range(power$Date)  # Should return only 2007-02-01 and 2007-02-02
min(power$datetime)  # Should be "2007-02-01 00:00:00"
max(power$datetime)  # Should be "2007-02-02 23:59:00"

##~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Data Exploration  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~

# Please find data exploration plots using base R in the following .R files

