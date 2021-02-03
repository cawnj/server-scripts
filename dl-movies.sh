#!/bin/bash

file=links.txt
until [[ -z $(grep '[^[:space:]]' $file) ]]
do
	if (( $(df | grep /dev/ploop | awk '{sub (/%/, "", $5); print $5 }') < 80 ))
	then
		proxychains4 python3 /home/plexuser/rd-dl/rd-dl.py $file
		echo
		echo "RESTARTING..."
		echo
	else
		echo
		echo "STORAGE FULL, ORGANISING AND UPLOADING"
		echo
		mkdir ~/uploads/Movies
		cd download
		mv *.mkv ~/uploads/Movies/
		plex-upload
		cd ..
	fi
done

echo
echo "FINISHED DOWNLOADING, MOVING AND UPLOADING"
echo
mkdir ~/uploads/Movies
cd download
mv *.mkv ~/uploads/Movies/
plex-upload

echo
echo "COMPLETE"
echo
