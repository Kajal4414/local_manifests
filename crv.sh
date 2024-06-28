rm -rf .repo/local_manifest
# Clone local_manifests repository
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
/opt/crave/resync.sh

# trees
rm -rf */xiaomi
git clone --depth=1 https://github.com/cheldump/android_device_xiaomi_msm8953-common device/xiaomi/msm8953-common
git clone --depth=1 https://github.com/cheldump/proprietary_vendor_xiaomi_msm8953-common vendor/xiaomi/msm8953-common
git clone --depth=1 https://github.com/cheldump/android_device_xiaomi_tissot device/xiaomi/tissot
git clone --depth=1 https://github.com/cheldump/proprietary_vendor_xiaomi_tissot vendor/xiaomi/tissot
git clone --depth=1 https://github.com/xiaomi-msm8953-devs/android_kernel_xiaomi_msm8953 kernel/xiaomi/msm8953
git clone --depth=1 https://github.com/LineageOS/android_hardware_xiaomi hardware/xiaomi
git clone --depth=1 https://github.com/rktdnt/p3 vendor/lineage-priv/keys

#beelding
. build/envsetup.sh
riseup tissot userdebug
rise b
