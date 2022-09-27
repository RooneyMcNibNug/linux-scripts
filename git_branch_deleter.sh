#!/bin/bash

## Run against repo to delete all git branches created before n

for x in $(git branch | sed /\*/d); do 
  if [ -z "$(git log -1 --before='3 week ago' -s $x)" ]; then # change timeframe here if desired
    git branch -D $x
  fi
done
