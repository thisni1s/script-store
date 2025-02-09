#!/bin/bash

# Directory containing .pcap files
directory="/var/spool/corsaro"
bucket=$(cat /root/config/bucket.txt)
ip=$(cat /root/config/ip4.txt | sed -r 's/\./-/g' )

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory not found: $directory"
    exit 1
fi

cd $directory
for file in *.done; do
    if mc cp "${file%.*}" "tupload/$bucket/$ip/"; then
        rm "$file" "${file%.*}"
    fi
done
