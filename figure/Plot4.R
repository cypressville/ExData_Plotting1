download <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "temp")
unzip("temp")
unlink("temp")

#reading data
hpc <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# add a column of datetime
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

#subset the data by the date range
hpc_sub <- subset(hpc, (hpc$Date == "2007-02-01" | hpc$Date== "2007-02-02"))

#Plot4
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
par(mar=c(4,4,4,4))

plot(hpc_sub$DateTime, hpc_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(hpc_sub$DateTime, hpc_sub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(hpc_sub$DateTime, hpc_sub$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(hpc_sub$DateTime, hpc_sub$Sub_metering_2, type = "l", col = "red")
points(hpc_sub$DateTime, hpc_sub$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", cex = 0.8)

plot(hpc_sub$DateTime, hpc_sub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
