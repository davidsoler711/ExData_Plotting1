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

png(filename= "./figure/Plot2.png")
plot(DataEPC$Time, DataEPC$Global_active_power, col = "black", main = "Global Active Power", 
     ylab= "Global Active Power (Kilowatts)", type = "l",
     xlab= "Days")
dev.off()
