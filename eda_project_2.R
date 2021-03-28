library(dplyr)
library(magrittr)
library(lubridate)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005,
# and 2008.
# 
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 
# to 2008? Use the base plotting system to make a plot answering this question.
# 
# 3. Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore 
# City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot 
# answer this question.
# 
# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
# 
# 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
# 
# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?


download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
              , destfile = 'FNEI_data.zip'
              , method = 'curl')

# # Unzip and load table
dir.create("FNEI_data")
zip <- unzip("FNEI_data.zip", exdir = "FNEI_data")
# Peek at data
readLines(zip[1], 2)

# The data that you will use for this assignment are for 1999, 2002, 2005, and 2008
df <- read.csv(zip[1]
               , header = TRUE
               , sep = ";"
               , stringsAsFactors = FALSE) %>%
  dplyr::filter(., (Date == '1/2/2007' | Date == '2/2/2007'))
df[3:9] %<>% sapply(., as.numeric)

names(df) %<>% tolower()
gsub('?', '', df, fixed = TRUE)

df$date %<>% as.Date('%d/%m/%Y')
# df$time %<>% strptime(format = '%H:%M:%S')
df$datetime <- as.POSIXct(as.character(paste(df$date, df$time)), format = '%Y-%m-%d %H:%M:%S')
# We're not going to use lubridate :/
# df$date %<>% lubridate::dmy()
df$time %<>% lubridate::hms()

png(filename = "plot1.png")
# Plot 1
hist(df$global_active_power
     , col = 'red'
     , main = 'Global Active Power'
     , xlab = 'Global Active Power (kilowatts)'
)
axis(side = 2, at = 1200, labels = 1200)
dev.off()
