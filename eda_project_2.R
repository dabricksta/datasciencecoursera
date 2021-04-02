#### Imports ####

library(dplyr)
library(magrittr)
library(lubridate)
library(ggplot2)

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

#### Prep ####
# Don't use this if your sysadmin blocks curl, etc.
# download.file(url = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
#               , destfile = 'FNEI_data.zip'
#               , method = 'curl')

# Instead, if you download the file manually...
# C:\Users\U570G1\Documents\Continuing Ed\exdata_data_NEI_data.zip
tbl <- readline(prompt = "Enter data file name: ")

# Unzip and load table
dir.create("FNEI_data")
zip <- unzip(tbl, exdir = "FNEI_data")
# Peek at data
# readLines(zip[2], 10)

# PM2.5 emissions data for 1999, 2002, 2005, and 2008. 
# For each year, the table contains number of tons of PM2.5 
# emitted from a specific type of source for the entire year.
df <- readRDS(file = zip[2])
names(df) %<>% tolower()

# Features:
# fips: A five-digit number (represented as a string) indicating the U.S. county
# scc: The name of the source as indicated by a digit string (see source code classification table)
# pollutant: A string indicating the pollutant
# emissions: Amount of PM2.5 emitted, in tons
# type: The type of source (point, non-point, on-road, or non-road)
# year: The year of emissions recorded

# Mapping from the scc digit strings in the emissions table to the actual name of the PM2.5 source
codebook <- readRDS(file = zip[1])
names(codebook) %<>% tolower()

### Plot ####

# Plot 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base 
# plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999,
# 2002, 2005, and 2008.
png(filename = "plot1.png")

df %>%
  select(emissions, year) %>%
  group_by(year) %>%
  summarise(total = sum(emissions)) %>%
  with(plot(year
            , total
            , main = 'Total PM2.5 emissions over time'
            , type = 'l')
       )
dev.off()


# Plot 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a plot answering this question.
png(filename = "plot2.png")
filter(df, fips == "24510") %>%
  select(emissions, year) %>%
  group_by(year) %>%
  summarise(total = sum(emissions)) %>%
  with(plot(year
            , total
            , main = 'Baltimore PM2.5 emissions over time'
            , type = 'l')
  )
dev.off()

# Plot 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have 
# seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this 
# question.
png(filename = "plot3.png")
filter(df, fips == "24510") %>%
  select(emissions, year, type) %>%
  group_by(year, type) %>%
  summarise(total = sum(emissions)) %>%
  ggplot2::qplot(year
        , total
        , geom = c("point", "line")
        , data = .
        , main = 'Total PM2.5 emissions over time by type'
        , facets = . ~ type
        )

dev.off()

# Plot 4: Across the United States, how have emissions from coal combustion-related sources changed  
# from 1999–2008?

df %<>% left_join(select(codebook, scc, short.name), by = 'scc')
coal_combustion_emissions <- grep(pattern = '(.*)Comb(.*)Coal(.*)', x = df$short.name)

df[coal_combustion_emissions, ] %>%
  select(emissions, year) %>%
  group_by(year) %>%
  summarise(total = sum(emissions)) %>%
  ggplot(aes(year
              , total)
         , geom = c("point", "line")
  ) +
  geom_point() +
  geom_line()

dev.off()

# Plot 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
png(filename = "plot5.png")
motor_vehicle_emissions <- grep(pattern = '(.*)Vehicle(.*)', x = df$short.name)

df[motor_vehicle_emissions, ] %>%
  filter(fips == "24510") %>%
  select(emissions, year) %>%
  group_by(year) %>%
  summarise(total = sum(emissions)) %>%
  ggplot(aes(year
             , total)
         , geom = c("point", "line")
  ) +
  geom_point() +
  geom_line()

dev.off()

# Plot 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
# sources in Los Angeles County, California (fips == "06037"). Which city seen greater changes over time 
# in motor vehicle emissions?
png(filename = "plot6.png")

df[motor_vehicle_emissions, ] %>%
  filter(fips == "24510" | fips == "06037") %>%
  select(emissions, year, fips) %>%
  group_by(year, fips) %>%
  summarise(total = sum(emissions)) %>%
  ggplot(aes(year
             , total
             , color = fips)
         , geom = c("point", "line")
  ) +
  geom_point() +
  geom_line()

dev.off()
