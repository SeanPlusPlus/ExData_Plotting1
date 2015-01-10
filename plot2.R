getGlobalActivePowerWithTime <- function() {
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]
	df <- transform(df, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")	
	gl <- df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	ts <- df$timestamp
	return(list(gl, ts))
}

plotGlobalActivePowerWithTime <- function() {
	data <- getGlobalActivePowerWithTime()
	gl <- data[[1]]
	ts <- data[[2]]	
	png("plot2.png", width = 480, height = 480, units = "px")
	plot(ts, gl, type = "l", xlab = "" , ylab = "Global Active Power (kilowats)")
	dev.off()
}

plotGlobalActivePowerWithTime()