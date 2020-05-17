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
plot(housedata_small$Time, housedata_small$Sub_metering_1, type = "n", xlab = "",
     ylab = "Energy Sub Metering")
with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_1))))
with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red"))
with(housedata_small, lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
title(main = "Energy sub-metering")

## Creating png file
dev.copy(png, file = "plot3.png") ## copy my plot to a PNG file
dev.off()



