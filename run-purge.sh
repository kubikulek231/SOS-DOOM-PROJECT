#!/bin/bash
# ---------------------------------------------------------------------
# Bash script for removing unnecessary files
# Written as part of an assignment during the BPC-SOS course at FEEC BUT
# Authors: Jakub Lepik, Martin Moncek, Matej Baranyk
#
# This script is released under the GNU General Public License v3.0.
# For more details, see: https://www.gnu.org/licenses/gpl-3.0.html
# ---------------------------------------------------------------------

# Variables
safepurge=0
noreboot=0

# Run purge automatically when setup is finished and -a or --autopurge is specified
while [[ $# -gt 0 ]]; do
  case $1 in
    -s | --safepurge)
      safepurge=1
      ;;
    -n | --noreboot)
      noreboot=1
      ;;
    -*)
      echo "Invalid option: $1" >&2
      exit 1
      ;;
  esac
  shift
done


# Echo running onlyinstall
if [ $safepurge == 1 ]; then
  echo -e "\e[33mSafe purge flag specified, purge will work in safe mode!\e[0m"
fi

# Echo will not reboot on purge
if [ $noreboot == 1]; then
  echo -e "\e[33mNoreboot flag specified, will not reboot after finished.\e[0m"
fi

# ---------------------------------------------------------------------
#                      Remove unnessesary /boot files
# ---------------------------------------------------------------------

echo -e "\e[1;33mRemoving unnessesary /boot files...\e[0m"
rm -f /boot/vmlinuz-0*
rm -f /boot/initramfs-0*
rm -f /boot/symvers*
rm -f /boot/*kdump.img
rm -rf /boot/grub
rm -rf /boot/grub2/fonts
rm -rf /boot/grub2/l*
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
#                         Disable logging
# ---------------------------------------------------------------------
echo -e "\e[1;33mDisabling all logging...\e[0m"

# mask the socket (symlink-redirect to /dev/null)
# so it does not spawn another systemd-journald when stopped
systemctl mask systemd-journald.socket

# stop and disable the services
systemctl stop rsyslog
systemctl stop systemd-journald
systemctl disable systemd-journald
systemctl disable rsyslog

# desperate solution i guess
# deletes the file on boot and with systemd-journald disabled it should be ok
echo "rm -rf /run/log" >> /etc/rc.local

# chmod +x /etc/rc.local
chmod +x /etc/rc.local

# reload the daemon
systemctl daemon-reload

if [[ $safepurge == 1 ]]; then
  echo -e "\e[33mSafe part finished, exiting! :)\e[0m"
  exit
fi

# ---------------------------------------------------------------------
#                         Remove redundant files
# ---------------------------------------------------------------------
echo -e "\e[1;33mRemoving redundant files...\e[0m"

# *** done ***
# last attempt to prevent systemd-journald lol
rm -rf /sys/fs/cgroup/devices/system.slice/systemd-jour*
rm -rf /sys/fs/cgroup/systemd/system.slice/systemd-jour*
rm -rf /etc/systemd/jour*
rm -rf /var/lib/rsyslo
rm -rf /usr/lib/systemd/system/sockets.target.wants/systemd-jour*
rm -rf /usr/lib/systemd/system/systemd-jou*
rm -rf /usr/lib64/libsystemd-jou*
rm -rf /usr/lib64/rsyslog/imjou*
rm -rf /usr/lib64/rsyslog/onjour*

# *** done ***
# /usr/lib64 purges
rm -rf /usr/lib64/libform*
rm -rf /usr/lib64/libdrm_*
rm -rf /usr/lib64/libcurl*
rm -rf /usr/lib64/libcrypts*
rm -rf /usr/lib64/libnss_d*
rm -rf /usr/lib64/libnss_c*
rm -rf /usr/lib64/libnss_n*
rm -rf /usr/lib64/libnss_m*
rm -rf /usr/lib64/libnss_h*
#rm -rf /usr/lib64/libnss_f* # unbootable
#rm -rf /usr/lib64/libff* input no workey
#rm -rf /usr/lib64/libpa* boot no workey
rm -rf /usr/lib64/libpan*
# rm -rf /usr/lib64/libpam* unbootable
# rm -rf /usr/lib64/libdb* unbootable
# rm -rf /usr/lib64/libex* unbootable
#rm -rf /usr/lib64/libep* Xephyr no workey 
rm -rf /usr/lib64/libxml*
rm -rf /usr/lib64/libkd*
rm -rf /usr/lib64/libkr*
rm -rf /usr/lib64/libj*
rm -rf /usr/lib64/libsas*
rm -rf /usr/lib64/lua
rm -rf /usr/lib64/libB*
# rm -rf /usr/lib64/libb* fails to boot
rm -rf /usr/lib64/libmenu*
rm -rf /usr/lib64/libss*
rm -rf /usr/lib64/libsq*
rm -rf /usr/lib64/libsep*
rm -rf /usr/lib64/libsl*
rm -rf /usr/lib64/libso*
rm -rf /usr/lib64/librpmb*
rm -rf /usr/lib64/librpms*
#rm -rf /usr/lib64/libwac* doom input 
rm -rf /usr/lib64/libv*
rm -rf /usr/lib64/libh*
# rm -rf /usr/lib64/libI* fcs up x
# rm -rf /usr/lib64/libS* same ^
rm -rf /usr/lib64/libcra*
# rm -rf /usr/lib64/libcrypto* fucks up x
rm -rf /usr/lib64/libco*
# rm -rf /usr/lib64/libac* unbootable
rm -rf /usr/lib64/liban*
rm -rf /usr/lib64/libass*
# rm -rf /usr/lib64/libatt* unrebootable (:
# rm -rf /usr/lib64/libau* ^
# rm -rf /usr/lib64/libnsl* login fd
rm -rf /usr/lib64/libpo*
rm -rf /usr/lib64/libpr*
# rm -rf /usr/lib64/libpt* nogo
# rm -rf /usr/lib64/libca* nogo
rm -rf /usr/lib64/libpcre1*
rm -rf /usr/lib64/libpcre3*
rm -rf /usr/lib64/libpcrec*
rm -rf /usr/lib64/libcrepo*
rm -rf /usr/lib64/libpl*
# rm -rf /usr/lib64/libcap-* nogo
rm -rf /usr/lib64/libGLX_*
rm -rf /usr/lib64/libSeg*
#rm -rf /usr/lib64/libelf* nogo
#rm -rf /usr/lib64/libepoxy* nogo
#rm -rf /usr/lib64/libev* nogo
#rm -rf /usr/lib64/libex* ^
rm -rf /usr/lib64/libgb*
# rm -rf /usr/lib64/libfreetype* nogo doom
# rm -rf /usr/lib64/libfreeblpriv* nogo login
# rm -rf /usr/lib64/libglib* nogo mouse
# rm -rf /usr/lib64/libgio*  ^
# rm -rf /usr/lib64/libgmo*  ^
rm -rf /usr/lib64/libgmp*
# rm -rf /usr/lib64/libgo*   ^
# rm -rf /usr/lib64/libgpg nogo unrebootable
rm -rf /usr/lib64/libgpgme*
rm -rf /usr/lib64/libgs*
# rm -rf /usr/lib64/libgu* nogo mouse
# rm -rf /usr/lib64/libinput* same
rm -rf /usr/lib64/libke*
rm -rf /usr/lib64/libgmp*
# rm -rf /usr/lib64/libkmod* unb
rm -rf /usr/lib64/libkms*
rm -rf /usr/lib64/liblb*
rm -rf /usr/lib64/libld*
# rm -rf /usr/lib64/liblz* nogo
# rm -rf /usr/lib64/libm.* ^
rm -rf /usr/lib64/libma*
rm -rf /usr/lib64/libme*
# rm -rf /usr/lib64/libmo* ofc nogo
# rm -rf /usr/lib64/libmt* mouse fucked
# rm -rf /usr/lib64/libnsl* login fcd
rm -rf /usr/lib64/libnss3*
rm -rf /usr/lib64/libnspr*
rm -rf /usr/lib64/libnssc*
rm -rf /usr/lib64/libnssd*
rm -rf /usr/lib64/libnssp*
rm -rf /usr/lib64/libnsss*
rm -rf /usr/lib64/libnssu*
rm -rf /usr/lib64/lib11*
rm -rf /usr/lib64/libo*
#rm -rf /usr/lib64/libp11* nogo
#rm -rf /usr/lib64/libpam.* nogo boot
#rm -rf /usr/lib64/libpam_* nogo login
rm -rf /usr/lib64/libpamc*
rm -rf /usr/lib64/libpcp*
rm -rf /usr/lib64/libpcrep*
# rm -rf /usr/lib64/libpth.* nogo x
rm -rf /usr/lib64/libq*
rm -rf /usr/lib64/libpw*
#rm -rf /usr/lib64/libread* nogo
#rm -rf /usr/lib64/libreso* nogo
rm -rf /usr/lib64/libstd*
rm -rf /usr/lib64/libtas*
rm -rf /usr/lib64/libtic*
# rm -rf /usr/lib64/libtin* login fcd
rm -rf /usr/lib64/libthr*
rm -rf /usr/lib64/libuser*
# rm -rf /usr/lib64/libuu* no boot
rm -rf /usr/lib64/libutil*
rm -rf /usr/lib64/libway*
# rm -rf /usr/lib64/libz* no booterino
rm -rf /usr/lib64/pm*
# rm -rf /usr/lib64/se* login issues
rm -rf /usr/lib64/sas*
rm -rf /usr/lib64/sse*

# *** done ***
# X, xorg specific purges
#rm -rf /usr/lib64/libxcb-xrandr* nogo
rm -rf /usr/lib64/libxcb-xtest*
rm -rf /usr/lib64/libxcb-xselinux*
rm -rf /usr/lib64/libxcb-fixes*
rm -rf /usr/lib64/libxcb-record*
rm -rf /usr/lib64/libxcb-xinerama*
rm -rf /usr/lib64/libxcb-xevie*
rm -rf /usr/lib64/libxcb-screens*
rm -rf /usr/lib64/libxcb-sync*
rm -rf /usr/lib64/libxcb-comp*
rm -rf /usr/lib64/libxcb-d*
rm -rf /usr/lib64/libxcb-res*

rm -rf /usr/lib64/xorg/modules/shadow*
rm -rf /usr/lib64/xorg/modules/ext*
rm -rf /usr/lib64/xorg/modules/libw*
# rm -rf /usr/lib64/xorg/modules/libf* nogo
rm -rf /usr/lib64/xorg/modules/libfbd*
rm -rf /usr/lib64/xorg/modules/libi*
rm -rf /usr/lib64/xorg/modules/libg*
rm -rf /usr/lib64/xorg/modules/libv*
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
#rm -rf /usr/lib64/libmount* # does not mount the bootable disk so (:
rm -rf /usr/lib64/libsystemd-jou*
rm -rf /usr/lib64/rsyslog

# *** done ***
# redundant x language support purges
rm -rf /usr/share/X11/locale/i*
rm -rf /usr/share/X11/locale/zh*
rm -rf /usr/share/X11/locale/j*
rm -rf /usr/share/X11/locale/m*
rm -rf /usr/share/X11/locale/k*
rm -rf /usr/share/X11/locale/g*
rm -rf /usr/share/X11/locale/n*
rm -rf /usr/share/X11/locale/p*
rm -rf /usr/share/X11/locale/t*
rm -rf /usr/share/X11/locale/v*
rm -rf /usr/share/X11/locale/e*
rm -rf /usr/share/X11/locale/c*
rm -rf /usr/share/X11/locale/f*
rm -rf /usr/share/X11/locale/r*
rm -rf /usr/share/X11/locale/s*
rm -rf /usr/share/X11/locale/a*
rm -rf /usr/share/X11/locale/C*

# *** done ***
# rm -rf /usr/share/X11/xkb/symbols/a* no workey
rm -rf /usr/share/X11/xkb/symbols/b*
rm -rf /usr/share/X11/xkb/symbols/c*
rm -rf /usr/share/X11/xkb/symbols/d*
rm -rf /usr/share/X11/xkb/symbols/e*
rm -rf /usr/share/X11/xkb/symbols/f*
rm -rf /usr/share/X11/xkb/symbols/g*
rm -rf /usr/share/X11/xkb/symbols/h*
# rm -rf /usr/share/X11/xkb/symbols/i* x
rm -rf /usr/share/X11/xkb/symbols/j*
# rm -rf /usr/share/X11/xkb/symbols/k* no workey
rm -rf /usr/share/X11/xkb/symbols/l*
rm -rf /usr/share/X11/xkb/symbols/m*
rm -rf /usr/share/X11/xkb/symbols/n*
rm -rf /usr/share/X11/xkb/symbols/o*
rm -rf /usr/share/X11/xkb/symbols/r*
rm -rf /usr/share/X11/xkb/symbols/t*
# rm -rf /usr/share/X11/xkb/symbols/u*

# *** done ***
# /var purges
rm -rf /var/cache
rm -rf /var/lib/yum
rm -rf /var/lib/NetworkManager
rm -rf /var/lib/NetworkManager

rm -rf /usr/local/share/man/
rm -rf /var/tmp
rm -rf /var/lib/anaconda
rm -rf /var/log/anaconda
rm -rf /var/log/tuned
rm -rf /var/log/audit
rm -rf /var/log/rhsm
rm -rf /var/db
rm -rf /var/empty
rm -rf /var/games
rm -rf /var/kerberos
rm -rf /var/spool
rm -rf /var/local
rm -rf /var/lib/rpm
rm -rf /var/lib/yum
rm -rf /var/lib/rsyslog

# run purges... (ram but just it is disabled but still generated)
# Delete all logs
rm -rf /run/log/

# *** done ***
# /etc/ purges
rm -rf /etc/udev/hwdb.bin
rm -rf /etc/pki/ca-trust
rm -rf /etc/rsyslog.d/
rm -rf /etc/selinux/

# *** done ***
# random /usr/? purges
rm -rf /usr/include
rm -rf /usr/games
rm -rf /usr/etc
rm -rf /usr/locale

# *** done ***
# /usr/share purges
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
rm -rf /usr/share/bash-completion*
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

# *** done ***
# /usr/lib/purges
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
rm -rf /usr/lib/systemd/systemd-rand*
rm -rf /usr/lib/systemd/systemd-socket*
#rm -rf /usr/lib/systemd/systemd-sleep
rm -rf /usr/lib/systemd/catalog
rm -rf /usr/lib/systemd/system/systemd-update*
rm -rf /usr/lib/systemd/system/rescue*
rm -rf /usr/lib/systemd/system/printer*
rm -rf /usr/lib/systemd/system/systemd-random*
rm -rf /usr/lib/systemd/system/systemd-tmp*
rm -rf /usr/lib/systemd/system/systemd-time*
rm -rf /usr/lib/systemd/system/network*
rm -rf /usr/lib/systemd/system/bluetooth*
rm -rf /usr/lib/systemd/system/container*
#rm -rf /usr/lib/systemd/system/sleep*
rm -rf /usr/lib/systemd/system/sound*
rm -rf /usr/lib/systemd/system/suspend*
rm -rf /usr/lib/systemd/system/systemd-journ*

# *** done ***
# /usr/bin purges
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
rm -rf /usr/bin/db_*
rm -rf /usr/bin/kernel*
rm -rf /usr/bin/libwa*
rm -rf /usr/bin/link*
rm -rf /usr/bin/libinput-debug*
rm -rf /usr/bin/linux*
rm -rf /usr/bin/lo
rm -rf /usr/bin/lz*
rm -rf /usr/bin/ma*
rm -rf /usr/bin/ms*
rm -rf /usr/bin/md*
rm -rf /usr/bin/me*
rm -rf /usr/bin/jour*

rm -rf /usr/bin/nice
rm -rf /usr/bin/more
rm -rf /usr/bin/mcookie
rm -rf /usr/bin/mk*
rm -rf /usr/bin/mv
rm -rf /usr/bin/namei
rm -rf /usr/bin/whoami
rm -rf /usr/bin/sum
rm -rf /usr/bin/sync
rm -rf /usr/bin/snice
rm -rf /usr/bin/sqlite3
rm -rf /usr/bin/local*
rm -rf /usr/bin/lua*
rm -rf /usr/bin/libin*
rm -rf /usr/bin/st*
rm -rf /usr/bin/logg*
rm -rf /usr/bin/loo*
rm -rf /usr/bin/w*
rm -rf /usr/bin/o*
rm -rf /usr/bin/t*
rm -rf /usr/bin/p*
# rm -rf /usr/bin/r*
rm -rf /usr/bin/se*
rm -rf /usr/bin/t*
rm -rf /usr/bin/p*
rm -rf /usr/bin/re*
rm -rf /usr/bin/rm?
rm -rf /usr/bin/rp*
rm -rf /usr/bin/e*
#rm -rf /usr/bin/d*
#rm -rf /usr/bin/u*
#rm -rf /usr/bin/n* fucks up the get current
rm -rf /usr/bin/si*
rm -rf /usr/bin/sp*
rm -rf /usr/bin/dd*
rm -rf /usr/bin/df*
rm -rf /usr/bin/dg*
rm -rf /usr/bin/di*

# rm -rf /usr/bin/sh* fucks up xorg

rm -rf /usr/bin/si*
rm -rf /usr/bin/sk*
rm -rf /usr/bin/slab*
rm -rf /usr/bin/showrgb*
rm -rf /usr/bin/shuf
rm -rf /usr/bin/shred

rm -rf /usr/bin/sotr*
rm -rf /usr/bin/sp*
rm -rf /usr/bin/ss*
rm -rf /usr/bin/su*
rm -rf /usr/bin/ld*
rm -rf /usr/bin/umask
rm -rf /usr/bin/un*
#rm -rf /usr/bin/ud* can not be deleted bcoz of udev
rm -rf /usr/bin/up*
rm -rf /usr/bin/ut*
rm -rf /usr/bin/uu*
rm -rf /usr/bin/ul*
rm -rf /usr/bin/v*
rm -rf /usr/bin/modutil
rm -rf /usr/bin/mountpoint
rm -rf /usr/bin/new*
rm -rf /usr/bin/nl
rm -rf /usr/bin/nm
rm -rf /usr/bin/nohup
rm -rf /usr/bin/nproc
rm -rf /usr/bin/ns*
rm -rf /usr/bin/ra*
rm -rf /usr/bin/rmdir
rm -rf /usr/bin/ru*
rm -rf /usr/bin/lsb*
rm -rf /usr/bin/lsc*
rm -rf /usr/bin/lsi*
rm -rf /usr/bin/lsl*
rm -rf /usr/bin/lsm*
rm -rf /usr/bin/lsn*
rm -rf /usr/bin/bashbug*
rm -rf /usr/bin/sg*
rm -rf /usr/bin/sdiff*
rm -rf /usr/bin/script*
rm -rf /usr/bin/logname
rm -rf /usr/bin/ln
rm -rf /usr/bin/lch*
rm -rf /usr/bin/k*
rm -rf /usr/bin/h*
rm -rf /usr/bin/ca*
rm -rf /usr/bin/cp
rm -rf /usr/bin/[
rm -rf /usr/bin/users
rm -rf /usr/bin/dmesg
rm -rf /usr/bin/dwp
rm -rf /usr/bin/yes
rm -rf /usr/bin/x86*
rm -rf /usr/bin/umount
rm -rf /usr/bin/busctl
rm -rf /usr/bin/loginctl
rm -rf /usr/bin/bootctl
rm -rf /usr/bin/dbus-cleanup*
rm -rf /usr/bin/dbus-monitor
rm -rf /usr/bin/dbus-update*
rm -rf /usr/bin/dbus-test*
rm -rf /usr/bin/dbus-u*
rm -rf /usr/bin/dbus-s*
rm -rf /usr/bin/dbus-run
rm -rf /usr/bin/systemd*
rm -rf /usr/bin/xml*

rm -rf /usr/bin/uxterm
rm -rf /usr/bin/xhost
rm -rf /usr/bin/xgamma
rm -rf /usr/bin/xmod
rm -rf /usr/bin/xrandr
rm -rf /usr/bin/xrdb
rm -rf /usr/bin/xrefr*
rm -rf /usr/bin/xset*
rm -rf /usr/bin/xstd*
rm -rf /usr/bin/xkill
# rm -rf /usr/bin/xkbcomp fucks up xorg
rm -rf /usr/bin/xauth
rm -rf /usr/bin/xargs
rm -rf /usr/bin/xinput
rm -rf /usr/bin/dracut

rm -rf /usr/bin/trust
rm -rf /usr/bin/certutil
rm -rf /usr/bin/oldfind
rm -rf /usr/bin/find
rm -rf /usr/bin/diff

# *** done ***
# /usr/sbin purges
rm -rf /usr/sbin/fdisk
rm -rf /usr/sbin/rsyslogd
rm -rf /usr/sbin/add*
rm -rf /usr/sbin/apply*
# rm -rf /usr/sbin/age* tty start fail
rm -rf /usr/sbin/aut*
rm -rf /usr/sbin/aug*
rm -rf /usr/sbin/aur*
rm -rf /usr/sbin/aus*
rm -rf /usr/sbin/f*
rm -rf /usr/sbin/gr*
rm -rf /usr/sbin/ch*
rm -rf /usr/sbin/ca*
rm -rf /usr/sbin/i*
rm -rf /usr/sbin/p*
rm -rf /usr/sbin/s*
rm -rf /usr/sbin/b*
rm -rf /usr/sbin/d*
rm -rf /usr/sbin/get*
# rm -rf /usr/sbin/g* doom fd
# rm -rf /usr/sbin/r*
rm -rf /usr/sbin/add*
rm -rf /usr/sbin/h*
rm -rf /usr/sbin/k*
rm -rf /usr/sbin/l*
rm -rf /usr/sbin/m*
rm -rf /usr/sbin/n*
rm -rf /usr/sbin/t*
rm -rf /usr/sbin/unix*
rm -rf /usr/sbin/user*
rm -rf /usr/sbin/up*
rm -rf /usr/sbin/c*

# *** done ***
# /usr/libexec purges
rm -rf /usr/libexec/getconf*
rm -rf /usr/libexec/awk*
rm -rf /usr/libexec/selinux* fcs up doom
rm -rf /usr/libexec/sudo*
#rm -rf /usr/libexec/initsc*

# *** done ***
# remove redundant scripts
rm -rf /root/run-se*
rm -rf /root/run-pur*

# Reboot if noreboot=0
if [ $noreboot == 0 ]; then
  echo -e "\e[33mRebooting in 3 seconds...\e[0m"
  sleep 3
  reboot
fi

echo -e "\e[33mNot rebooting.\e[0m"

exit 0
