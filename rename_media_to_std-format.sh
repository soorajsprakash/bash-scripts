#!/bin/bash

# Prolem statement:
# When we use various GCAM configs, the image/video file name could be of the config maintainers choice. 
# This script renames the media from known gcam manitainers to the common format, which is "<IMG/VID>_<date>_<time>.<media-type>"
# Eg: IMG_20230725_215200.jpg
# Eg: SGCAM_7ssjl.config.xml20230708_155443.jpg -> IMG_20230708_155443.jpg

echo "Initializing script..."
for file in *; do
	# for SGCAM
	if [[ $file =~ SGCAM ]];
	then
		updatedName="${file/__SGCAM*.xml/}"	# replace whole SGCAM suffs
		if [[ $updatedName == *.mp4 || $updatedName == *.mkv ]]; then
			updatedName="VID_${updatedName/3L/}"	# add VID_ & remove 3L
		else
			updatedName=IMG_${updatedName}		# add IMG_
		fi
		echo "$updatedName"
		mv -- "$file" "$updatedName"		# renamae file

	fi

	# for LMC 8.4
	if [[ $file =~ lmc ]]; then
		updatedName="${file/_lmc_8.4/}"
		if [[ $updatedName == *".jpg" && $updatedName != "IMG_"* ]]; then
			updatedName=IMG_"$updatedName"
		fi
		if [[ $updatedName == *".mp4" && $updatedName != "VID_"* ]]; then
			if [[ $updatedName == "IMG"* ]]; then
				updatedName="${updatedName/IMG_/VID_}"
			else
				updatedName=VID_"$updatedName"
			fi	
		fi	
		echo "$updatedName"
		mv -- "$file" "$updatedName"

	fi

	# for MaxDetails
	if [[ $file =~ MaxDetail ]]; then
		if [[ $file == *"VID"* ]]; then
			updatedName="${file/🤳Max*VID/VID}"
			echo "$updatedName"
		else
			updatedName="${file/🤳*\ /IMG_}"
			echo "$updatedName"
		fi
		mv -- "$file" "$updatedName"
	fi

	# for 5 LENSES
	if [[ $file =~ HUGO ]]; then
		updatedName=${file/_📸*./.}
		if [[ $updatedName =~ mp4 ]]; then
			updatedName=VID${updatedName/IMG/}
		fi
		echo "$updatedName"
		mv -- "$file" "$updatedName"

	fi

	# for Pixel
	if [[ $file =~ PXL ]]; then
		if [[ $file =~ jpg ]]; then
			updatedName=${file/PXL/IMG}
			echo "$updatedName"
		elif [[ $file =~ mp4 ]]; then
			updatedName=${file/PXL/VID}
			echo "$updatedName"
		fi
		mv -- "$file" "$updatedName"
	fi

	# for 𝐇𝐄𝐆𝐄𝐌𝐎𝐍𝐘💫
	if [[ $file =~ 𝐇𝐄𝐆𝐄𝐌𝐎𝐍𝐘 ]]; then
		updatedName=${file/_𝐇*./.}
		if [[ $file =~ mp4 ]]; then
			updatedName=VID_${updatedName:4}
		else
			updatedName=IMG_${updatedName:4}
		fi
		echo $updatedName
		mv -- "$file" "$updatedName"
	fi

	# for IronHrt
	if [[ $file =~ IronHrt ]]; then
		updatedName=${file/IronHrt_/}
		echo $updatedName
		mv -- "$file" "$updatedName"
	fi

	# for old Lmc 8.4
	if [[ $file =~ "_8.4.300" ]]; then
		updatedName=${file/_8.4.300/}
		echo "$updatedName"
		mv -- "$file" "$updatedName"
	fi	
done;

