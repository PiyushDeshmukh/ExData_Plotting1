hpc <- read.csv('../household_power_consumption.txt', na.strings = '?', sep = ';', nrows = 70000)
hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]

datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

if (file.exists('plot3.png'))
{
    file.remove('plot3.png')
}
png('plot3.png', width = 480, height = 480, bg = 'transparent')

with(hpc, {
        plot(Sub_metering_1 ~ Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="", col = 'black')
        lines(Sub_metering_2 ~ Datetime, col='red')
        lines(Sub_metering_3 ~ Datetime, col='blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


dev.off(which = dev.cur())
