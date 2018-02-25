library(data.table)
library(lubridate)

initDF <- function(cl, n) {
        df <- fread(cl,
                    sep = ";",
                    header = FALSE,
                    nrows = n,
                    na.strings = "?",
                    data.table = FALSE,
                    stringsAsFactors = FALSE)
}

# initialize the data
raw <- initDF("grep '^[01|02]/[02]/2007' ./data/household_power_consumption.txt", -1)
colnames(raw) <- initDF("./data/household_power_consumption.txt", 1)
raw$Date <- dmy(raw$Date)

# plot the graph and save to png
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(raw$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts")

# tidy up
dev.off()
rm(initDF, raw)

