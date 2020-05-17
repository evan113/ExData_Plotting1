## Peer-graded Assignment: Course Project 1

## Plot 1
housedata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
## Selecting the data only 1/2/2007 - 2/2/2007
housedata_date <- rbind(housedata[housedata$Date == "1/2/2007", ], housedata[housedata$Date
                                                                             == "2/2/2007", ])
## Transform date to Date format and create 
## new variable with Date and Time joined
housedataDate <- as.Date(housedata_date$Date, "%d/%m/%y")
housedata_Date <- cbind(housedata_date, "DateTime" = as.POSIXct(paste(housedata_date$Date,
                                                                      housedata_date$Time)))
## Plot 1
hist(as.numeric(housedata_Date$Global_active_power), col = "red", main = "Global
     Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

dev.copy(png, file = "plot1.png", width = 480, height = 480) ## copy my plot to a PNG file
dev.off()



