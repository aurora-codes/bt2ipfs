#!/bin/bash

# Check if required tools are installed
check_tools() {
    local tools=("rtorrent" "ipfs")
    for tool in "${tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            echo "Error: $tool is not installed. Please install it and try again."
            exit 1
        fi
    done
}

# Get the magnet link from the user
read -p "Enter the magnet link: " magnet_link

# Check if required tools are installed
check_tools

# Create the BT_DATA directory if it doesn't exist
mkdir -p BT_DATA || {
    echo "Error: Failed to create the BT_DATA directory."
    exit 1
}

# Use rtorrent to download the torrent contents to the BT_DATA directory
rtorrent -o directory=BT_DATA "$magnet_link" || {
    echo "Error: Failed to download the torrent contents."
    exit 1
}

# Upload the contents of the BT_DATA directory to an IPFS repo
ipfs_output=$(ipfs add -r BT_DATA 2>&1) || {
    echo "Error: Failed to upload the contents to IPFS."
    exit 1
}
cid=$(echo "$ipfs_output" | tail -n 1 | awk '{print $2}')

# Create the new magnet link with the IPFS gateway URL
ipfs_gateway_url="https://dweb.link/ipfs/$cid"
new_magnet_link="$magnet_link&ws=$ipfs_gateway_link"

echo "Original magnet link: $magnet_link"
echo "New magnet link with IPFS gateway: $new_magnet_link"
echo "IPFS CID: $cid"
