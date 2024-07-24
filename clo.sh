# ref. https://github.com/parixxshit/local_manifest/blob/lineage/clo.sh
# ref. https://github.com/TheMatheusDev/local_manifests/blob/evox-chris-udc/sync.sh

# Remove
rm -rf hardware/st/nfc

# Device
git clone -b lineage-21.0 https://github.com/Kajal4414/device_xiaomi_spes.git device/xiaomi/spes
git clone -b lineage-21.0 https://github.com/Kajal4414/device_xiaomi_sm6225-common.git device/xiaomi/sm6225-common

# Kernel
git clone -b lineage-21.0 --depth 1 https://github.com/Kajal4414/kernel_xiaomi_sm6225.git kernel/xiaomi/sm6225

# Vendor
git clone -b fourteen --depth 1 https://github.com/PixelExperience-Blobs/vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b fourteen --depth 1 https://github.com/PixelExperience-Blobs/vendor_xiaomi_sm6225-common.git vendor/xiaomi/sm6225-common

# Hardware
git clone -b fourteen https://github.com/PixelExperience/hardware_st_nfc.git hardware/st/nfc
git clone -b fourteen https://github.com/PixelExperience/hardware_xiaomi.git hardware/xiaomi

git clone -b fourteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_gps.git hardware/qcom-caf/bengal/gps
git clone -b fourteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_media.git hardware/qcom-caf/bengal/media
git clone -b fourteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_audio.git hardware/qcom-caf/bengal/audio
git clone -b fourteen https://github.com/PixelExperience/hardware_qcom-caf_bengal_display.git hardware/qcom-caf/bengal/display

# Camera (MIUI)
git clone -b uvite-sm6225 --depth 1 https://gitlab.com/ThankYouMario/proprietary_vendor_xiaomi_camera.git vendor/xiaomi/camera

# Device (QCOM)
git clone -b fourteen https://github.com/PixelExperience-Devices/device_qcom_common.git device/qcom/common # Adapt FCM `lineage`
git clone -b fourteen https://github.com/PixelExperience-Devices/device_qcom_qssi.git device/qcom/qssi
git clone -b fourteen https://github.com/PixelExperience-Devices/device_qcom_wlan.git device/qcom/wlan
git clone -b fourteen https://github.com/PixelExperience-Devices/device_qcom_common-sepolicy.git device/qcom/common-sepolicy # Adapt Sepolicy `lineage`
git clone -b fourteen https://github.com/PixelExperience-Devices/device_qcom_vendor-common.git device/qcom/vendor-common

# Vendor (QCOM)
git clone -b fourteen --depth 1 https://github.com/PixelExperience-Blobs/vendor_qcom_common.git vendor/qcom/common
git clone -b thirteen --depth 1 https://github.com/PixelExperience/vendor_qcom_opensource_audio.git vendor/qcom/opensource/audio
git clone -b fourteen --depth 1 https://github.com/PixelExperience/vendor_qcom_opensource_core-utils.git vendor/qcom/opensource/core-utils
git clone -b thirteen --depth 1 https://github.com/PixelExperience/vendor_qcom_opensource_commonsys_dpm.git vendor/qcom/opensource/commonsys/dpm
git clone -b thirteen --depth 1 https://github.com/PixelExperience/vendor_qcom_opensource_commonsys-intf_bluetooth.git vendor/qcom/opensource/commonsys-intf/bluetooth

# Patch frameworks/base
pushd frameworks/base
git fetch https://github.com/parixxshit/android_frameworks_base.git
git cherry-pick 419fa2b^..ff5239d # CLO Framework Boost
popd

# Patch packages/resources/devicesettings
pushd packages/resources/devicesettings
git fetch https://github.com/Deepak5310/android_packages_resources_devicesettings.git
git cherry-pick ac8b243^..2a3307e # Add Custom Strings
popd

# Patch vendor/lineage
pushd vendor/lineage
git fetch https://github.com/parixxshit/vendor_derp.git
git cherry-pick 82a4247 4edc812 # Allow QCOM FM HAL, Split 4.19 SoC family
popd

# Patch vendor/qcom/opensource/interfaces
pushd qcom/opensource/interfaces
git fetch https://github.com/PixelExperience/vendor_qcom_opensource_interfaces.git
git cherry-pick 0a1e849 # Introduce QTI FM HAL
popd

# Patch vendor/qcom/opensource/fm-commonsys
pushd vendor/qcom/opensource/fm-commonsys
git fetch https://github.com/PixelExperience/vendor_qcom_opensource_fm-commonsys.git
git cherry-pick 74f4211 # Define soong namespace
popd

# Build
. build/envsetup.sh
lunch lineage_spes-user && m bacon
