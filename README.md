<img width="1404" alt="grey_cloud" src="https://github.com/aurora-codes/bt2ipfs/assets/87864952/df038196-7559-4550-a559-b997720e154d">

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

# magnet2ipfs
This bash script is designed to perform the following tasks:

1. **Get the magnet link from the user**: The script prompts the user to enter a magnet link, which is a type of torrent link that contains the necessary information to download a torrent file.

2. **Create the BT_DATA directory**: The script creates a directory called "BT_DATA" if it doesn't already exist. This directory will be used to store the downloaded torrent contents.

3. **Download the torrent contents using rtorrent**: The script uses the `rtorrent` command-line BitTorrent client to download the contents of the torrent specified by the magnet link and save them to the "BT_DATA" directory.

4. **Upload the contents to an IPFS repo**: After the torrent download is complete, the script uploads the contents of the "BT_DATA" directory to an IPFS (InterPlanetary File System) repository. IPFS is a decentralized file storage and sharing protocol. The script captures the Content Identifier (CID) of the uploaded directory.

5. **Create a new magnet link with the IPFS gateway URL**: The script then creates a new magnet link by appending the IPFS gateway URL (in this case, "https://dweb.link/ipfs/") and the CID to the original magnet link. This new magnet link can be used to access the torrent contents through the IPFS network.

6. **Display the results**: Finally, the script displays the original magnet link, the new magnet link with the IPFS gateway URL, and the IPFS CID.

The purpose of this script is to provide a way to download a torrent, upload the contents to an IPFS repository, and create a new magnet link that can be used to access the torrent contents through the IPFS network. This can be useful for sharing and distributing torrent files in a more decentralized and censorship-resistant manner.
