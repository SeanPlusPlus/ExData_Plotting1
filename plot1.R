getGlobalActivePower <- function() {
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]
	df$Global_active_power <- as.numeric(as.character(df$Global_active_power))		
}

plotGlobalActive <- function() {
	gl <- getGlobalActivePower()
	hist(gl, col = "red1", xlab = "Global Active Power (kilowats)", ylab = "Frequency", main = "Global Active Power")
}