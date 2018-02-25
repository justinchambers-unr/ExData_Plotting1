library(data.table)
library(lubridate)
library(dplyr)

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

# mutate dates and times
raw$Date <- dmy(raw$Date)
raw$Time <- hms(raw$Time)
raw$fullDateTime <- raw$Date + raw$Time

# plot the graph and save to png
png(filename = "plot3.png", width = 480, height = 480, units = "px")
with(raw, {
        plot(fullDateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(fullDateTime, Sub_metering_2, col="red", type = "l")
        lines(fullDateTime, Sub_metering_3, col="blue", type = "l")
        legend("topright", col = c("black", "red", "blue"), pch = "_", legend = names(raw)[7:9])
})

# tidy up
dev.off()
rm(initDF, raw)

