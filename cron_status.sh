#!/bin/bash
set -e
#run date "+%s" > counter 
#to generate the counter file
if [ ! -f counter ]; then
  echo "File not found!,creating file counter"
  date "+%s" > counter
  exit 0
fi

PREV=$(cat counter)

TS=$(date)
NOW=$(date "+%s")

date "+%s" > counter

DELTA=$(( $NOW - $PREV ))

if [[ $DELTA -gt 60 ]]; then
  echo "$TS cron checked in $(( $DELTA - 60 )) seconds late" >> output.log
elif [[ $DELTA -lt 60 ]]; then
  echo "$TS cron checked in $(( 60 - $DELTA )) seconds early" >> output.log
else
  echo "$TS cron checked in right on time" >> output.log
fi
