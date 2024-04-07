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
yum remove -y iwl7260-*
yum remove -y selinux
yum remove -y centos-logos

