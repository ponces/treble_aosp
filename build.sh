#!/bin/bash
echo ""
echo "AOSP 12 Treble Buildbot"
echo "ATTENTION: this script syncs repo on each run"
echo "Executing in 5 seconds - CTRL-C to exit"
echo ""
sleep 5

# Abort early on error
set -eE
trap '(\
echo;\
echo \!\!\! An error happened during script execution;\
echo \!\!\! Please check console output for bad sync,;\
echo \!\!\! failed patch application, etc.;\
echo\
)' ERR

START=`date +%s`
BUILD_DATE="$(date +%Y%m%d)"
BL=$PWD/treble_build_aosp

echo "Preparing local manifest"
mkdir -p .repo/local_manifests
cp $BL/manifest.xml .repo/local_manifests/manifest.xml
echo ""

echo "Syncing repos"
repo sync -c --force-sync --no-clone-bundle --no-tags -j$(nproc --all)
echo ""

echo "Setting up build environment"
source build/envsetup.sh &> /dev/null
echo ""

echo "Applying PHH patches"
bash $BL/apply-patches.sh $BL old
bash $BL/apply-patches.sh $BL new
cd device/phh/treble
bash generate.sh
cd ../../..
echo ""

echo "CHECK PATCH STATUS NOW!"
sleep 5
echo ""

export WITHOUT_CHECK_API=true
mkdir -p ~/builds

buildVariant() {
    lunch ${1}-userdebug
    make -j$(nproc --all) systemimage
    xz -c $OUT/system.img -T0 > ~/builds/system-s-arm64-ab-gapps.img.xz
}

buildVariant treble_arm64_bgN
#buildVariant treble_arm64_bvN

END=`date +%s`
ELAPSEDM=$(($(($END-$START))/60))
ELAPSEDS=$(($(($END-$START))-$ELAPSEDM*60))
echo "Buildbot completed in $ELAPSEDM minutes and $ELAPSEDS seconds"
echo ""
