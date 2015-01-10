###################################################################################################
getGlobalActivePowerWithTime <- function() {
###################################################################################################

	# import local data	
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")

	# re cast date
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")

	# get rows from target range
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]

	# add column for timestamp
	df <- transform(df, timestamp = as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")	

	# asssign variables to return
	gl <- df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
	ts <- df$timestamp
	return(list(gl, ts))
}

###################################################################################################
plotGlobalActivePowerWithTime <- function() {
###################################################################################################

	# get data and assign variables	
	data <- getGlobalActivePowerWithTime()
	gl <- data[[1]]
	ts <- data[[2]]
	
	# open png file
	png("plot2.png", width = 480, height = 480, units = "px")
	plot(ts, gl, type = "l", xlab = "" , ylab = "Global Active Power (kilowats)")
	dev.off()
}

# Rock and Roll
plotGlobalActivePowerWithTime()