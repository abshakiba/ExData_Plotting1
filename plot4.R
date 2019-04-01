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

# Select only Date, Time, and Sub Metering columns from the data
dplot4 <- sdata

# Create the DateTime column
dplot4$datetimes <- strptime( paste(gap_dates$Date,
                                       gap_dates$Time,
                                       sep=" "),
                              "%Y-%m-%d %H:%M:%S")

# Convert Data Types to Numeric
dplot4$Global_active_power <- as.numeric(sub(",",".",dplot4$Global_active_power))
dplot4$Global_reactive_power <- as.numeric(sub(",",".",dplot4$Global_reactive_power))
dplot4$Sub_metering_1 <- as.numeric(sub(",",".",dplot4$Sub_metering_1))
dplot4$Sub_metering_2 <- as.numeric(sub(",",".",dplot4$Sub_metering_2))
dplot4$Sub_metering_3 <- as.numeric(sub(",",".",dplot4$Sub_metering_3))
dplot4$Voltage <- as.numeric(sub(",",".",dplot4$Voltage))


# Plotting
png("plot4.png", width=480, height=480)

# Size of Rows and Columns, row base
par(mfrow = c(2, 2)) 

# Plot 1
plot(x=dplot4$datetimes,
     y = dplot4$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (Kilowatts)")

# Plot 2
plot(x=dplot4$datetimes,
     y = dplot4$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot 3
plot(x= dplot4$datetimes,
     y = dplot4$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy Sub Metering")
lines(x= dplot4$datetimes,
      y = dplot4$Sub_metering_2, col="red")
lines(x= dplot4$datetimes,
      y = dplot4$Sub_metering_3, col="blue")
legend("topright", c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),
       lty=1,
       lwd=2,
       col = c("black","red","blue"))
       
# Plot 4
plot(x=dplot4$datetimes,
     y = dplot4$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
