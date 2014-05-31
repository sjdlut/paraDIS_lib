#!/usr/bin/env bash

# This script is based on render_povray.sh from the screwface project of August 2008 with Jaime Marian.  In fact, as of 2008-09-12, it is identical.  
pause=-P
while echo $1 | grep -- - >/dev/null; do
   if echo $1 | grep -- -d >/dev/null; then 
       debug="declare=debug=1"
       descrip=${descrip}"-debug"
       shift
   elif echo $1 | grep -- -h >/dev/null; then 
       echo "usage:  render_povray.sh [options] infile [outfile]"
       echo "infile ends with .pov, and default outfile ends with .png"
       echo "options:"
       echo "-d: debug"
       echo "-f: far away view"
       echo "-g: show grid for debugging"
       echo "-h: help"
       echo "-p: progressive rendering"
       echo "-P: pause when finished"
       echo "-r: reverse view"
       echo "-z: zoomed-in view"
       exit 0       
   elif echo $1 | grep -- -f >/dev/null; then 
       zoom="declare=far=1"
       descrip=${descrip}"-far"
       shift
   elif echo $1 | grep -- -g >/dev/null; then 
       grid="declare=grid=1"
       descrip=${descrip}"-grid"
       shift
   elif echo $1 | grep -- -p >/dev/null; then 
       progressive="+SP4"
       shift
   elif echo $1 | grep -- -P >/dev/null; then 
       pause="+P"
       shift
   elif echo $1 | grep -- -r >/dev/null; then 
       reverse="declare=reverse=1"
       descrip=${descrip}"-reverse"
       shift
   elif echo $1 | grep -- -z >/dev/null; then 
       zoom="declare=zoom=1"
       descrip=${descrip}"-zoom"
       shift
   fi
done

datafile=$1
image=${2:-$(echo $datafile | sed 's/.pov//')}"${descrip}.png"
height=800
width=1000
antialias="+A0.1 +AM2 +R3" 
set -x
if povray $debug $zoom $reverse $grid +I${datafile} +o${image} +H${height} +W${width}  +Ft $progressive $pause $antialias; then 
    echo "output file saved as $image"
fi