rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

rm -rf */xiaomi
rm -rf hardware/lineage/compat
rm -rf hardware/google/pixel/kernel_headers out

git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_kernel_xiaomi_spes.git kernel/xiaomi/spes
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_hardware_xiaomi.git hardware/xiaomi
git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat

git config --global user.name "Kajal4414" && git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
(cd packages/apps/crDroidSettings && git fetch https://github.com/Kajal4414/android_packages_apps_crDroidSettings.git && git cherry-pick 252a9a9 428bf1e) # remove game space shortcut, updater
(cd frameworks/base && git fetch https://github.com/Kajal4414/android_frameworks_base.git && git cherry-pick d264ce2) # remove support for game space
(cd vendor/lineage && git fetch https://github.com/Kajal4414/android_vendor_crdroid.git && git cherry-pick 0e584f7) # remove some packages

# (cd device/xiaomi/spes && git pull && git cherry-pick eb06bec^..52a728e) # skiaglthreaded to reorganize files
# (cd vendor/xiaomi/spes && git pull && git reset --hard HEAD~1)
# (cd hardware/qcom-caf/sm8250/display && git fetch https://github.com/LineageOS/android_hardware_qcom_display.git lineage-21.0-caf-sm8250 && git cherry-pick 21d3641)

. build/envsetup.sh
lunch lineage_spes-user
make installclean
m bacon
