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
png(file = "plot4.png", width = 480, height = 480)

## set up grid for multiple base plots
par(mfrow = c(2,2))

## Plot 1: create line plot
plot(df$Time, df$Global_active_power, 
     type = "l",     
     xlab = "",
     ylab = "Global Active Power",    
)

## Plot 2: create line plot
plot(df$Time, df$Voltage, 
     type = "l",     
     xlab = "datetime",
     ylab = "Voltage",    
)

## Plot 3: create multiple series base plot
## New Canvas, Include Axis
par(new="F",xaxt="s", yaxt="s") 
with(df, plot(Time, Sub_metering_1, 
              ylim = yrange,
              type = "l",  col = "black",        
              xlab = "", ylab = "Energy sub metering"),             
)

## Keep Canvas, no labels
par(new=T)
with(df, plot(Time, Sub_metering_2, 
              ylim = yrange,
              type = "l",  col = "red",
              xlab = "", ylab="")
)

## Keep Canvas, no labels
par(new=T)
with(df, plot(Time, Sub_metering_3, 
              ylim = yrange,
              type = "l",  col = "blue",
              xlab="", ylab="")              
)

## Add Legend
legend(x = "topright", 
       lwd=1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") 
)

## Plot 4: create line plot
plot(df$Time, df$Global_reactive_power, 
     type = "l",     
     xlab = "datetime",
     ylab = "Global_reactive_power",    
)

## close PNG file
dev.off()
