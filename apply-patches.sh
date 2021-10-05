#!/bin/bash

set -e

patches="$(readlink -f -- $1)"

for project in $(cd $patches/patches; echo *);do
	p="$(tr _ / <<<$project |sed -e 's;platform/;;g')"
	[ "$p" == build ] && p=build/make
	pushd $p
	for patch in $patches/patches/$project/*.patch;do
		git am $patch || exit
	done
	popd
done
