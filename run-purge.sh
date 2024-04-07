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

# yum remove -y iproute delete when network is not needed