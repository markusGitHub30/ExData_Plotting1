#Define some variabels for downloading the data
setwd("C:\\Users\\fluil\\Desktop\\Workspace\\Data_Scientit_Coursa\\R_stuff\\Plot_Projekt1")
Url_rawData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
Dir_rawData <- "./rawData"
url2 <- paste(Dir_rawData, "/", "rawData.zip", sep = "")
folder <- "./data"


# if data is not in working directory --> download data
if (!file.exists(Dir_rawData)) {
    dir.create(Dir_rawData)
    download.file(url = Url_rawData, destfile = url2)
}
if (!file.exists(folder)) {
    dir.create(folder)
    unzip(zipfile = url2, exdir = folder)
}

#set dictonary and load file
setwd(paste(getwd(),"/data",sep=""))
data <- read.table("household_power_consumption.txt", sep = ";",header = T )
#trasform data to numeric
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
#trasform data to Date
data$Date2 <- as.Date(data$Date, "%d/%m/%Y")
#subset data
data_red <- filter(data,Date2 >= "2007-02-01", Date2 <= "2007-02-02")
#weekday?
data_red$Time2 <- strptime(data_red$Time, format="%H:%M:%S")
c[1:1440,"Time2"] <- format(data_red[1:1440,"Time2"],"2007-02-01 %H:%M:%S")
data_red[1441:2880,"Time2"] <- format(data_red[1441:2880,"Time2"],"2007-02-02 %H:%M:%S")


#create plot an safe it into png
png("plot3.png", width=480, height=480)
plot(data_red$Time2,data_red$Sub_metering_1,type="line",ylab="Energy sub metering", col = "black", xlab = "")
with(data_red,lines(Time2,Sub_metering_2,col="red"))
with(data_red,lines(Time2,Sub_metering_3,col="blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)
dev.off()
