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
par(mfrow=c(2,2))

#plot1 
with(data_household, plot(Global_active_power~Date,type='l',ylab = 'Global Active Power (kilowatts)',xlab=NA))

#plot2
with(data_household, plot(Voltage~Date,type='l'))

#plot3
with(data_household, {
	plot(Sub_metering_1~Date,type='l',xlab=NA,ylab = 'Energy sub metering')
	lines(Sub_metering_2 ~ Date, type = "l", col = "red")
	lines(Sub_metering_3 ~ Date, type = "l", col = "blue") 
})

legend("topright", col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1)

#plot4
with(data_household, plot(Global_reactive_power~Date,type='l'))


# dev.copy: copy a plot from one device to another
dev.copy(png, file = "plot4.png") 
dev.off()

