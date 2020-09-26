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
with(data_household, plot(Global_active_power~Date,type='l',ylab = 'Global Active Power (kilowats)'))

# dev.copy: copy a plot from one device to another
dev.copy(png, file = "plot2.png") 
dev.off()

