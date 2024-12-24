#!/bin/bash

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
END="\033[0m"

VENDOR_BRANCH="15.0"
KERNEL_BRANCH="NaughtySilver"
HARDWARE_BRANCH="15.0"
DEBUG_BRANCH="lineage-22"
LEICA_CAMERA_BRANCH="leica-5.0"

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${YELLOW}• $1 already exists. Skipping cloning...${END}"
        return 1
    fi
    return 0
}

echo -e "${YELLOW}Applying patches and cloning device source...${END}"

echo -e "${GREEN}• Removing conflicting Pixel headers from hardware/google/pixel/kernel_headers/Android.bp...${END}"
rm -rf hardware/google/pixel/kernel_headers/Android.bp

if [ -f device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te ]; then
    echo -e "${GREEN}Switching back to legacy imsrcsd sepolicy...${END}"
    rm -rf device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/imsservice.te
    cp device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/legacy-ims/hal_rcsservice.te device/qcom/sepolicy_vndr/legacy-um/qva/vendor/bengal/ims/hal_rcsservice.te
else
    echo -e "${YELLOW}• Please check your ROM source; the file for legacy imsrcsd sepolicy does not exist. Skipping this step...${END}"
fi

if check_dir vendor/xiaomi/spes; then
    echo -e "${GREEN}Cloning vendor sources from EvolutionX-spes (branch: ${YELLOW}$VENDOR_BRANCH${GREEN})...${END}"
    git clone https://github.com/EvolutionX-spes/vendor_xiaomi_spes -b $VENDOR_BRANCH vendor/xiaomi/spes
fi

if check_dir kernel/xiaomi/sm6225; then
    echo -e "${GREEN}Cloning kernel sources from EvolutionX-spes (branch: ${YELLOW}$KERNEL_BRANCH${GREEN})...${END}"
    git clone https://github.com/EvolutionX-spes/kernel_xiaomi_sm6225 --depth=1 -b $KERNEL_BRANCH kernel/xiaomi/sm6225
fi

if check_dir hardware/xiaomi; then
    echo -e "${GREEN}Cloning hardware sources from spes-development (branch: ${YELLOW}$HARDWARE_BRANCH${GREEN})...${END}"
    git clone https://github.com/spes-development/hardware_xiaomi -b $HARDWARE_BRANCH hardware/xiaomi
fi

if check_dir hardware/samsung-ext/interfaces; then
    echo -e "${GREEN}Cloning Debugging-Tools from spes-development (branch: ${YELLOW}$DEBUG_BRANCH${GREEN})...${END}"
    git clone https://github.com/spes-development/hardware_samsung-extra_interfaces -b $DEBUG_BRANCH hardware/samsung-ext/interfaces
fi

if check_dir vendor/xiaomi/miuicamera; then
    echo -e "${GREEN}Cloning Leica Camera vendor sources from ItzDFPlayer (branch: ${YELLOW}$LEICA_CAMERA_BRANCH${GREEN})...${END}"
    git clone https://gitlab.com/ItzDFPlayer/vendor_xiaomi_miuicamera -b $LEICA_CAMERA_BRANCH vendor/xiaomi/miuicamera
fi

echo -e "${YELLOW}All patches have been successfully applied; your device sources are now ready!${END}"
