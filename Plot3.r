#Load the required package for the analysis

library(dplyr)
library(tidyr)

# Set the directory origin, use slash NOT BACKSLASH

setwd("G:\dsoler\Documents\David Soler\7. Análisis de datos\datasciencecoursera\ExData_Plotting1")

# Create data frames. Its necesary to give the direction of the data in CSV

DataEPC <- read.table("household_power_consumption.txt",header=TRUE, row.names=NULL, sep = ";")


#Transform date and hour in to the format that R recognizes
DataEPC$Date <- as.Date(ifelse(nchar(as.character(DataEPC$Date))==7, 
                               paste0('0', as.character(DataEPC$Date)), 
                               as.character(DataEPC$Date) ),
                        format="%d/%m/%Y")

#Filter the data by the Date in the format "AAAA-MM-DD". Date1 is the date it starts, Date2 is the date it ends.
Date1 <- "2007-02-01"
Date2 <- "2007-02-03"

DataEPC <- filter(DataEPC, DataEPC$Date >=Date1 & DataEPC$Date <Date2 )

#Concatenate the data of date and time in time data.
DataEPC$Time <- strptime(paste(DataEPC$Date, DataEPC$Time), format = "%Y-%m-%d%H:%M:%S")

DataEPC2 <- select(DataEPC, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)

#Create the plot
png(filename= "./figure/Plot3.png")
plot(DataEPC2$Time, DataEPC2$Sub_metering_1, col = "black", main = "Energy Sub Metering", 
     ylab= "Energy SubMetering", type = "l",
     xlab= "Days")
lines(x = DataEPC2$Time, y = DataEPC2$Sub_metering_2, type = "l", col = "red")
lines(x = DataEPC2$Time, y = DataEPC2$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), 
       fill = c("black", "red", "blue"), bty = "n")
dev.off()
