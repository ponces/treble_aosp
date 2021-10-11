
## Building PHH-based AOSP GSIs ##

To get started with building AOSP GSI, you'll need to get familiar with [Git and Repo](https://source.android.com/source/using-repo.html) as well as [How to build a GSI](https://github.com/phhusson/treble_experimentations/wiki/How-to-build-a-GSI%3F).

First, create a new working directory for your AOSP build and navigate to it:

    mkdir aosp; cd aosp

Initialize your AOSP workspace:

    repo init -u https://android.googlesource.com/platform/manifest -b android-12.0.0_r1

Clone this repo:

    git clone https://github.com/ponces/treble_build_aosp

Finally, start the build script:

    bash treble_build_aosp/build.sh

Be sure to update the cloned repos from time to time!

---

Note: A-only and VNDKLite targets are now generated from AB images - refer to [sas-creator](https://github.com/phhusson/sas-creator).
