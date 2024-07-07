rm -rf .repo/local_manifest
/opt/crave/resync.sh

rm -rf */xiaomi
rm -rf hardware/lineage/compat
rm -rf hardware/google/pixel/kernel_headers out

git clone -b 13.0 --depth=1 https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b 13.0 --depth=1 https://github.com/Kajal4414/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b 13.0 --depth=1 https://github.com/Kajal4414/android_kernel_xiaomi_spes.git kernel/xiaomi/spes
git clone -b lineage-20 --depth=1 https://github.com/LineageOS/android_hardware_xiaomi.git hardware/xiaomi
git clone -b lineage-20 --depth=1 https://github.com/Kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat

. build/envsetup.sh
lunch lineage_spes-user
make installclean
m bacon
