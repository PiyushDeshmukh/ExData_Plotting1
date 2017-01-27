hpc <- read.csv('../household_power_consumption.txt', na.strings = '?', sep = ';', nrows = 70000)
hpc['Date'] <-lapply(hpc['Date'], strptime, "%d/%m/%Y")
hpc <- hpc[(hpc$Date >= '2007-02-01' & hpc$Date <= '2007-02-02'),]


if (file.exists('plot1.png'))
{
    file.remove('plot1.png')
}
png('plot1.png', width = 480, height = 480, bg = 'transparent')
hist(hpc[['Global_active_power']], col = 'red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', breaks = 11)
dev.off(which = dev.cur())
