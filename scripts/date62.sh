#!/bin/bash

base62=( $(printf '%s ' {0..9}; printf '%s ' {a..z}; printf '%s ' {A..Z};) )

year=$(date +%-y)
month=$(date +%-m)
day=$(date +%-d)

year62=${base62[$year]}
month62=${base62[$month]}
day62=${base62[$day]}

echo -n "$year62$month62$day62"
