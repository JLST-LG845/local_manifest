#!/bin/bash

# Modify ROM prefix
modify_rom_prefix() {
  echo "Performing renaming for ${device}..."
  cd device/lge/${device}
  find . -not -path "*/.*" -name "*.mk" -type f -exec sed -i "s/aosp/${rom}/g" {} +
  mv aosp_${device}.mk ${rom}_${device}.mk
  echo "Successfully renamed prefix to ${rom}"

  cd ./../../../
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
echo "4. ALL"

read -p "Enter your choice (1-4): " device_choice

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
  4)
    device_arr=("judyln" "judyp" "judypn")
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac

echo "Rom Bringup"
read -p "New rom prefix: " rom

if [ "${device_choice}" == 4 ]; then
  for ((i = 0; i < ${#device_arr[@]}; i++)); do
    device="${device_arr[$i]}"
    modify_rom_prefix
  done
else
  modify_rom_prefix
fi
init_ksu

echo "Done!"
