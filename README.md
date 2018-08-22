# videotools

**VideoAIP - What it does**: For a given video file(s), creates an archival package that adheres to the bagit standard with an mp4 access file, technical metadata and checksums.  Once installed, for instructions just type `videoaip` to see usage information.

This script includes an option to sync package/access copies to a remote or local location for easy backup.

Usage: `videoaip [option] [inputfile1] [inputfile2] ... `, help: `videoaip -h`, crop mode: `videoaip -c`,set up configuration for options `videoaip -e`

**Installation:** To install and use these tools in Mac OSX, use the "Terminal" application located in the "Utilities" folder. Use Terminal to install Homebrew (if you don't have it already) and then run the commands:

`brew tap pugetsoundandvision/pugetsoundandvision && brew install cask`

`brew install videotools`

Videotools depends on having textmate installed. It will attempt to install this automatically. If for some reason this doesn't work, you can install via:

`brew cask install textmate`

**VideoAIP Configuration:** 

When you run `videoaip -e` you will see the following configuration screen:

![Video AIP Config](https://github.com/pugetsoundandvision/audiotools/blob/master/supplemental/VideoAIP_Config.png)

* Option One is to enable synchronizing (copying) your preservation package to a second location. Enable this option by entering `Y` for `sync_choice` (between quotation marks) and a path after `destination` (between parenthesis).

* Option Two: VideoAIP will still create a preservation package at the same location as the original file, even if you have enabled synchronization in Option One. If you wish to delete this package once a copy has been synced to the destination specified above, enter `Y` after `remove_aip`.

* Option Three allows you to specify a location for an additional copy of your access files. This enables you to have copies of all access files added to one central folder for more easy management. Enable this by entering `Y` and a path (or ssh path) following `derivative_destination`.

Example:

Original .MKVs are on HardDrive_A. We want the preservation packages synced to HardDrive_B, and copies of the access files saved to HardDrive_C. We also want the preservation packages on HardDrive_A to be deleted once they are synced to HardDrive_B.

![VideoAIP Example](https://github.com/pugetsoundandvision/audiotools/blob/master/supplemental/VideoAIP_Example_GitHub.png)

**Creating Preservation Packages:**

Before you begin:

* Each video file and it's associated logs should be together in one folder. (I.e., FileA.mkv, LogA.log, FrameA.framemd5 should all be in "FileA" folder).

If you only have video files, you can simply run:

`videoaip [drag each .mkv file path here, separated by spaces]`

This will create an archival package for each .mkv that adheres to the bagit standard with an mp4 access file, technical metadata, and checksums.

If you have logs that are associated with your video files, such as .log or .framemd5 files, you can run:

`videoaip -l auto [drag each .mkv file path here, separated by spaces]`

This will create an archival package, as above, but will include any logs found in the same folder as the .mkv.

## Licenses

Scripts

videotools scripts are licensed under a [BSD 3-Clause License](https://github.com/pugetsoundandvision/audiotools/blob/master/LICENSE)

Documentation

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />All associated documentation for the videotools scripts are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a> unless otherwise noted.
