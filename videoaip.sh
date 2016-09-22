#!/bin/bash

config_file="$HOME/.$(basename "${0}").conf"
touch $config_file
source $config_file

usage(){
    echo "usage"
    
}

_error_exit(){
    echo -e "\033[1;32m"$1"\033[0m" 1>&2
    exit 1
}

file_input=$1

OPTIND=1
while getopts "hep:" opt ; do
    case "${opt}" in
        h) usage ;;
        p) runtype="photo" file_input="$2";;
        e) runtype="edit";;
        *)
    esac
done

if [ "${*}" = "" ] ; then
    usage
fi

if [[ "${runtype}" = "edit" ]] ; then
    echo "#INSERT YOUR VALUES BETWEEN THE QUOTES AND SAVE FILE" > "${config_file}"
    echo "#To control file sync change 'sync_choice' to either Y or N" >> "${config_file}"
    echo "#Then change destination to the file path of the desired destination" >> "${config_file}"
    echo "sync_choice=\"$sync_choice\"" >> "${config_file}"
    echo "destination=\"$destination\"" >> "${config_file}"
    echo "" >> "${config_file}"
    echo "#If you want to sync an additional access file to an extra location choose Y or N and enter file path of destination below" >> "${config_file}"
    echo "derivative_choice=\"$derivative_choice\"" >> "${config_file}"
    echo "derivative_destination=\"$derivative_destination\"" >> "${config_file}"
    mate "$config_file"
    exit
fi

#Check if input exists

if [ ! -f "$file_input" ]; then
    _error_exit "Input could not be found. Please enter valid input."
fi


#create directory structure
orig_base=$(basename "$file_input")
deriv_name="${file_input%.*}.mov"
mp4_name="${file_input%.*}.mp4"
mkdir "$(dirname "$file_input")/${orig_base%.*}" || _error_exit "Directory already exists. Exiting..."
mkdir "$(dirname "$file_input")/${orig_base%.*}/metadata"
mkdir "$(dirname "$file_input")/${orig_base%.*}/logs"
mkdir "$(dirname "$file_input")/${orig_base%.*}/logs/fileMeta"
mkdir "$(dirname "$file_input")/${orig_base%.*}/objects"
mkdir "$(dirname "$file_input")/${orig_base%.*}/objects/access"

if [[ "${runtype}" = "photo" ]] ; then
#take pictures
Echo "How many pictures will you take?"
read pic_num
i=1
while [ "$i" -le "$pic_num" ]; do

Echo "Press enter to activate camera, then press escape to take picture"
read null_response
ffplay -window_title "Press Escape When Ready To Take Picture" -f avfoundation -i "default"
imagesnap - | ffmpeg -i - -compression_algo raw -pix_fmt rgb24 "$(dirname "$file_input")/${orig_base%.*}/objects/${orig_base%.*}_0"$i".tiff" && ffplay -window_title "Press Escape When Ready To Continue" "$(dirname "$file_input")/${orig_base%.*}/objects/${orig_base%.*}_0"$i".tiff"
echo "Enter q to quit, r to retake or enter continue"
read followquery

if [[ "${followquery}" == "q" ]] ; then
    exit
fi

if [[ "${followquery}" == "r" ]] ; then
    rm $(dirname $file_input)/${orig_base%.*}/objects/${orig_base%.*}_0"$i".tiff
else
i=$(($i + 1))
fi
done

fi



#create metadata and derivative files
mediainfo --output=PBCore2 "$file_input" > "$(dirname "$file_input")/${orig_base%.*}/logs/fileMeta/${orig_base%.*}_pbcoreinstantiation.xml"
ffmpeg -i "$file_input" -c:v prores "$deriv_name" "$mp4_name" 

#sync access mp4 if selected
if [[ "${derivative_choice}" = "Y" ]] ; then
    echo -e "\033[1;32mSyncing access copy to  "$destination" \033[0m"
    rsync -Pa "$mp4_name" "$derivative_destination"
fi

#create checksum
md5deep -b "$file_input" > "$(dirname "$file_input")/${orig_base%.*}/metadata/${orig_base%.*}.md5"

#move files
mv "$file_input" "$(dirname "$file_input")/${orig_base%.*}/objects"
mv "$deriv_name" "$(dirname "$file_input")/${orig_base%.*}/objects"
mv "$mp4_name" "$(dirname "$file_input")/${orig_base%.*}/objects/access"

package="$(dirname "$file_input")/${orig_base%.*}"

#Run Bagit
bagit baginplace "$package"

#sync AIP to destination
if [[ "${sync_choice}" = "Y" ]] ; then
    echo -e "\033[1;32mSyncing Files to  "$destination" \033[0m"
    rsync -Pa "$package" "$destination"

# check if destination is local. If local verify with bagit. 
    remote_test=$(echo "$destination" | grep "@")
    if [ -n "$remote_test" ] ; then
        echo -e "\033[1;32mAs Destination is not local audioaip is skipping bagit verification\033[0m"
        exit
    fi
    
    echo -e "\033[1;32mVerifying checksums of package \033[0m"
    bagit verifypayloadmanifests --excludehiddenfiles "$destination"/"${orig_base%.*}"
fi



