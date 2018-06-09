#!/bin/bash

directory="/tmp/gThumb-$(date +%s)"
if [ ! -d "$directory" ]; then
  mkdir "$directory"
fi

case $1 in
  -original)  maxsize="noresize";;
  -verylarge) maxsize=2000;;
  -large)     maxsize=1600;;
  -medium)    maxsize=1200;;
  -small)     maxsize=800;;
esac

if [ $maxsize == "noresize" ]; then
  filestring=''
  for i in "$@"; do
    if [ -f "$i" ]; then
      myfile=`readlink -f "$i"`
      if [ "$filestring" == "" ]; then
        filestring="$myfile"
      else
        filestring="$filestring,$myfile"
      fi
    fi
  done
else
  files=()
  x=0
  for i in "$@"; do
    if [ -f "$i" ]; then
      filename=`basename "$i"`
      filepath="$directory/$filename"
      read width height orient < <(identify -format "%w %h %[EXIF:Orientation]" "$i")
      if [ \( $width -gt $height -a $orient -le 4 \) -o \( $width -lt $height -a $orient -ge 5 \) ]; then
        convert "$i" +profile '*' -auto-orient -quality 95 -resize "${maxsize}>" -adaptive-sharpen 0x0.8 "$filepath"
      else
        convert "$i" +profile '*' -auto-orient -quality 95 -resize "x${maxsize}>" -adaptive-sharpen 0x0.8 "$filepath"
      fi
      files[$x]=$filepath
      ((x+=1))
    fi
  done

  filestring=''
  for i in "${files[@]}"; do
    if [ "$filestring" == "" ]; then
      filestring="$i"
    else
      filestring="$filestring,$i"
    fi
  done
fi

if [ "$filestring" != "" ]; then
  thunderbird -compose "attachment='$filestring'"
fi

exit 0
