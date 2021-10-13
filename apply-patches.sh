#!/bin/bash

set -e

patches="$(readlink -f -- $1)"
tree="$2"

for project in $(cd $patches/patches/$tree; echo *);do
	p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
	[ "$p" == build ] && p=build/make
	[ "$p" == vendor/hardware/overlay ] && p=vendor/hardware_overlay
	pushd $p
	for patch in $patches/patches/$tree/$project/*.patch;do
		git am $patch || exit
	done
	popd
done
