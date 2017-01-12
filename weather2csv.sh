#!/bin/bash

set -e
url_prefix="https://www.wunderground.com/history/zipcode"
url_suffix="DailyHistory.html?HideSpecis=1&format=1"

# Get ZIP code
zip=$1
while [ -z "$zip" ]; do
	read -p "Please enter a ZIP code: " zip
done

# Get start date (or now)
[ -z "$2" ] && date_start=$(date "+%Y-%m-%d") || date_start=$(date -f "%Y-%m-%d" -j "$2" "+%Y-%m-%d")

# Get end date (or now)
[ -z "$3" ] && date_end=$date_start || date_end=$(date -f "%Y-%m-%d" -j "$3" "+%Y-%m-%d")
date_end=$(date -j -v +1d -f "%Y-%m-%d" "$date_end" "+%Y-%m-%d")

# Get the filename
[ -z "$4" ] && file="output.csv" || file=$4
> $file

# Traverse the dates
i=$date_start
skip=1
while [ "$i" != "$date_end" ]; do

	# Parse the date parameters
	year=$(date -f "%Y-%m-%d" -j "$i" +"%Y")
	month=$(date -f "%Y-%m-%d" -j "$i" +"%-m")
	day=$(date -f "%Y-%m-%d" -j "$i" +"%-d")

	# curl wunderground.com, skipping subsequent headers
	curl -s -k $url_prefix/$zip/$year/$month/$day/$url_suffix | sed 1,"$skip"d | sed -e "s/<[^>]*>//g" >> $file
	skip=2

	# Move to next day
	i=$(date -j -v +1d -f "%Y-%m-%d" "$i" "+%Y-%m-%d")
done
echo "Done"