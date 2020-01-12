# This file is a demonstration of how to use a web based API within R.
# In particular, this file demonstrates the use of the api.ipstack API,
# which allows a user to get their current IP address and a predicted
# location of the address
#
# Steps:
#   (1) Create a free account with api.ipstack.com in order to get your
#       own api-access key
#   (2) Save a .txt file containing your access key and save the file
#       in the same location that this file is stored. To integrate
#       exactly with this script, name this file "ip_apikey.txt"
#   (3) Make sure you have all of the necessary packages installed
#   (4) Set working directory to the location you saved this file
#
# @author: Jesse Wheeler
# @date: Jan 12, 2020

library(jsonlite)  # Used to convert JSON data
library(httr)  # Used to make HTTP request

options(stringsAsFactors = FALSE)

# The website to which we are going to make a request
ipURL <- 'http://api.ipstack.com/check'

# This is your own unique access key
ip_access_key <- sourcetools::read_lines('ip_apikey.txt')

# Add your access key to the website URL
ipURL <- paste0(ipURL, '?', 'access_key=', ip_access_key)

# Visit URL (which makes a GET request to the ipstack api)
response <- GET(url = ipURL)

# This is just to see what the response looks like
class(response)
summary(response)
response$headers
response$content # Content looks weird because it is given as bytes

raw_content <- response$content

# the function rawToChar will convert from bytes to characters (something
# that we can read easily)

rawToChar(response$content) # This is a JSON object (Java Script Object Notation)

# the function fromJSON will convert JSON object to an R list.

result <- fromJSON(rawToChar(response$content))
result

result$ip
result$city
result$latitude
result$longitude
