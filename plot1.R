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

##Make First plot

png(filename="plot1.png", width=480, height=480)
hist(subdata$Global_active_power, col ="red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()