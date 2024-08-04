#!/bin/bash

BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}Setup Environment...${NC}"
rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

echo -e "${BLUE}Cloning Device Repos...${NC}"
rm -rf */xiaomi hardware/google/pixel/kernel_headers hardware/lineage/compat out
for repo in device/xiaomi/spes vendor/xiaomi/spes kernel/xiaomi/spes hardware/xiaomi hardware/lineage/compat; do
    git clone -b 13.0 --depth 1 https://github.com/Kajal4414/android_${repo//\//_}.git $repo
done

echo -e "${BLUE}Patching crDroid Sources...${NC}"
git config --global user.name "Kajal4414" && git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
declare -A patches=(
    ["packages/apps/crDroidSettings"]="252a9a9 428bf1e"
    ["frameworks/base"]="d264ce2 3c2cc04"
    ["vendor/lineage"]="0e584f7"
)
for dir in "${!patches[@]}"; do
    (cd $dir && git fetch https://github.com/Kajal4414/android_${dir//\//_}.git && git cherry-pick ${patches[$dir]} || { echo -e "${RED}Cherry-pick failed in $dir. Aborting.${NC}"; git cherry-pick --abort; })
done

echo -e "${BLUE}Starting Build...${NC}"
. build/envsetup.sh && lunch lineage_spes-user && m bacon
