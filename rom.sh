#!/bin/bash

# Modify ROM prefix
modify_rom_prefix() {
    echo "Rom Bringup"
    read -p "New rom prefix: " rom

    echo "Performing renaming..."
    cd device/lge/${device}
    find . -not -path "*/.*" -name "*.mk" -type f -exec sed -i "s/aosp/${rom}/g" {} +
    mv aosp_${device}.mk ${rom}_${device}.mk
    echo "Successfully renamed prefix to ${rom}"

    cd ./../../../
    init_ksu
}

# Clone KernelSU submodule
init_ksu() {
    cd kernel/lge/sdm845
    git submodule init
    git submodule update
    cd ./../../../
}

# Main script

echo "Select the device:"
echo "1. judyln"
echo "2. judypn"
echo "3. judyp"

read -p "Enter your choice (1-3): " device_choice

case ${device_choice} in
    1)
        device="judyln"
        ;;
    2)
        device="judypn"
        ;;
    3)
        device="judyp"
        ;;
    *)
        echo "Invalid choice. Exiting..."
        exit 1
        ;;
esac

modify_rom_prefix

echo "Done!"