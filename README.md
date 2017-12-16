# videotools

To install and use these tools in Mac OSX, use the "Terminal" application located in the "Utilities" folder. Use Terminal to install Homebrew (if you don't have it already) and then run the commands:

`brew tap pugetsoundandvision/pugetsoundandvision && brew install cask`

`brew install videotools`

Videotools depends on having textmate installed. It will attempt to install this automatically. If for some reason this doesn't work, you can install via:

`brew cask install textmate`

**VideoAIP**: For a given video file, creates an archival package that adheres to the bagit standard with an mp4 access file, technical metadata and checksums.  Once installed, for instructions just type `videoaip` to see usage information.

This script includes an option to sync package/access copies to a remote or local location for easy backup.

Usage: `videoaip [inputfile]`, help: `videoaip -h`, crop mode: `videoaip -c`,set up configuration for options `videoaip -e`

**VideoAIP Configuration:**

When you run `videoaip -e` you will see a configuration screen like this:
![AudioAIP Config](https://github.com/pugetsoundandvision/audiotools/blob/master/supplemental/audioaipconfig.png)

To set your options, simply type them between the respective quotation marks, save the file and quit.

The options require file paths.  An easy way to find the file path for a file or folder is just to drag it into the terminal window and then copy the results. It should looks something like `/Users/username/Desktop/myfolder`

* The first option is to enable synchronizing your preservation package to a second location.  Enable this by entering "Y" and a path (or ssh path) for a destination.  Something like: `sync_choice="Y"` and `destination="path to your folder here"`
* The second option can be used in conjunction with the first. If you wish to remove the locally generated AIP after syncing it to its destination, set this to `Y`.
* The third option allows you to set a location to make an extra copy of your access files (in addition to the ones contained in your package).  This enables you to have copies of all access files added to one central folder for more easy management. Enable this by entering "Y" and a path (or ssh path) for a destination.  Something like: `derivative_choice="Y"` and `destination="path to your folder here"`

## Licenses

Scripts

videotools scripts are licensed under a [BSD 3-Clause License](https://github.com/pugetsoundandvision/audiotools/blob/master/LICENSE)

Documentation

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br />All associated documentation for the videotools scripts are licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a> unless otherwise noted.
