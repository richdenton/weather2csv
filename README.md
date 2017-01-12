weather2csv
===========

### Introduction

Ever wanted to know the average temperature of your home neighborhood? How about the recent weather pattern of an upcoming destination? weather2csv allows you to quickly download a customizable comma separated value file (or CSV) of hourly weather details including everything from dew point to wind speed. Data is supplied by [Weather Underground](https://www.wunderground.com).

### Getting Started

To use weather2csv, you need only supply a US-based ZIP code. This can be submitted as the first inline parameter or fed directly into the script itself if no arguments are passed.

```shell
sh weather2csv.sh 90210
```

The above will return hourly readings for today only. For other days, or to expand your timeframe, you can supply a start and an end date. Dates must be in the format __YYYY-MM-DD__. Say you want to obtain weather data for the entire month of December 2016:

```shell
sh weather2csv.sh 90210 2016-12-01 2016-12-31
```

By default, weather2csv exports an `output.csv` file. To change this, simply append a new filename to the end of the list of parameters:

```shell
sh weather2csv.sh 90210 2016-12-01 2016-12-31 december.csv
```