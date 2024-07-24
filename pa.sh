rm -rf .repo/local_manifest out
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

export FILE_NAME_TAG=eng.nobody
export AOSPA_BUILDTYPE=BETA

. build/envsetup.sh
lunch aospa_spes-user
m installclean
m otapackage
