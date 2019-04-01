library(lubridate)
library(Hmisc)
library(dplyr)


# Read the data and filter for Feb-01 nad Feb-02 of 2007.
data <- read.csv("household_power_consumption.txt",sep = ";")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
feb1 <- as.Date("01/02/2007", "%d/%m/%Y")
feb2 <- as.Date("02/2/2007", "%d/%m/%Y")
sdata <- data[data$Date %in% c(feb1, feb2) ,]
rownames(sdata) <- NULL

# Select only Date, Time, and Global Active Power columns from the data
gap_dates <- sdata[,c(1,2,3)]

# Create the DateTime column
gap_dates$datetimes <- strptime( paste(gap_dates$Date,
                                       gap_dates$Time,
                                       sep=" "),
                                 "%Y-%m-%d %H:%M:%S")
                                 
# Convert Global Active Power type to numberic                                 
gap_dates$Global_active_power <- as.numeric(sub(",",".",sdata$Global_active_power))

# Plotting
png("plot2.png", width = 480, height = 480)
plot(x=gap_dates$datetimes,
     y = gap_dates$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (Kilowatts)")

dev.off()
