#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
INPUT=$1

# SQL query start
SQL_QUERY="SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, p.type_id 
           FROM elements e 
           JOIN properties p ON e.atomic_number = p.atomic_number WHERE "

# Check if input is provided
if [ -z "$1" ]; then
  echo "Please provide an element as an argument."
  exit 1
fi

# Initialize a flag to check if the element is found
element_found=false

# Check if the INPUT is a number (atomic number)
if [[ $INPUT =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    SQL_QUERY+="e.atomic_number = $INPUT OR p.atomic_number = $INPUT"
    element_found=true

# Check if the INPUT is a single character (symbol)
elif [[ ${#INPUT} -le 2 ]]; then
    SQL_QUERY+="e.symbol = '$INPUT'"
    element_found=true

# Otherwise, it's a string (name of the element)
else
    SQL_QUERY+="e.name ILIKE '%$INPUT%'"
    element_found=true
fi

# Run query if an element is found
if $element_found; then
    result=$($PSQL "$SQL_QUERY;")
    
    # Process the result if it's not empty
    if [[ -n "$result" ]]; then
        # Process the query result
        while IFS="|" read -r atomic_number symbol name atomic_mass melting_point_celsius boiling_point_celsius type_id; do
            # Fetch the type based on the type_id
            type=$($PSQL "SELECT type FROM types WHERE type_id = $type_id;")
            
            # Construct and display the details
            element_details="The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
            echo "$element_details"
        done <<< "$result"
    else
        echo "I could not find that element in the database."
    fi
else
    echo "I could not find that element in the database."
fi
