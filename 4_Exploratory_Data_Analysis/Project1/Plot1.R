library(data.table)

powerData <- fread(file = './4_Exploratory_Data_Analysis/Project1/household_power_consumption.txt', na.strings = "?")

powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

powerData[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]


# Filter Dates for 2007-02-01 and 2007-02-02
sepowerData <- powerData[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(powerData[, Global_active_power], main="Global_Active_Power", 
     xlab="Global_Active_Power (kilowatts)", ylab="Frequency", col="Red")
dev.off()



