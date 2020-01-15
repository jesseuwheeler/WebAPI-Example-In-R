# This file is a demonstration of how to use a web based API within R.
# In particular, this file demonstrates the use of the api.ipstack API,
# and then uses the result to get a weather report of the ip address
# location.
#
# Steps:
#   (1) Create a free account with api.ipstack.com in order to get your
#       own api-access key
#   (2) Create a free account with openweathermap.org in order to get
#       an access key to the weather API
#   (3) Save a .txt file containing your access key and save the file
#       in the same location that this file is stored. To integrate
#       exactly with this script, name this file "ip_apikey.txt"
#   (4) Save a .txt file containing the openweather api key.
#       save the file as weather_appid.txt in the same location where
#       this file is stored
#   (5) Make sure you have all of the necessary packages installed:
#       (jsonlite, httr, sourcetools)
#   (6) Set working directory to the location you saved this file
#
# @author: Jesse Wheeler
# @date: Jan 12, 2020


# Loading Packages --------------------------------------------------------

library(httr) # Used to get information from websites
library(jsonlite) # Used to convert information to R list
options(stringsAsFactors = FALSE)


# Get IP adress Info ------------------------------------------------------

# Website that we are going to request IP address from
ipURL <- 'http://api.ipstack.com/check'

# Saving the ip address API key
ip_access_key <- sourcetools::read_lines('ip_apikey.txt')

# Adding API key to URL
ipURL <- paste0(ipURL, '?', 'access_key=', ip_access_key)

# Vist URL (making a GET request for IP address information)
response <- GET(url = ipURL)

# Save results
IPresults <- fromJSON(rawToChar(response$content))


# Get Weather Info --------------------------------------------------------

# The base URL we will visit to get the weather report
weatherURL <- 'http://api.openweathermap.org/data/2.5/weather'

# Reading in the openweather API key
appid <- sourcetools::read_lines('weather_appid.txt')

# Saving options to be used in the URL
units <- 'imperial'
lat <- IPresults$latitude
lon <- IPresults$longitude

# Updating the weather request with API key and options
weatherQuery <- paste0(
  weatherURL, '?',
  'appid=', appid, '&',
  'units=', units, '&',
  'lat=', lat, '&',
  'lon=', lon
)

# weatherQuery
response <- GET(url = weatherQuery)

# Making the request and saving the results
weatherResult <- fromJSON(rawToChar(response$content))

# Examining the results
class(weatherResult)
summary(weatherResult)
weatherResult

# I'm defining a function to print the weather report in a nice way
print_weather_report <- function(result) {
  # Prints the weather report in an easy to read fashion.
  #
  # Args:
  #   result: A list object containing the results from a query
  #   to openweathermap.org
  #
  # Returns:
  #   None
  cat(
    'Weather: ', result$weather$main,
    '\nMin Temperature: ', result$main$temp_min,
    '\nMax Temperature: ', result$main$temp_max,
    '\nCurrent Temperature: ', result$main$temp,
    '\nFeels Like: ', result$main$feels_like,
    '\nHumidity: ', result$main$humidity
  )
}

print_weather_report(weatherResult)
