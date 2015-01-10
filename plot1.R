display <- function() {
	importdata  <- read.csv("data/household_power_consumption.txt")
	importdata  <- subset(importdata, as.Date(importdata$Date, format='%d/%m/%Y') >= as.Date('2007-02-01'))
	importdata  <- subset(importdata, as.Date(importdata$Date, format='%d/%m/%Y') <= as.Date('2007-02-02'))
	return(importdata)
}
