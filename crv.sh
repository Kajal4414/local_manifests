rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

rm -rf device/xiaomi/spes
rm -rf vendor/xiaomi/spes
rm -rf vendor/xiaomi/camera
rm -rf kernel/xiaomi/sm6225
rm -rf hardware/xiaomi
rm -rf hardware/lineage/compat
rm -rf hardware/google/pixel/kernel_headers

git clone -b 13.0 --depth=1 https://github.com/kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes && rm -rf device/xiaomi/spes/vendorsetup.sh
git clone -b 13.0 --depth=1 https://github.com/muralivijay/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b main --depth=1 https://github.com/muralivijay/kernel_xiaomi_sm6225.git kernel/xiaomi/sm6225
git clone -b lineage-20 --depth=1 https://github.com/LineageOS/android_hardware_xiaomi.git hardware/xiaomi
git clone -b lineage-20 --depth=1 https://github.com/kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat
git clone -b uvite-sm6225 --depth=1 https://gitlab.com/ThankYouMario/proprietary_vendor_xiaomi_camera.git vendor/xiaomi/camera
(cd device/xiaomi/spes && git reset --hard c8ae9ae) # for debug

. build/envsetup.sh
lunch lineage_spes-user
make installclean # make clean
m bacon
