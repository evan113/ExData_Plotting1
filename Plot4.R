## Read and create consumption data
housedata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
names(housedata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                      "Voltage", "Global_intensity", "Sub_metering_1","Sub_metering_2",
                      "Sub_metering_3")
housedata_small <- subset(housedata, housedata$Date=="1/2/2007" | housedata == "2/2/2007")

## Transform date and time
housedata_small$Date <- as.Date(housedata_small$Date, format = "%d/%m/%y")
housedata_small$Time <- strptime(housedata_small$Time, format = "%H:%M:%S")
housedata_small[1:1440, "Time"] <- format(housedata_small[1:1440, "Time"], "2007-02-01 %H: %M: %S")
housedata_small[1441:2880, "Time"] <- format(housedata_small[1441:2880, "Time"], "2007-02-02 %H: %M: %S")

## Plot
par(mfrow = c(2, 2))

with(housedata_small, {
        plot(housedata_small$Time, as.numeric(as.character(housedata_small$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power")
        plot(housedata_small$Time, as.numeric((as.character(housedata_small$Voltage)), type = "l", xlab = "Datetime", ylab = "Voltage"))
        plot(housedata_small$Time, housedata_small$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
        with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_1))))
        with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
        with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)
        plot(housedata_small$Time, as.numeric(as.character(housedata_small$Global_active_power)), type = "l", xlab = "datetime", ylab = "Global_Reactive_Power")
})

## Creating png file
dev.copy(png, file = "plot4.png") ## copy my plot to a PNG file
dev.off()




