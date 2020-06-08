download <- download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                          destfile = "temp")
unzip("temp")
unlink("temp")

#reading data
hpc <- read.table("household_power_consumption.txt", 
                  sep = ";", header = TRUE, quote= "", strip.white=TRUE, stringsAsFactors = FALSE, na.strings= "?")

# add a column of datetime
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

#subset the data by the date range
hpc_sub <- subset(hpc, (hpc$Date == "2007-02-01" | hpc$Date== "2007-02-02"))

#Plot2:  
png("plot2.png", width = 480, height = 480)
plot(hpc_sub$DateTime, hpc_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
