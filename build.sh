#!/bin/bash
echo "Building index html"
pandoc -s -S --toc --template=custom.html -c labs.css index.md -o index.html

echo "Building Slides for lecture 1"
pandoc --slide-level 2 --template=custom.beamer --toc -t beamer 01-Introduction.md -o 01-Introduction-slides.pdf
pdfnup 01-Introduction-slides.pdf -q --nup 2x2 --noautoscale false --delta "0.2cm 0.3cm" --frame true --scale 0.95 -o 01-Introduction-handouts.pdf

echo "Building html for lab 1"
pandoc -s -S --toc --template=custom.html -c labs.css 01-labs.md -o 01-labs.html
#pandoc --slide-level 2 --template=custom.beamer --toc  -t beamer presentation.md -o presentation.tex