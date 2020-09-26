#Libraries
library(dplyr)
library(lubridate)

data_household <- read.table(unz("data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),
			    header=T, quote="\"", sep=";",na.strings = '?',)

str(data_household)

# Convert date to datetime
data_household$Date <- as.Date(data_household$Date,format = '%d/%m/%Y')
head(data_household)

# subset
data_household<-filter(data_household, between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))

# calculate new variable week day
data_household <- mutate(data_household, Date = ymd_hms(paste(Date, Time)))

# create the plot
with(data_household, {
	plot(Sub_metering_1~Date,type='l',xlab=NA,ylab = 'Energy sub metering')
	lines(Sub_metering_2 ~ Date, type = "l", col = "red")
	lines(Sub_metering_3 ~ Date, type = "l", col = "blue") 
})

legend("topright", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1)



# dev.copy: copy a plot from one device to another
dev.copy(png, file = "plot3.png") 
dev.off()

