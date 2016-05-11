#!/bin/bash

echo "Building index html"
pandoc -s -S --toc --template=custom.html -c "./labs.css" index.md -o index.html


echo "Building html for suggestions"
pandoc -s -S --toc --template=custom.html -c "../../labs.css" suggestions.md -o ./labs/suggestions/suggestions.html


#for lec_name in "01-Introduction" "02-Layout" "03-Lifecycles" "04-Fragmenu.md" "05-Sensors" "06-Threads.md" "07-Persistance"
for lec_name in "09-Networks"
do
   echo Building slides for lecture $lec_name
   pandoc --slide-level 2 --template=custom.beamer -V theme=bjeldbak --toc -t beamer $lec_name.md -o ./slides/$lec_name-slides.pdf
   pdfnup ./slides/$lec_name-slides.pdf -q --nup 2x2 --noautoscale false --delta "0.2cm 0.3cm" --frame true --scale 0.95 -o ./slides/$lec_name-handouts.pdf
done


#for lab_name in "1" "2" "3" "4" "5" "6" "7" "8"
# for lab_name in "8"
# do
# 	echo "Building html for lab "$lab_name
# 	pandoc -s -S --toc --template=custom.html -c "../../labs.css" 0$lab_name-labs.md -o ./labs/lab$lab_name/0$lab_name-labs.html
# done
