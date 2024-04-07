#!/bin/bash
# ---------------------------------------------------------------------
# Bash script for removing unnessesary files
# Written as part of an assignment during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This script is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

# ---------------------------------------------------------------------
#                      Remove unnessesary /boot files
# ---------------------------------------------------------------------

echo -e "\e[1;33mRemoving unnessesary /boot files...\e[0m"
rm -f /boot/vmlinuz-0*
rm -f /boot/initramfs-0*
rm -f /boot/symvers*
rm -f /boot/*kdump.img
rm -rf /boot/grub
rm -f /boot/System.map-*
rm -f /boot/efi

# ---------------------------------------------------------------------
#                   Remove unnessesary yum packages
# ---------------------------------------------------------------------

echo -e "\e[1;33mRemoving unnessesary yum packages...\e[0m"
yum remove -y linux-firmware
yum remove -y iwl*
yum remove -y selinux*
yum remove -y centos-logos
yum remove -y alsa*
yum remove -y postfix
yum remove -y grub2-tools
yum remove -y grub2-common
yum remove -y policycore*
yum remove -y microcode_ctl
yum remove -y mariadb-libs
yum remove -y wpa_supplicant
yum remove -y btrfs-progs
yum remove -y xfsprogs
yum remove -y mozjs17
yum remove -y sudo
yum remove -y lvm2
yum remove -y bind-export-libs
# yum remove -y tar protected
# yum remove -y pam protected
yum remove -y kbd-misc
yum remove -y parted
yum remove -y grub2-pc-modules
yum remove -y authconfig
yum remove -y man-db
yum remove -y rsyslog
yum remove -y python-firewall
yum remove -y firewalld
yum remove -y slang
yum remove -y iptables
yum remove -y device-mapper*
yum remove -y make
yum remove -y python-go*
yum remove -y iprutils
yum remove -y ivtv*
yum remove -y gobject-intro*´
yum remove -y audit
yum remove -y python-config*
yum remove -y kbd-legacy
yum remove -y chrony
yum remove -y passwd # here network got fucked ... guess i delete it all together now?
yum remove -y NetworkMa*
yum remove -y e2fsprogs*
yum remove -y ebtables
yum remove -y kernel-tools
yum remove -y python-perf
yum remove -y iputils
yum remove -y libseccomp
yum remove -y dbus-glib
yum remove -y teamd
yum remove -y dhcp-common
yum remove -y libedit
yum remove -y python-pyudev
yum remove -y plymouth*
yum remove -y cronie
yum remove -y bc
yum remove -y dmidecode
yum remove -y less
yum remove -y acl
yum remove -y libselinux-utils
yum remove -y lzo
yum remove -y libsysfs
yum remove -y dhcp-libs
yum remove -y libnetfilter*
yum remove -y libpipeline
yum remove -y tcp_wrappers*
yum remove -y grubby
yum remove -y snappy
yum remove -y logrotate
yum remove -y libteam
yum remove -y os-prober
yum remove -y python-linux-procfs
yum remove -y lsscsi
yum remove -y popt
yum remove -y which
yum remove -y libndp
yum remove -y jansson
yum remove -y libss
yum remove -y pciutils-libs
yum remove -y python-decorator
yum remove -y irqbalance
yum remove -y file
yum remove -y libdaemon
yum remove -y ipset
yum remove -y python-slip
yum remove -y biosdevname
yum remove -y libfastjson
yum remove -y libmnl
yum remove -y numactl-libs
yum remove -y device-mapper-event-libs

yum remove -y libXrandr
yum remove -y libffi
yum remove -y libnfnetlink
yum remove -y libXcursor
yum remove -y libXrender
yum remove -y virt-what
yum remove -y libpciaccess
yum remove -y centos-release
yum remove -y libestr
yum remove -y python-schedutils
yum remove -y device-mapper-event
yum remove -y fxload
yum remove -y keyutils-libs
yum remove -y cronie-anacron
yum remove -y kpartx
yum remove -y libaio
yum remove -y fipscheck
yum remove -y libacl
yum remove -y aic94xx-firmware
yum remove -y libXdamage
yum remove -y libXxf86misc
yum remove -y libXfixes
yum remove -y xcb-util
yum remove -y mtdev
yum remove -y libXxf86vm
yum remove -y libverto
yum remove -y xcb-util-image
yum remove -y xcb-util-renderutil
yum remove -y libuuid
yum remove -y libattr
yum remove -y hostname
yum remove -y kernel-tools-libs
yum remove -y hardlink
yum remove -y libXinerama
yum remove -y nss-sysinit
yum remove -y xcb-util-keysyms
yum remove -y fipscheck-lib
yum remove -y libxshmfence
yum remove -y dracut-config-rescue
yum remove -y systemd-sysv
yum remove -y crontabs
yum remove -y elfutils-default-yama-scope
yum remove -y rootfiles
yum remove -y firewalld-filesystem







# yum remove -y iproute delete when network is not needed