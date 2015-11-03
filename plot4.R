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
subdata4 <- cbind(subdata3, as.POSIXct(paste(data2[66637:69517], data3[66637:69517]), format="%Y-%m-%d %H:%M:%S"))
colnames(subdata4)[colnames(subdata4)=="as.POSIXct(paste(data2[66637:69517], data3[66637:69517]), format = \"%Y-%m-%d %H:%M:%S\")"] <- "Datetime"


##Make set of plots
png(filename = "plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
with(subdata3, plot(Global_active_power, type = "l", xaxt = "n", xlab = "", 
                    ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c(1,1440,2881), labels = c("Thu","Fri","Sat"))

plot(subdata4$Datetime, subdata4$Voltage, type ="l", xlab = "datetime", 
     ylab = "voltage")

plot(subdata3$Sub_metering_1, type = "l",xaxt = "n", xlab = "", 
     ylab = "Energy sub metering")
lines(subdata3$Sub_metering_2, col = "red")
lines(subdata3$Sub_metering_3, col = "blue")
axis(side = 1, at = c(1,1440,2881), labels = c("Thu","Fri","Sat"))
legend("topright", names(subdata3[7:9]), lty = c(1,1,1), col = c("black","red","blue"))

plot(subdata4$Datetime, subdata4$Global_reactive_power, type ="l", xlab = "datetime", 
     ylab = "Global_Reactive_Power")
dev.off()