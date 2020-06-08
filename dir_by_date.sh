#!/bin/bash

for each in *.*
do
  date=$(date +%Y-%m-%d -r "$each");
  _DATES+=($date);
  FILES+=($each);
done

DATES=$(printf "%s\n" "${_DATES[@]}" | sort -u);
for date in ${DATES[@]}; do
  if [ ! -d "$date" ]; then
    mkdir "$date"
  fi
done

for i in  ${FILES[@]}; do
  dest=$(date +%Y-%m-%d -r "$i")
  mv $i $dest/$i
done
