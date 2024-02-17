![banner](https://raw.githubusercontent.com/JLST-LG845/local_manifests/R/manifest_banner.png)

# LGE SDM845 Tree Manifest
This is the manifest to clone the judy family device trees.

## How to clone trees
### Prerequisites
* Knowledge on how to initialize ROM source.
* Familiarity with using [Git](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet).
* [Setup](https://github.com/akhilnarang/scripts) build environment.
    * For Arch users, just install [lineageOS-devel](https://aur.archlinux.org/packages/lineageos-devel) and you should be good to go.

## Instructions

### Before sync
* Clone this repository inside the `.repo` folder.
    * Since `local_manifests` folder is empty, the manifest stuff will be inside `.repo/local_manifests`.
    ```bash
    cd .repo
    git clone https://github.com/JLST-LG835/local_manifests.git -b R
    ```
* Then run the setup script to add the line to clone your desired device.
    * When prompted, select the number that corresponds to your device codename.
    * After this, the script will automatically remove the line that clones the default display HAL in the default XML file inside the manifests folder.
    ```bash
    # Make sure the script is executable
    chmod +x setup.sh
    # Run the script
    ./setup.sh
    ```
* If the script ever failed to remove the line for default display HAL, reference [this commit](https://github.com/JLST-LG845/local_manifests/commit/d51644737bda5fe6af22101c875edc5805383430).

### After sync
* Copy `rom.sh` to the root folder of your ROM source to change the rom prefix.
* Run the script
    * When prompted, specify your device codename and the ROM name found inside `vendor` folder.
        * ie. `vendor/lineage`
    ```bash
    # Make sure it is exectuable
    chmod +x rom.sh
    ./rom.sh
    ```


