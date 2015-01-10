###################################################################################################
getGlobalActivePower <- function() {
###################################################################################################	
	
	# import local data
	importdata <- read.table("data/household_power_consumption.txt", header = T, sep = ";")

	# re cast date
	importdata$Date <- as.Date(importdata$Date, format = "%d/%m/%Y")
	
	# get rows from target range
	df <- importdata[(importdata$Date == "2007-02-01") | (importdata$Date == "2007-02-02"), ]

	# return global active power vector
	df$Global_active_power <- as.numeric(as.character(df$Global_active_power))		
}

###################################################################################################
plotGlobalActivePower <- function() {
###################################################################################################

	# get data and assign	
	gl <- getGlobalActivePower()
	
	# open png file
	png("plot1.png", width = 480, height = 480, units = "px")
	hist(gl, col = "red1", xlab = "Global Active Power (kilowats)", ylab = "Frequency", main = "Global Active Power")	
	dev.off()
}

# Rock and Roll
plotGlobalActivePower()