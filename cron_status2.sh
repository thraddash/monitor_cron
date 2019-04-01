#!/bin/bash
set -e
#run command below, to generate the counter file
#date "+%s" > counter
 

if [ ! -f counter ]; then
  echo "File not found!,creating file counter"
  date "+%s" > counter
  exit 0
fi

# update "VERIFY_SERVERY" with your user login and the server you want to access.
# create an sshkey and put the public key on the server were you want to connect to

VERIFY_SERVER=$(ssh user0yourserver 'date')

PREV=$(cat counter)

TS=$(date)
NOW=$(date "+%s")

date "+%s" > counter

DELTA=$(( $NOW - $PREV ))

if [[ $DELTA -gt 60 ]]; then
  echo "$TS cron checked in $(( $DELTA - 60 )) seconds late:$VERIFY_SERVER" >> output.log
elif [[ $DELTA -lt 60 ]]; then
  echo "$TS cron checked in $(( 60 - $DELTA )) seconds early:$VERIFY_SERVER" >> output.log
else
  echo "$TS cron checked in right on time:$VERIFY_SERVER" >> output.log
fi
