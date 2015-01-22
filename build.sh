#!/bin/bash
echo "Building index html"
pandoc -s -S --toc --template=custom.html -c "./labs.css" index.md -o index.html

#echo "Building Slides for lecture 1"
#lec_name="01-Introduction"
#pandoc --slide-level 2 --template=custom.beamer --toc -t beamer $lec_name.md -o ./slides/$lec_name.pdf
#pdfnup ./slides/$lec_name-slides.pdf -q --nup 2x2 --noautoscale false --delta "0.2cm 0.3cm" --frame true --scale 0.95 -o ./slides/$lec_name-handouts.pdf

# echo "Building html for lab 1"
# pandoc -s -S --toc --template=custom.html -c "../../labs.css" 01-labs.md -o ./labs/lab1/01-labs.html

# echo "Building html for suggestions"
# pandoc -s -S --toc --template=custom.html -c "../../labs.css" suggestions.md -o ./labs/suggestions/suggestions.html

# lec_name="02-Layout"
# echo "Building Slides for "$lec_name
# pandoc --slide-level 2 --template=custom.beamer --toc -t beamer $lec_name.md -o ./slides/$lec_name-slides.pdf
# pdfnup ./slides/$lec_name-slides.pdf -q --nup 2x2 --noautoscale false --delta "0.2cm 0.3cm" --frame true --scale 0.95 -o ./slides/$lec_name-handouts.pdf

# lab_name=2
# echo "Building html for lab "$lab_name
# pandoc -s -S --toc --template=custom.html -c "../../labs.css" 0$lab_name-labs.md -o ./labs/lab2/0$lab_name-labs.html

lec_name="03-Lifecycles"
echo "Building Slides for "$lec_name
pandoc --slide-level 2 --template=custom.beamer --toc -t beamer $lec_name.md -o ./slides/$lec_name-slides.pdf
pdfnup ./slides/$lec_name-slides.pdf -q --nup 2x2 --noautoscale false --delta "0.2cm 0.3cm" --frame true --scale 0.95 -o ./slides/$lec_name-handouts.pdf

lab_name=3
echo "Building html for lab "$lab_name
pandoc -s -S --toc --template=custom.html -c "../../labs.css" 0$lab_name-labs.md -o ./labs/lab2/0$lab_name-labs.html
