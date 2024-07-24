export AOSPA_BUILDTYPE=BETA

rm -rf .repo/local_manifest out && repo init -u https://github.com/AOSPA/manifest -b uvite && /opt/crave/resync.sh

git clone -b uvite https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b uvite https://github.com/Kajal4414/android_device_xiaomi_sm6225-common.git device/xiaomi/sm6225-common

source build/envsetup.sh && lunch aospa_spes-user && m clobber -j$(nproc) && m otapackage -j$(nproc)
