rm -rf .repo/local_manifest out
repo init -u https://github.com/AOSPA/manifest -b uvite
/opt/crave/resync.sh

./rom-build.sh spes -i -t user
