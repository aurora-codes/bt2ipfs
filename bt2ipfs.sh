#!/bin/bash

usage() {
    echo "Usage: $0 [<file_to_share>|<magnet_link>]"
    exit 1
}

if [ "$#" -lt 1 ]; then
    usage
fi

if [ -f "$1" ]; then
    # Create a magnet link from a file
    SHARE_FILE="$1"
    IPFS_GATEWAY="${2:-https://dweb.link/ipfs}"
    CUSTOM_TRACKERS="${3:-udp://tracker.opentrackr.org:1337/announce}"

    if [ ! -f "$SHARE_FILE" ]; then
        echo "Error: $SHARE_FILE does not exist."
        exit 1
    fi

    if ! command -v mktorrent >/dev/null 2>&1; then
        echo "Error: mktorrent is not installed."
        exit 1
    fi

    if ! command -v ipfs >/dev/null 2>&1; then
        echo "Error: ipfs is not installed."
        exit 1
    fi

    if ! command -v aria2c >/dev/null 2>&1; then
        echo "Error: aria2c is not installed."
        exit 1
    fi

    TORRENT_FILE="${SHARE_FILE%.*}.torrent"
    mktorrent -a "$CUSTOM_TRACKERS" -o "$TORRENT_FILE" "$SHARE_FILE"

    IPFS_CID=$(ipfs add -q "$SHARE_FILE")
    IPFS_GATEWAY_URL="$IPFS_GATEWAY/$IPFS_CID"

    DISPLAY_NAME=$(basename "$SHARE_FILE")
    MAGNET_LINK="magnet:?xt=urn:btih:$(sha1sum "$TORRENT_FILE" | cut -d' ' -f1)&dn=$DISPLAY_NAME&ws=$IPFS_GATEWAY_URL&tr=$CUSTOM_TRACKERS"

    echo "Magnet link: $MAGNET_LINK"

    read -p "Do you want to download the IPFS data using aria2c? (yes/no) " download_ipfs

    if [ "$download_ipfs" == "yes" ]; then
        aria2c -o "$DISPLAY_NAME" "$IPFS_GATEWAY_URL"
        echo "IPFS data downloaded to $DISPLAY_NAME"
    else
        echo "Skipping IPFS data download."
    fi
else
    # Download a file from a magnet link
    MAGNET_LINK="$1"
    DISPLAY_NAME=$(echo "$MAGNET_LINK" | grep -oP '&dn=\K[^&]+')
    IPFS_GATEWAY_URL=$(echo "$MAGNET_LINK" | grep -oP '&ws=\K[^&]+')

    if ! command -v aria2c >/dev/null 2>&1; then
        echo "Error: aria2c is not installed."
        exit 1
    fi

    aria2c -o "$DISPLAY_NAME" "$IPFS_GATEWAY_URL"
    echo "File downloaded to $DISPLAY_NAME"
fi

