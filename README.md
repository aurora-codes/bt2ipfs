# bt2ipfs
This bash script is designed to handle two main functionalities:
1. **Creating a magnet link from a file**:
   - If the script is called with a file path as the argument, it will create a magnet link for that file.
   - It uses the `mktorrent` command to generate a torrent file, and then extracts the necessary information (infohash, display name, and IPFS gateway URL) to construct the magnet link.
   - The script also provides an option to download the IPFS data using the `aria2c` command.
2. **Downloading a file from a magnet link**:
   - If the script is called with a magnet link as the argument, it will extract the necessary information (display name and IPFS gateway URL) from the magnet link and use `aria2c` to download the file.

The script checks for the presence of the required dependencies (`mktorrent`, `ipfs`, and `aria2c`) and exits with an error message if any of them are not installed.
The script also includes a `usage()` function that prints the usage information and exits the script if no arguments are provided.

Overall, this script is designed to simplify the process of creating and using magnet links, as well as downloading files from IPFS using the `aria2c` command.

# magnet2ipfs.sh
The script prompts the user to enter a magnet link.
It creates the BT_DATA directory if it doesn't already exist.
It uses rtorrent to download the torrent contents to the BT_DATA directory.
It uploads the contents of the BT_DATA directory to an IPFS repo and captures the resulting CID (Content Identifier).
It creates a new magnet link by appending the IPFS gateway URL (in this case, https://dweb.link/ipfs/) and the CID to the original magnet link.
It displays the original magnet link, the new magnet link with the IPFS gateway URL, and the IPFS CID.
Note that this script assumes you have rtorrent and ipfs installed and configured on your system. You may need to adjust the script if you're using a different IPFS gateway URL or if you want to handle the CID in a different way.
