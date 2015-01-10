###################################################################################################
getSubmetering <- function() {
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
	return(list(s1, s2, s3, ts))
}

###################################################################################################
plotSubmetering <- function() {
###################################################################################################
	
	# get data and assign variables	
	data <- getSubmetering()	
	s1 <- data[[1]]
	s2 <- data[[2]]
	s3 <- data[[3]]
	ts <- data[[4]]
	
	# open png file	
	png("plot3.png", width = 480, height = 480, units = "px")

	# energy sub meter plot
	plot(ts, s1, type = "l", xlab = "" , ylab = "Energy sub metering")
	lines(ts, s2, col = "red1")
	lines(ts, s3, col = "blue")
	legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'))	
	dev.off()
}

# Rock and Roll
plotSubmetering()