rm -rf .repo/local_manifest out
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

export KEY_MAPPINGS=vendor/aospa/signatures
export AOSPA_BUILDTYPE=BETA

git config --global user.name "Kajal4414"
git config --global user.email "81718060+Kajal4414@users.noreply.github.com"
(cd build/soong && git fetch https://gerrit.aospa.co/AOSPA/android_build_soong refs/changes/57/40257/1 && git cherry-pick FETCH_HEAD)
git clone https://github.com/aospa-chrisl7/android_vendor_aospa_signatures.git vendor/aospa/signatures
(cd vendor/aospa/signatures && ./generate.sh)

m otatools target-files-package -j$(nproc)
sign_target_files_apks -o -d $KEY_MAPPINGS $OUT/obj/PACKAGING/target_files_intermediates/aospa_spes-target_files-eng.nobody.zip aospa-user-signed-target_files-eng.nobody.zip
ota_from_target_files -k $KEY_MAPPINGS/releasekey --block aospa-user-signed-target_files-eng.nobody.zip aospa-user.zip

. build/envsetup.sh
lunch aospa_spes-user
m installclean -j$(nproc)
m otapackage -j$(nproc)
