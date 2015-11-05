##This section stores the url, zip file name, and unzipped file name to variables. It then
##checks to see if the user does not have these files in their working directory.
##If they don't, it downloads the file and unzips it.

require(lubridate)
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
powerfile <- "powerconsumption.zip"
powerdata <- "household_power_consumption.txt"

if (!file.exists(powerfile)){
        print("downloading file")
        download.file(Url, powerfile)
}
if (!file.exists(powerdata)) { 
        print("unzipping file")
        unzip(powerfile)
} 


##This section first reads only the first row to extract the column names. It then reads only
##certain rows corresponding to the desired dates and changes the column names to those 
##extracted earlier. Finally, it adds a new column that combines the date and time and
## changes class into POSIX class.

rawcolumns <- read.table("household_power_consumption.txt", header = T, 
                           sep = ";", nrows = 1)
powercolumns <- c(names(rawcolumns))
powertable <- read.table("household_power_consumption.txt", sep = ";", skip = 66637, 
                nrows = 2880, na.strings = "?", col.names = powercolumns)
powertable$datetime <- dmy_hms(paste(powertable[, 1], powertable[, 2]))


##This section plots the graph and saves it as a .png file.

png(filename = "plot2.png", type = "cairo")
plot(powertable$datetime, powertable$Global_active_power, 
     ylab = "Global Active Power (kilowatts)", type = "l", xlab = "", lwd = 1, col="black")
dev.off()