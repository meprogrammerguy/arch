#!/bin/bash
cd /home/jsmith/decrypt/literotica
ls -d -1 */ > dir.txt
IFS=$'\n'
read -a array_example -d EOF < dir.txt
for value in "${array_example[@]}"; do
	cd "$value"
	echo "cleaning up images in $value"
	sed -i 's/<img[^>]*>//g' *.html
	cd ..
done

