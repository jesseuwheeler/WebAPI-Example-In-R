# This file is a demonstration of how to use a Quandl within R. Quandl
# offers a wide range of economic data for free.
#
# Steps:
#   (1) Create a free account at www.quandl.com to get your access key
#   (2) Save a .txt file containing your access key and save the file
#       in the same location that this file is stored. To integrate
#       exactly with this script, name this file "quandl_key.txt"
#   (3) Make sure you have all of the necessary packages installed:
#       (Quandl, ggplot2, dplyr)
#   (4) Set working directory to the location you saved this file
#
# @author: Jesse Wheeler
# @date: Jan 12, 2020

# Loading necessary packages
library(Quandl)
library(ggplot2)
library(dplyr)

# Loading API key (for Quandl this only needs to be done once)
api_key <- sourcetools::read_lines('quandl_key.txt')
Quandl.api_key(api_key = api_key)

# Making a data request from Quandl. Below the code FRED means that I want
# time serires data, and GDP means I want the Gross Domestic Product (for USA)
usGDP <- Quandl('FRED/GDP')

# Rough plot of the time-series results
usGDP %>%
  ggplot(aes(x = Date, y = Value)) +
  geom_line() +
  ggtitle('US GDP') +
  theme(plot.title = element_text(hjust = 0.5))

# Make a request for nasdaq price
nasdaqPrice <- Quandl('NASDAQOMX/XQC',
                      start_date = '2017-01-01',
                      end_date = '2020-01-10')

# Rough plot of the results
nasdaqPrice %>%
  ggplot(aes(x = `Trade Date`, y = `Index Value` )) +
  geom_line() +
  ggtitle('NASDAQ Index') +
  theme(plot.title = element_text(hjust = 0.5)) +
  ylab('Index Value ($)')
