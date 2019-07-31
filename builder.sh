#!/bin/bash
clear
echo "
==============================================
|          VIP3r-OS Builder Script           |
|                                            |
|   Version  : 2.4 Beta                      |
|   Codename : benatar                       |
|   Author   : vip3r                         |
|   Desc.    : This script for building      |
|              VIP3r-OS based on debian      |
|              unstable using live-build     |
==============================================

"
echo -e "This script must be run with sudo/root permissions\n"

#step 1 - pre
echo -e "Checking vip3r-material directory..."
if [-d "vip3r-material/"]
then
	echo -e "directory found...\n"
else
	echo -e "directory does not exist...\n"
	echo -e "create vip3r-material directory...\n"
	mkdir -p viper-material/{desktop-config, backgrounds, scripts, icons, hooks, bootloaders, misc64}
	echo -e "Done...\n"
	echo -e "Puts your modifications file to vip3r-material directory\n"
fi
#================================== end step 1 =====================================

#step 2 - build
#declarate pwd to variable
lct="$(pwd)"

#create build directory
mkdir vip3r
cd vip3r

#setup live-build config
lb config	--binary-images iso-hybrid\
			--mode debian\
			--architectures amd64\
			--linux-flavours amd64\
			--distribution unstable\
			--archives-areas "main contrib non-free"\
			--updates true\
			--security true\
			--cache true\
			--apt-recommend true\
			--debian-installer live\
			--debian-installer-gui false\
			--win32-loader false\
			--iso-application vip3r-OS_1.1beta\
			--iso-publisher https://github.com/xxxHolic3/
			--iso-volume vip3r-OS_1.1beta-live

#added Mate desktop manager
echo task-mate-desktop > $lct/vip3r/config/package-lists/desktop.list.chroot

#added default tools installed
echo	gparted\
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
		> $lct/vip3r/config/package-lists/package-list.chroot

#copying meta-vip3r file from vip3r-material directory
cp $lct/vip3r-material/metapackages/metavip3r-list.chroot > $lct/vip3r/config/package-lists/metavip3r-list.chroot

