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
#               Remove unnessesary unprotected yum packages
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
yum remove -y gobject-intro*
yum remove -y audit
yum remove -y python-config*
yum remove -y kbd-legacy
yum remove -y chrony
yum remove -y passwd
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
yum remove -y libnfnetlink
yum remove -y virt-what
yum remove -y libestr
yum remove -y python-schedutils
yum remove -y device-mapper-event
yum remove -y fxload
yum remove -y libaio
yum remove -y fipscheck
yum remove -y aic94xx-firmware
yum remove -y hostname
yum remove -y kernel-tools-libs
yum remove -y dracut-config-rescue
yum remove -y crontabs
yum remove -y rootfiles
yum remove -y firewalld-filesystem
yum remove -y vim-minimal
yum remove -y gettext-libs
yum remove -y gobject-introspection
yum remove -y ethtool
yum remove -y libcroco
yum remove -y libgomp
yum remove -y grubby
yum remove -y sysvinit

# ---------------------------------------------------------------------
#                 Remove unnessesary protected yum packages
# ---------------------------------------------------------------------

echo -e "\e[1;33mRemoving unnessesary protected yum packages...\e[0m"

yum remove -y groff-base --setopt=protected_multilib=false --setopt=protected_packages=none
yum remove -y libunistring --setopt=protected_multilib=false --setopt=protected_packages=none
yum remove -y libnl3 --setopt=protected_multilib=false --setopt=protected_packages=none
yum remove -y audit --setopt=protected_multilib=false --setopt=protected_packages=none
yum remove -y libselinux-python --setopt=protected_multilib=false --setopt=protected_packages=none´
yum remove -y gdbm --setopt=protected_multilib=false --setopt=protected_packages=none

# ---------------------------------------------------------------------
#                         Remove redundant files
# ---------------------------------------------------------------------
echo -e "\e[1;33mRemoving redundant files...\e[0m"


rm -rf /var/cache
rm -rf /var/lib/yum
rm -rf /var/lib/NetworkManager

# Delete all logs
rm -rf /run/log/

rm -rf /etc/udev/hwdb.bin
rm -rf /etc/pki/ca-trust

rm -rf /usr/include
rm -rf /usr/games
rm -rf /usr/etc
rm -rf /usr/locale

rm -rf /usr/share/doc
rm -rf /usr/share/man
rm -rf /usr/share/info
rm -rf /usr/share/groff
rm -rf /usr/share/locale
rm -rf /usr/share/i18n
rm -rf /usr/share/fonts
rm -rf /usr/share/gcc*
rm -rf /usr/share/magic
rm -rf /usr/share/redhat-release
rm -rf /usr/share/cracklib
rm -rf /usr/share/glib*
rm -rf /usr/share/ghostscript
rm -rf /usr/share/games
rm -rf /usr/share/wallpapers
rm -rf /usr/share/zoneinfo
rm -rf /usr/share/gnome
rm -rf /usr/share/sounds
rm -rf /usr/share/themes
rm -rf /usr/share/xml
rm -rf /usr/share/backgrounds
rm -rf /usr/share/awk
rm -rf /usr/share/gdb
rm -rf /usr/share/file
rm -rf /usr/share/fontconfig
rm -rf /usr/share/liceses
rm -rf /usr/share/mime*
rm -rf /usr/share/desktop*
rm -rf /usr/share/applications
rm -rf /usr/share/icons
rm -rf /usr/share/dict
rm -rf /usr/share/terminfo
rm -rf /usr/share/centos-release
rm -rf /usr/share/hwdata
rm -rf /usr/share/libwacom
rm -rf /usr/share/empty
rm -rf /usr/share/libdrm
rm -rf /usr/share/augeas
rm -rf /usr/share/lua
rm -rf /usr/share/misc
rm -rf /usr/share/idl
rm -rf /usr/share/tabset
rm -rf /usr/share/xsessions
rm -rf /usr/share/zsh
rm -rf /usr/share/pki
rm -rf /usr/share/omf
rm -rf /usr/share/aclocal
rm -rf /usr/share/polkit*
rm -rf /usr/share/kde4
rm -rf /usr/share/glvnd
rm -rf /usr/share/bash-completion
rm -rf /usr/share/pixmaps
rm -rf /usr/share/pkgconfig
rm -rf /usr/share/gnupg
rm -rf /usr/share/systemtap
rm -rf /usr/share/licenses
rm -rf /usr/share/man

# *** lib done ***
rm -rf /usr/lib/kernel
rm -rf /usr/lib/modules
rm -rf /usr/lib/locale
rm -rf /usr/lib/udev/accelerometer
rm -rf /usr/lib/udev/ata_id
rm -rf /usr/lib/udev/cdrom_id
rm -rf /usr/lib/udev/collect
rm -rf /usr/lib/udev/libinput-device-group
rm -rf /usr/lib/udev/libinput-model-quirisk
rm -rf /usr/lib/udev/mtd_probe
rm -rf /usr/lib/udev/phys-port-name-gen
rm -rf /usr/lib/udev/scsi_id
rm -rf /usr/lib/udev/v4l_id
rm -rf /usr/lib/udev/hwdb.d
rm -rf /usr/lib/rpm
rm -rf /usr/lib/debug
rm -rf /usr/lib/dracut
rm -rf /usr/lib/firmware
rm -rf /usr/lib/kbd
rm -rf /usr/lib/games
rm -rf /usr/lib/sse2
rm -rf /usr/lib/debugudev
rm -rf /usr/lib/tmpfiles.d
#rm -rf /usr/lib/udev will fuck os
#rm -rf /usr/lib/sysctl.d will fuck os
#rm -rf /usr/lib/os-release will fuck os
#rm -rf /usr/lib/modprobe.d will fuck os
#rm -rf /usr/lib/binfmt.d will fuck os
rm -rf /usr/lib/systemd/systemd-ac-power
rm -rf /usr/lib/systemd/systemd-activate
rm -rf /usr/lib/systemd/systemd-backlight
rm -rf /usr/lib/systemd/systemd-binfmt
rm -rf /usr/lib/systemd/systemd-coredump
rm -rf /usr/lib/systemd/systemd-cgroups-agent
rm -rf /usr/lib/systemd/systemd-fsck
rm -rf /usr/lib/systemd/systemd-hibernate-resume
rm -rf /usr/lib/systemd/systemd-hostnamed
rm -rf /usr/lib/systemd/systemd-importd
rm -rf /usr/lib/systemd/systemd-journald
rm -rf /usr/lib/systemd/systemd-localed
#rm -rf /usr/lib/systemd/systemd-logind
rm -rf /usr/lib/systemd/systemd-m*
rm -rf /usr/lib/systemd/systemd-pull
rm -rf /usr/lib/systemd/systemd-q*
#rm -rf /usr/lib/systemd/systemd-r* # lmao readhead?
rm -rf /usr/lib/systemd/systemd-sl*
rm -rf /usr/lib/systemd/systemd-t*
rm -rf /usr/lib/systemd/systemd-update*
rm -rf /usr/lib/systemd/systemd-vc*

rm -rf /usr/bin/a*
rm -rf /usr/bin/gpasswd
rm -rf /usr/bin/c++filt
rm -rf /usr/bin/chage
rm -rf /usr/bin/co*
rm -rf /usr/bin/gpg*
rm -rf /usr/bin/gzip
rm -rf /usr/bin/hexdum
rm -rf /usr/bin/host*
rm -rf /usr/bin/iceauth
rm -rf /usr/bin/iconv
rm -rf /usr/bin/info*
rm -rf /usr/bin/install
rm -rf /usr/bin/last*
rm -rf /usr/bin/j*
rm -rf /usr/bin/g*
rm -rf /usr/bin/f*
rm -rf /usr/bin/i*
rm -rf /usr/bin/z*
rm -rf /usr/bin/xz*
rm -rf /usr/bin/sha*
rm -rf /usr/bin/rpm*
rm -rf /usr/bin/system-analyze*
rm -rf /usr/bin/base*
rm -rf /usr/bin/bg
rm -rf /usr/bin/cal
rm -rf /usr/bin/cat
rm -rf /usr/bin/catchsegv
rm -rf /usr/bin/ch*
rm -rf /usr/bin/ck*
rm -rf /usr/bin/cl*
rm -rf /usr/bin/cm*
rm -rf /usr/bin/cpio
rm -rf /usr/bin/cr*
rm -rf /usr/bin/cs*
rm -rf /usr/bin/cu*
rm -rf /usr/bin/cvt
rm -rf /usr/bin/date
# rm -rf /usr/bin/db* fails to boot



rm -rf /usr/lib64/rtkaio
# login gets fucked when deleting these
#rm -rf /usr/lib64/audit
#rm -rf /usr/lib64/security
rm -rf /usr/lib64/fipscheck
rm -rf /usr/lib64/pkcs11
rm -rf /usr/lib64/openssl
rm -rf /usr/lib64/pkgconfig
rm -rf /usr/lib64/girepository*
rm -rf /usr/lib64/sas12
rm -rf /usr/lib64/libuser
rm -rf /usr/lib64/mysql
rm -rf /usr/lib64/elfutils
rm -rf /usr/lib64/gconv
rm -rf /usr/lib64/nss
rm -rf /usr/lib64/krb5
rm -rf /usr/lib64/tls
rm -rf /usr/lib64/libk5crypto*
# rm -rf /usr/lib64/ld-* deleting this fucks up everything
rm -rf /usr/lib64/libncurse*
#rm -rf /usr/lib64/libcrypt* deleting this fucks up login
rm -rf /usr/lib64/libsmime3.so
rm -rf /usr/lib64/libsmart*
#rm -rf /usr/lib64/libexpa* deleting this fucks up login/boot
rm -rf /usr/lib64/libinfo*
rm -rf /usr/lib64/librpmio*
rm -rf /usr/lib64/libssh2*
rm -rf /usr/lib64/liblua*
#rm -rf /usr/lib64/libnss* fucks up boot
rm -rf /usr/lib64/libcidn*
rm -rf /usr/lib64/libglapi*
rm -rf /usr/lib64/libidn*
# rm -rf /usr/lib64/libgpg* deleting this fucks up everything
rm -rf /usr/lib64/libustr*
rm -rf /usr/lib64/libcurse*
rm -rf /usr/lib64/libnsprt4*
#rm -rf /usr/lib64/libblkid* # fucks up the boot completely
rm -rf /usr/lib64/libsemanage*
#rm -rf /usr/lib64/libmount* # does not mount the bootable disk so 

rm -rf /usr/bin/trust
rm -rf /usr/bin/certutil
rm -rf /usr/bin/oldfind
rm -rf /usr/bin/find
rm -rf /usr/bin/diff

rm -rf /usr/sbin/fdisk

rm -rf /usr/libexec/getconf
rm -rf /usr/libexec/awk
rm -rf /usr/libexec/selinux
rm -rf /usr/libexec/sudo
