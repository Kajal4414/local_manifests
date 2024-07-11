rm -rf .repo/local_manifest
/opt/crave/resync.sh

rm -rf */xiaomi
rm -rf hardware/lineage/compat
rm -rf hardware/google/pixel/kernel_headers out
rm -rf build/soong

git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_kernel_xiaomi_spes.git kernel/xiaomi/spes
git clone -b lineage-20.0 --depth 1 https://github.com/Kajal4414/android_hardware_xiaomi.git hardware/xiaomi
git clone -b lineage-20.0 --depth 1 https://github.com/Kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat
git clone -b lineage-20.0 --depth 1 https://github.com/Kajal4414/build_soong.git build/soong
git clone https://github.com/TheParasiteProject/vendor_parasite_signatures vendor/parasite/signatures
(cd vendor/parasite/signatures && ./generate.sh)

if ! grep -q "CR_VERSION" "vendor/lineage/config/version.mk"; then
    rm -rf device/xiaomi/spes/sepolicy/private/recovery.te
fi

. build/envsetup.sh
lunch lineage_spes-user
make installclean
m bacon
