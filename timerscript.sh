#!/bin/bash4

# 7200 is 2hours

MAX_WAIT_SECS=60
DURATION=$SECONDS

while true
do
  echo "This is the the Finish Check"

  if [ $DURATION -ge $MAX_WAIT_SECS ]; then 
    echo "Expire Time"
    exit 0
  fi
  sleep 10s
  DURATION=$SECONDS
done