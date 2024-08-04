#!/bin/bash

# Colors
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display section dividers
divider() {
    local divider_char="-"
    local divider_length=80
    local divider_color="${GREEN}"
    local reset_color="${NC}"

    printf "${divider_color}"
    printf "%${divider_length}s\n" | tr ' ' "$divider_char"
    printf "${reset_color}"
}

# Function to delete a directory and show status
delete_directory() {
    local directory="$1"

    if [ -d "$directory" ]; then
        rm -rf "$directory"
        echo -e "${GREEN}Directory '$directory' deleted successfully.${NC}"
    else
        echo -e "${YELLOW}Directory '$directory' does not exist. Skipping deletion.${NC}"
    fi
}

# Function to clone a repository
clone_repo() {
    local repo_url="$1"
    local branch="$2"
    local destination="$3"

    echo -e "${YELLOW}Cloning $destination...${NC}"
    if git clone -b "$branch" "$repo_url" "$destination"; then
        echo -e "${GREEN}Repository cloned successfully to $destination.${NC}\n"
    else
        echo -e "${RED}Failed to clone repository to $destination.${NC}\n"
        return 1
    fi
}

# Function to apply patches
apply_patches() {
    local directory="$1"
    local repo_url="$2"
    local branch="$3"
    local commit_hashes=("${@:4}")  # Collect all commit hashes into an array

    echo -e "${YELLOW}Applying patches to $directory...${NC}"
    pushd "$directory"
    git fetch "$repo_url" "$branch"

    for commit_hash in "${commit_hashes[@]}"; do
        if git cherry-pick "$commit_hash"; then
            echo -e "${GREEN}Patch with commit hash $commit_hash applied successfully to $directory.${NC}\n"
        else
            echo -e "${RED}Failed to apply patch with commit hash $commit_hash to $directory.${NC}\n"
        fi
    done

    popd
    echo -e "${GREEN}Patches applied successfully to $directory.${NC}\n"
}

# Set up environment
rm -rf .repo/local_manifest
repo init -u https://github.com/crdroidandroid/android.git -b 13.0 --git-lfs
/opt/crave/resync.sh

# Remove unwanted directories and show status
divider
delete_directory "device/xiaomi/spes"
delete_directory "vendor/xiaomi/spes"
delete_directory "kernel/xiaomi/spes"
delete_directory "hardware/xiaomi"
delete_directory "hardware/lineage/compat"

# Device repositories
divider
clone_repo "https://github.com/Kajal4414/android_device_xiaomi_spes.git" "13.0" "device/xiaomi/spes"
clone_repo "https://github.com/Kajal4414/android_vendor_xiaomi_spes.git" "13.0" "vendor/xiaomi/spes"
clone_repo "https://github.com/Kajal4414/android_kernel_xiaomi_spes.git" "13.0" "kernel/xiaomi/spes"

# Hardware repositories
clone_repo "https://github.com/Kajal4414/android_hardware_xiaomi.git" "13.0" "hardware/xiaomi"
clone_repo "https://github.com/Kajal4414/android_hardware_lineage_compat.git" "13.0" "hardware/lineage/compat"

# Applying patches
divider
apply_patches "packages/apps/crDroidSettings" "https://github.com/Kajal4414/android_packages_apps_crDroidSettings.git" "13.0" "252a9a9" "428bf1e" # Remove GameSpace shortcut and Updater.
apply_patches "frameworks/base" "https://github.com/Kajal4414/android_frameworks_base.git" "13.0" "d264ce2" "3c2cc04" # Remove support for GameSpace.
apply_patches "vendor/lineage" "https://github.com/Kajal4414/android_vendor_crdroid.git" "13.0" "0e584f7" # Remove some packages: Eleven, ExactCalculator, GameSpace, Jelly, LineageSetupWizard, MatLog, Recorder and Updater.
