#!/bin/bash
hals=("hardware/qcom-caf/sdm845/audio" "hardware/qcom-caf/sdm845/display" "hardware/qcom-caf/sdm845/media")

nuke_hal() {
  echo -e "--------------------------------------"

  echo "Try to remove SDM845 CAF HALs from default manifests..."
  cd ../manifests

  for hal in ${hals[@]}; do
    IFS='/' read -r -a name <<< "$(echo $hal)"
    IFS=' ' read -r -a line <<< "$(grep -nir $hal)"
    IFS=':' read -r -a loc_info <<< $line
    sed -i "${loc_info[1]}s/.*/  <!-- SDM845 yeet ${name[-1]} -->/" ${loc_info[0]}
  done

  cd ../local_manifests
}

echo -e "### Mini Manifest Editor by Juleast###"
echo -e "--------------------------------------"
echo "Select the device:"
echo "1. judyln"
echo "2. judypn"
echo "3. judyp"
echo "4. ALL"
read -p "Choose your device (1-4): " device_choice

case "${device_choice}" in
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
    device=("judyln" "judypn" "judyp")
    ;;
  *)
    echo "Invalid choice!"
    echo "Exiting..."
    exit 1
    ;;
esac
newline="  <project path=\"device/lge/$device\" name=\"android_device_lge_$device\" remote=\"jlst\" />"
echo -e "\nEditing XML files..."

readarray -t file_lines < <(cat lge_sdm845.xml)
echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" | tee lge_sdm845.xml &> /dev/null
for ((i = 1; i < ${#file_lines[@]}-2; i++)); do
  echo "${file_lines[$i]}" | tee -a lge_sdm845.xml &> /dev/null
done

if [ "$device_choice" == 4 ]; then
  for codename in "${device[@]}"; do
    echo -e "  <project path=\"device/lge/$codename\" name=\"android_device_lge_$codename\" remote=\"jlst\" />" | tee -a lge_sdm845.xml &> /dev/null
  done
else
  echo -e "$newline" | tee -a lge_sdm845.xml &> /dev/null
fi

echo "</manifest>" | tee -a lge_sdm845.xml  &> /dev/null
echo "Finished!"

#nuke_hal

echo "Done!"
echo "Note: If you are not sure of the changes, double check the files."


