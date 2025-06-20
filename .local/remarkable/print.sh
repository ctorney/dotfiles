#!/bin/bash


for f in "$@"
do
  # strip the filename from the full path
  filename=$(basename -- "$f")
  # create a filename in the tmp directory
  tmpfile="/tmp/$filename"
  /Users/colin.torney/.local/bin/pdfcropmargins -u -s "$f" -o "$tmpfile"
  /opt/homebrew/bin/rmapi put "$tmpfile" "3. RESOURCES/Printer"
  rm "$tmpfile"
done
