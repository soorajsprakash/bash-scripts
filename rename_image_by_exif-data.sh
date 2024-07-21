#!/bin/bash

# Problem statement:
# Image files recovered using foremost would be having random file names.
# This script gets the photo captured date from the image exif data & then renames the image back to the standard format.
# Eg: 385290888.jpg -> IMG_20230708_155443.jpg

echo "Initializing script..."
echo ""


for image in *; do
    if [[ $image =~ \.jpg$ ]]; then
        takenDate=$(exiv2 -K Exif.Photo.DateTimeOriginal -Pv "$image")
        # if takenDate is non null, proceed.
        if [[ -n $takenDate ]]; then
        	# reformat the date to as needed for the file name
            formattedDate=${takenDate//:/}
            formattedDate=${formattedDate// /_}
            fileName=IMG_${formattedDate}.jpg
            echo "$fileName"
            #rename file
            mv -- "$image" "$fileName"
        else
            echo "Failed to get date for the image: $image"
        fi
    fi
done;
