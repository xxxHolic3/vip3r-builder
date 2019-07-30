#!/bin/bash
clear
echo "
==============================================
|          VIP3r-OS Builder Script           |
|                                            |
|   Version  : 1.1.0 Beta                    |
|   Codename : Venom                         |
|   Author   : vip3r                         |
|   Desc.    : This script for building      |
|              VIP3r-OS based on debian      |
|              unstable using live-build     |
==============================================

"
echo -e "This script must be run with sudo/root permissions\n"

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
			--iso-publisher https://github.com/xxxHolic3\
			--iso-volume vip3r-OS_1.1beta-live

#added Mate desktop manager
echo task-mate-desktop > $lct/vip3r/config/package-lists/desktop.list.chroot

#added default tools installed
echo	gparted\
		vlc\
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
		nmap\
		wireshark\
		aircrack-ng\
		> $lct/vip3r/config/package-lists/package-list.chroot

