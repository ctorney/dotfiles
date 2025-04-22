#!/bin/bash

# Get the current date in the desired format
current_date=$(date +"%d %B %Y")

sed "s/CURRENT_DATE/${current_date}/g" template.tex >current_week.tex

# Convert the LaTeX file to a PDF
pdf_file="weekly_planner_$(date +%Y%m%d).pdf"

xelatex -output-directory=$(pwd) -jobname="${pdf_file%.pdf}" current_week.tex >/dev/null

/opt/homebrew/bin/rmapi put "${pdf_file}" "2. AREAS/Time Management"
# Remove the temporary LaTeX file
rm current_week.tex
rm weekly_planner_*

echo "Weekly planner PDF created: $pdf_file"
