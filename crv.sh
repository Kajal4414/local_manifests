rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

rm -rf */xiaomi
rm -rf hardware/lineage/compat
rm -rf hardware/google/pixel/kernel_headers out

git clone -b 13.0 https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b 13.0-new --depth 1 https://github.com/Kajal4414/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_kernel_xiaomi_spes.git kernel/xiaomi/spes
git clone -b lineage-20.0 --depth 1 https://github.com/Kajal4414/android_hardware_xiaomi.git hardware/xiaomi
git clone -b lineage-20.0 --depth 1 https://github.com/Kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat

git config --global user.name "Kajal4414" && git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
(cd device/xiaomi/spes && git pull && git revert -s acc89bf --no-edit) # spes: props: Sync properties with miui

. build/envsetup.sh
lunch lineage_spes-user
make installclean
m bacon
