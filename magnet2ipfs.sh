#!/bin/bash

# Get the magnet link from the user
read -p "Enter the magnet link: " magnet_link

# Create the BT_DATA directory if it doesn't exist
mkdir -p BT_DATA

# Use rtorrent to download the torrent contents to the BT_DATA directory
rtorrent -o directory=BT_DATA $magnet_link

# Upload the contents of the BT_DATA directory to an IPFS repo
ipfs add -r BT_DATA | tail -n 1 | awk '{print $2}' > cid.txt
cid=$(cat cid.txt)

# Create the new magnet link with the IPFS gateway URL
ipfs_gateway_url="https://dweb.link/ipfs/$cid"
new_magnet_link="$magnet_link&ws=$ipfs_gateway_url"

echo "Original magnet link: $magnet_link"
echo "New magnet link with IPFS gateway: $new_magnet_link"
echo "IPFS CID: $cid"
