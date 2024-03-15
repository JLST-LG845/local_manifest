![banner](https://raw.githubusercontent.com/JLST-LG845/local_manifests/T/manifest_banner.png)

# LGE SDM845 Tree Manifest
This is the manifest to clone the judy family device trees.

## How to clone trees
### Prerequisites
* Knowledge on how to initialize ROM source.
* Familiarity with using [Git](https://www.atlassian.com/git/tutorials/atlassian-git-cheatsheet).
* [Setup](https://github.com/akhilnarang/scripts) build environment.
    * For Arch users, just install [lineageos-devel](https://aur.archlinux.org/packages/lineageos-devel) and you should be good to go.

## Instructions

### Before sync
* Clone this repository inside the `.repo` folder.
    * Since `local_manifests` folder is empty, the manifest stuff will be inside `.repo/local_manifests`.
    ```bash
    cd .repo
    git clone https://github.com/JLST-LG845/local_manifests.git -b T
    ```
* Navigate to the `local_manifests` directory.
    ```bash
    cd local_manifests
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
* Copy `rom.sh` to the root folder of your ROM source to change the rom prefix and clone the KernelSU submodule inside kernel source.
* Run the script
    * When prompted, specify your device codename and the ROM name found inside `vendor` folder.
        * ie. `vendor/lineage` or `vendor/evolution` etc.
    ```bash
    # Make sure it is exectuable
    chmod +x rom.sh
    # Run the script
    ./rom.sh
    ```
* Apply [this](https://github.com/Evolution-X/frameworks_base/commit/cf904d5811d36cd7993de66486a92994f8f81233) and [this](https://github.com/Evolution-X/frameworks_base/commit/382887e4864285918d4bc30195c04999b60bf459) commits to fix some errors for our devices.
    * This includes the `internal error` message and the battery light being stuck at 100% for G7 users.
* If your test build encounters random reboots, reference and apply [this commit](https://github.com/juleast/android_build_soong/commit/69b1f28e3f935e962b7a762b709d954e9179c5da) inside `build/soong`.
    * It is best if you add the remote from JLST-LG845 and cherry pick it.
        ```bash
        # From the root of your ROM source
        cd build/soong
        # Fetch remote and cherry pick
        git fetch https://github.com/juleast/android_build_soong.git
        git cherry-pick 69b1f28
        ```
## Credits
* Thanks to [@EmanuelCN](https://github.com/EmanuelCN/) for original device trees, kernel, and vendor.
* `rom.sh` script based on the original file by Emanuel available in his [Telegram channel](https://t.me/emhub).


