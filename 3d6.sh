#!/bin/bash

uuid=$(uuidgen)
min=1
# Function to roll 3d6
roll_3d6() {
  echo $((RANDOM % 6 + 1 + RANDOM % 6 + 1 + RANDOM % 6 + 1))
}

# Function to determine Labyrinth Lord modifiers based on score
get_modifier() {
  local score=$1
  if [ $score -le 3 ]; then
    echo -3
  elif [ $score -le 5 ]; then
    echo -2
  elif [ $score -le 8 ]; then
    echo -1
  elif [ $score -le 12 ]; then
    echo 0
  elif [ $score -le 15 ]; then
    echo 1
  elif [ $score -le 17 ]; then
    echo 2
  else
    echo 3
  fi
}

# Default ability names
abilities=("STR" "DEX" "CON" "INT" "WIS" "CHA")

# Roll for each ability and calculate modifiers
generate () {
for ability in "${abilities[@]}"; do
  roll=$(roll_3d6)
  modifier=$(get_modifier $roll)
  total=$(($modifier + $total))
  abltotal=$(($abltotal + $roll))
  echo "$ability: $roll MOD: $modifier" >> $uuid
done
}

total=0
touch $uuid

while [ $total -lt $min ]; do
  total=0
  abltotal=0
  rm $uuid
  generate
done
echo "~" >> $uuid
echo "TOT: $abltotal SUM: $total" >> $uuid
cat $uuid | column -t
rm $uuid

