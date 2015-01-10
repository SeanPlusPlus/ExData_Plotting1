getData <- function() {
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]
	df <- transform(df, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")	
	s1 <- df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
	s2 <- df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
	s3 <- df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
	ts <- df$timestamp
	gl <- df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	vl <- df$Voltage <- as.numeric(as.character(df$Voltage))
	gp <- df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))	
	return(list(s1, s2, s3, ts, gl, vl, gp))
}

plotData <- function() {
	data <- getData()	
	s1 <- data[[1]]
	s2 <- data[[2]]
	s3 <- data[[3]]
	ts <- data[[4]]
	gl <- data[[5]]
	vl <- data[[6]]
	gp <- data[[7]]
	
	#png("plot4.png", width = 480, height = 480, units = "px")
	
	par(mfcol = c(2,2))
	plot(ts, gl, type = "l", xlab = "" , ylab = "Global Active Power")
	plot(ts, s1, type = "l", xlab = "" , ylab = "Energy sub metering")
	lines(ts, s2, col = "red1")
	lines(ts, s3, col = "blue")
	legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'))	
	plot(ts, vl, type = "l", xlab = "datetime" , ylab = "Voltage")
	plot(ts, gp, type = "l", xlab = "datetime" , ylab = "Global_reactive_power")	
	#dev.off()
}

plotData()