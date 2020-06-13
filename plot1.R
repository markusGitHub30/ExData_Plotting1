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
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
#trasform data to Date
data$Date2 <- as.Date(data$Date, "%d/%m/%Y")
#subset data
data_red <- filter(data,Date2 >= "2007-02-01", Date2 <= "2007-02-02")

#create histogram and safe it into png
png("plot1.png", width=480, height=480)
hist(data_red$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",col = "red")
dev.off()
