#!/bin/bash
# Cleanup script to avoid build conflicts
check_dir() {
    [ ! -d "$1" ]
}
LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE="device/lineage/sepolicy/common/vendor/device.te"
LEICA_CAMERA_BRANCH="leica-5.0"
DEVICE_MK_PATH="device/xiaomi/spes/device.mk"
LEICA_CAMERA_BLOCK=$(cat <<'EOF'

# Include Leica//Miui Camera
$(call inherit-product, vendor/xiaomi/miuicamera/config.mk)
$(call soong_config_set,camera,package_name,com.android.camera)
EOF
)

# Remove duplicate SELinux declaration
if [ -f "$LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE" ]; then
    echo "Deleting $LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE to avoid build conflict..."
    rm -f "$LINEAGE_SEPOLICY_COMMON_VENDOR_DEVICE"
fi

# Clone vendor/xiaomi/miuicamera during lunch
if check_dir vendor/xiaomi/miuicamera; then
    echo -e "Cloning Leica Camera vendor sources from ItzDFPlayer (branch: $LEICA_CAMERA_BRANCH)"
    git clone https://gitlab.com/ItzDFPlayer/vendor_xiaomi_miuicamera -b $LEICA_CAMERA_BRANCH vendor/xiaomi/miuicamera
fi

# Only append if not already present
if ! grep -q "vendor/xiaomi/miuicamera/config.mk" "$DEVICE_MK_PATH"; then
    echo "Appending Leica/Miui camera config to device.mk..."
    printf "%s\n" "$LEICA_CAMERA_BLOCK" >> "$DEVICE_MK_PATH"
else
    echo "Leica/Miui camera config already present in device.mk. Skipping append."
fi
