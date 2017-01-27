hpc <- read.csv('../household_power_consumption.txt', na.strings = '?', sep = ';', nrows = 70000)
hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]

datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

if (file.exists('plot2.png'))
{
    file.remove('plot2.png')
}
png('plot2.png', width = 480, height = 480, bg = 'transparent')
plot(hpc$Datetime, hpc$Global_active_power, type = 'l', xlab="", ylab='Global Active Power (kilowatts)')
dev.off(which = dev.cur())
