#!/bin/sh
printf '\033%s\007' $(basename $1) # show full path use $1 instead of $(basename $1)
#printf '\033%s\007' $1 # show full path use $1 instead of $(basename $1)

