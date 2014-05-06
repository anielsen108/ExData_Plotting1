## Read in data -- limit rows to 2007-02-01 and 2007-02-02
df <- read.table(file = "household_power_consumption.txt", 
                 sep = ";",
                 na.strings = "?",
                 skip = 66637,  
                 nrows = 69517-66637,
                 col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),        
                 colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
)

## convert date/time character columns to their respective classes
df$Time <- strptime(paste(df$Date,df$Time, sep = ""),"%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date,"%d/%m/%Y")

## output to PNG file
png(file = "plot1.png", width = 480, height = 480)

## create histogram
hist(df$Global_active_power, 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"    
)

## close PNG file
dev.off()
                                
