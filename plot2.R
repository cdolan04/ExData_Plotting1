url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
tempf = tempfile()
download.file(url = url, destfile = tempf, method = 'auto')
data <- read.table(unz(tempf, "household_power_consumption.txt"), header = TRUE, na.strings = "?", nrows = 2100000, sep = ";")
unlink(tempf)

##convert the first and second column to a more usable format

data2 <- as.Date((data[,1]), format = "%d/%m/%Y")
data[,1] <- data2
data3 <- format((data[,2]), format="%H:%M:%S")
data[,2] <- data3

## Subset the data so we only use two days we want
subdata <- subset(data, Date >= '2007-02-01' & Date <= '2007-02-02')
subdata2 <- rbind(subdata, data[69517,])

##Make Second plot

png(filename="plot2.png", width=480, height=480)
with(subdata2, plot(Global_active_power, type = "l", xaxt = "n", xlab = "", 
                    ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c(1,1440,2881), labels = c("Thu","Fri","Sat"))
dev.off()