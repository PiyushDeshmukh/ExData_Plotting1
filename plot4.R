hpc <- read.csv('../household_power_consumption.txt', na.strings = '?', sep = ';', nrows = 70000)
hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]

datetime <- paste(as.Date(hpc$Date), hpc$Time)
hpc$Datetime <- as.POSIXct(datetime)

if (file.exists('plot4.png'))
{
    file.remove('plot4.png')
}
png('plot4.png', width = 480, height = 480, bg = 'transparent')

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(hpc, {
        plot(Global_active_power ~ Datetime, xlab = "", ylab = "Global Active Power", type = 'l')
        plot(Voltage ~ Datetime, xlab = "datetime", ylab = "Voltage", type = 'l')
        plot(Sub_metering_1 ~ Datetime, xlab = "", ylab = "Energy sub metering", type = 'l')
        lines(Sub_metering_2 ~ Datetime, col = 'red')
        lines(Sub_metering_3 ~ Datetime, col = 'blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ Datetime, xlab = "datetime", ylab = "Global_reactive_power", type = 'l')
})

dev.off(which = dev.cur())
