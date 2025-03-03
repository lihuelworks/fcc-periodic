#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
INPUT=$1
SQL_QUERY="SELECT * FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number WHERE "
if [[ -z $INPUT ]];then
  echo "Please provide an element as an argument."
fi

# Check if the INPUT is a number
if [[ $INPUT =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo "It's a number."
# Check if the INPUT is a single character
elif [[ ${#INPUT} -eq 1 ]]; then
    echo "It's a single character."
# Otherwise, it's a string
else
    echo "It's a string."
fi