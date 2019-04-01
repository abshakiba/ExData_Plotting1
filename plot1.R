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

#Plotting
png("plot1.png", width = 480, height = 480)
gap <- as.numeric(sub(",",".",sdata$Global_active_power))
hist(gap,
     col="red",
     main="Global Active Power",
     xlab = "Global Active Power (Kilowatts)")
dev.off()
