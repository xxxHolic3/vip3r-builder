#!/bin/bash
clear
echo "
==============================================
|          Paranoid-OS Builder Script        |
|                                            |
|   Version  : 3.0 Beta                      |
|   Codename : Memories                      |
|   Author   : vip3r                         |
|   Desc.    : This script for building      |
|              Paranoid-OS based on debian   |
|              unstable using live-build.    |
==============================================

"
echo -e "This script must be run with sudo/root permissions\n"

#step 1 - pre
echo -e "Checking paranoid-material directory..."
if [-d "paranoid-material/"]
then
	echo -e "directory found...\n"
else
	echo -e "directory does not exist...\n"
	echo -e "create paranoid-material directory...\n"
	mkdir -p paranoid-material/{desktop-config, backgrounds, scripts, icons, hooks, bootloaders, misc64}
	echo -e "Done...\n"
	echo -e "Puts your modifications file to paranoid-material directory\n"
fi
#================================== end step 1 =====================================

#step 2 - build
#declarate pwd to variable
lct="$(pwd)"

#create build directory
mkdir paranoid
cd paranoid

#setup live-build config
lb config	--binary-images iso-hybrid\
			--mode debian\
			--architectures amd64\
			--linux-flavours amd64\
			--distribution unstable\
			--archives-areas "main contrib non-free"\
			--mirror-bootstrap "http://kartolo.sby.datautama.net.id/debian"\
			--updates false\
			--security false\
			--backports false\
			--cache true\
			--apt-recommend true\
			--bootappend-live "boot=live username=root hostname=paranoid noautomount"
			--debian-installer-gui live\
			--win32-loader false\
			--iso-application Paranoid-OS_1.0beta\
			--iso-publisher https://github.com/xxxHolic3\
			--iso-volume Paranoid-OS_1.0beta-live

#added Mate desktop manager
echo task-mate-desktop > $lct/paranoid/config/package-lists/desktop.list.chroot

#added default tools installed
echo	gparted\
		linux-image\
		vlc\
		firefox-esr\
		squashfs-tools\
		syslinux\
		syslinux-common\
		dosfstools\
		isolinux\
		live-build\
		fakeroot\
		linux-headers-amd64\
		lsb-release\
		menu\
		build-essential\
		dkms\
		curl\
		wget\
		iftop\
		apt-transport-https\
		dirmngr\
		firmware-linux\
		> $lct/paranoid/config/package-lists/package-list.chroot

#copying meta-vip3r file from vip3r-material directory
cp $lct/paranoid-material/metapackages/paranoidMeta-list.chroot > $lct/paranoid/config/package-lists/paranoidMeta-list.chroot