#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"
input=$1
SQL_QUERY="SELECT * FROM elements e JOIN properties p ON e.atomic_number = p.atomic_number WHERE "
if [[ -z $input ]];then
  echo "Please provide an element as an argument."
fi

# Check if the input is a number
if [[ $input =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    echo "It's a number."
# Check if the input is a single character
elif [[ ${#input} -eq 1 ]]; then
    echo "It's a single character."
# Otherwise, it's a string
else
    echo "It's a string."
fi