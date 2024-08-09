#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Setup Environment...${NC}"
rm -rf .repo/local_manifest out
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs
/opt/crave/resync.sh

echo -e "${BLUE}Cloning Device Repos...${NC}"
rm -rf device/xiaomi/spes vendor/xiaomi/spes kernel/xiaomi/spes out
git clone -b 14.0-dev https://github.com/Kajal4414/android_device_xiaomi_spes.git device/xiaomi/spes && (cd device/xiaomi/spes && git revert -s 8fb02d5 --no-edit && git log --oneline -5)
git clone -b 14.0 --depth 1 https://github.com/Kajal4414/android_vendor_xiaomi_spes.git vendor/xiaomi/spes
git clone -b 14.0 --depth 1 https://github.com/Kajal4414/android_kernel_xiaomi_spes.git kernel/xiaomi/spes
[ ! -d "hardware/xiaomi" ] && git clone -b 14.0 --depth 1 https://github.com/Kajal4414/android_hardware_xiaomi.git hardware/xiaomi
[ ! -d "hardware/lineage/compat" ] && git clone -b 14.0 --depth 1 https://github.com/Kajal4414/android_hardware_lineage_compat.git hardware/lineage/compat

# echo -e "${BLUE}Patching crDroid Sources...${NC}"
# git config --global user.name "Kajal4414" && git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
# (cd packages/apps/crDroidSettings && git fetch https://github.com/Kajal4414/android_packages_apps_crDroidSettings.git && git cherry-pick 252a9a9 428bf1e || { echo -e "${RED}Cherry-pick failed in crDroidSettings. Aborting.${NC}"; git cherry-pick --abort; }) # Remove GameSpace shortcut and Updater.
# (cd frameworks/base && git fetch https://github.com/Kajal4414/android_frameworks_base.git && git cherry-pick d264ce2 3c2cc04 || { echo -e "${RED}Cherry-pick failed in frameworks/base. Aborting.${NC}"; git cherry-pick --abort; }) # Remove support for GameSpace.
# (cd vendor/lineage && git fetch https://github.com/Kajal4414/android_vendor_crdroid.git && git cherry-pick 0e584f7 || { echo -e "${RED}Cherry-pick failed in vendor/lineage. Aborting.${NC}"; git cherry-pick --abort; }) # Remove some packages: Eleven, ExactCalculator, GameSpace, Jelly, LineageSetupWizard, MatLog, Recorder and Updater.

echo -e "${BLUE}Starting Build...${NC}"
. build/envsetup.sh && breakfast spes user && brunch spes
