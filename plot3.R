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
subdata3 <- rbind(subdata, data[69517,])

##Make Third plot

png(filename="plot3.png", width=480, height=480)
plot(subdata3$Sub_metering_1, type = "l",xaxt = "n", xlab = "", 
     ylab = "Energy sub metering")
lines(subdata3$Sub_metering_2, col = "red")
lines(subdata3$Sub_metering_3, col = "blue")
axis(side = 1, at = c(1,1440,2881), labels = c("Thu","Fri","Sat"))
legend("topright", names(subdata3[7:9]), lty = c(1,1,1), col = c("black","red","blue"))
dev.off()