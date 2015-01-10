###################################################################################################
getData <- function() {
###################################################################################################	

	# import local data
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")
	
	# re cast date
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")
	
	# get rows from target range
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]
	
	# add column for timestamp
	df <- transform(df, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")	
	
	# assign variables to return
	s1 <- df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
	s2 <- df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
	s3 <- df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
	ts <- df$timestamp
	gl <- df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	vl <- df$Voltage <- as.numeric(as.character(df$Voltage))
	gp <- df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))	
	return(list(s1, s2, s3, ts, gl, vl, gp))
}

###################################################################################################
plotData <- function() {
###################################################################################################	
	
	# get data and assign variables
	data <- getData()	
	s1 <- data[[1]]
	s2 <- data[[2]]
	s3 <- data[[3]]
	ts <- data[[4]]
	gl <- data[[5]]
	vl <- data[[6]]
	gp <- data[[7]]	
	
	# open png file
	png("plot4.png", width = 480, height = 480, units = "px")	
	
	# grid of plots
	par(mfcol = c(2,2))
	
	# global active plot
	plot(ts, gl, type = "l", xlab = "" , ylab = "Global Active Power")

	# energy sub meter plot
	plot(ts, s1, type = "l", xlab = "" , ylab = "Energy sub metering")
	lines(ts, s2, col = "red1")
	lines(ts, s3, col = "blue")
	legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'))	

	# voltage plot
	plot(ts, vl, type = "l", xlab = "datetime" , ylab = "Voltage")

	# global reactive power
	plot(ts, gp, type = "l", xlab = "datetime" , ylab = "Global_reactive_power")	
	dev.off()
}

# Rock and Roll
plotData()