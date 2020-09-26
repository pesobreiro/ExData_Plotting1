#Libraries
library(dplyr)

data_household <- read.table(unz("data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),
			    header=T, quote="\"", sep=";",na.strings = '?',)

str(data_household)

# Convert date to datetime
data_household$Date <- as.Date(data_household$Date,format = '%d/%m/%Y')
head(data_household)

# subset
data_household<-filter(data_household, between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))
# create the hist
hist(data_household$Global_active_power,main = 'Global Active Power',xlab = 'Global Active Power (kilowats)',col = 'red')

# dev.copy: copy a plot from one device to another
dev.copy(png, file = "plot1.png") 
dev.off()

