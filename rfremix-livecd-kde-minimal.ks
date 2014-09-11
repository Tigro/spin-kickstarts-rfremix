# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (@base is added by default unless you add --nobase to %packages)
# (default groups for the configured repos are added by --default)

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages --default
-@base-x
-@standard
-@core
-@fonts
-@input-methods
-@multimedia
-@printing
kernel
kernel-modules-extra
-kernel*debug*
-kernel-kdump*
-kernel-*PAE*
-kernel*devel*
-kernel-headers*
-kernel-doc*
-kernel-tools*

# mactel-boot needs to be on the DVD for successful installation to intel macs.
-mactel-boot

# like @base:
NetworkManager
at
bc
bind-utils
bzip2
crontabs
#cyrus-sasl-plain
dbus
ed
logrotate
#lsof
#mailcap
man-db
ntsysv
pciutils
psacct
#quota
#tmpwatch
#traceroute
#PackageKit-yum-plugin
acpid
bash-completion
#bridge-utils
#btrfs-progs
#cifs-utils
#coolkey
#cryptsetup
#dmraid
#dos2unix
#dosfstools
#dump
eject
ethtool
fedora-release-notes
#finger
#fprintd-pam
#ftp
gnupg2
gpm
#hunspell
iptstate
#irda-utils
irqbalance
#jwhois
#krb5-workstation
#lftp
man-pages
mc
#mcelog
#mdadm
microcode_ctl
mlocate
#mtr
#nc
#nfs-utils
ntfs-3g
#ntfsprogs
#numactl
#openssh-clients
#pam_krb5
pam_pkcs11
passwdqc
#pcmciautils
#pinfo
#plymouth
pm-utils
prelink
#rdate
#rdist
#rng-tools
#rsh
#rsync
#sendmail
setuptool
#smartmontools
#sos
#sssd
#stunnel
sudo
symlinks
#system-config-firewall-tui
#talk
tcp_wrappers
#tcpdump
telnet
time
#tree
unzip
usbutils
vconfig
wget
which
wireless-tools
#words
#ypbind
yum-langpacks
yum-presto
yum-utils
zip

# like @base-x
xorg-x11-server-Xorg
xorg-x11-xauth
xorg-x11-xinit
#desktop-backgrounds-basic
initial-setup
glx-utils
mesa-dri-drivers
mesa-libGL
mesa-libGLU
xorg-x11-drv-ati
xorg-x11-drv-dummy
xorg-x11-drv-evdev
xorg-x11-drv-fbdev
xorg-x11-drv-intel
xorg-x11-drv-mga
xorg-x11-drv-nouveau
xorg-x11-drv-openchrome
xorg-x11-drv-qxl
xorg-x11-drv-synaptics
xorg-x11-drv-vesa
xorg-x11-drv-vmmouse
xorg-x11-drv-vmware
xorg-x11-drv-void
xorg-x11-drv-wacom
xorg-x11-drv-v4l
xorg-x11-utils
xorg-x11-drivers
#xorg-x11-xkb-utils
#xorg-x11-apps

# like @core:
acl
attr
audit
basesystem
bash
biosdevname
binutils
coreutils
shadow-utils
cpio
cronie
cronie-anacron
dhclient
e2fsprogs
file
filesystem
glibc
hostname
initscripts
iproute
iptables
iputils
kbd
libgcc
#ncurses
#parted
passwd
#plymouth
#policycoreutils
procps
#readline
rfremix-release
rootfiles
rpm
rpmfusion-free-release
rpmfusion-nonfree-release
rsyslog
russianfedora-fixes-release
russianfedora-free-release
russianfedora-nonfree-release
selinux-policy-targeted
setserial
setup
util-linux
#vim-minimal
yum
systemd
firewalld
firewall-config

# like @fonts
liberation-mono-fonts
liberation-sans-fonts
liberation-serif-fonts
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts

# Server packages
-@samba*
-cifs-utils*

# KDE base
kdm
## this packages for choice the dependence with less package size
sane-backends-libs
phonon-backend-gstreamer
##
kde-workspace
konsole
apper
qtcurve-kde4

# apps
k3b
mc
htop
fpaste
system-config-firewall
system-config-firewall-base
kde-partitionmanager
network-manager-applet
psi-plus
psi-plus-themes

# Size removals
-@system-tools
-syslog-ng*
-plymouth*
-libreoffice*
-eclipse*
-mythes*
-sendmail
-gimp
-gimp-help
-java-*
-astronomy-bookmarks
-generic*
-btanks*
-libgcj-src
-frysk
-*gcj*
-PackageKit-yum-plugin
-zif
-kde-plasma-networkmanagement*
-gnome-packagekit
-gdisk
-digikam*
-libgphoto2
-amarok*
-kde-baseapps*
-kdepim*
-kdemultimedia*
-kdegames*
-kdegraphics*
-kdeaccessibility*
#-kactivities*
-kdeartwork*
-kdenetwork*
-pykde4-akonadi*
-*akonadi*
-virtuoso*
-marble*
-samba*
-libsmbclient
-abrt*
-festival*
-openldap*
-krusader*
-BackupPC*
-kcalc*
-obexd
-*obex*
-obex-data-server
-kolourpaint*
-kipi-plugins*
-libkipi
-kwrite*
-kamera
-kamoso
-atlas
-xterm
-nss*
-python-nss
-*jack*
-xscreensaver*
-btrfs-progs
-preupgrade
-ktp-*
-telepathy-*
-konversation
-cryptsetup*
-lvm2*
-smolt*
-google*
-cyrus*
-ftp
-mcelog
-rdesktop
-meanwhile
-dirac-libs*
-fcoe-utils
-json*
-cln
-polkit-qt
-scribus-*
-vim-*
-ktorrent*
-ghostscript*
-zsh
-dejavu-*
-gstreamer-plugins-bad-free
-echo-icon-theme
-ORBit2
-NetworkManager-openconnect
-gsettings-desktop-schemas
-ntsysv
-lcms
-pinfo
-selinux-policy-devel
-policycoreutils-python
-policycoreutils-sandbox
-openssh-server
-python-IPy
-foo2xqx
-foo2hp
-foo2qpdl
-foo2lava
-foo2hiperc
-foo2slx
-foo2zjs
-smartmontools
-paratype-pt-sans-fonts
-screen
-sssd-*
-c-ares
-avahi
-nmap
-trousers
-sane-backends-drivers-*
-sane-backends
-phonon-backend-vlc
-vlc-core
-tigervnc-server-*
-gstreamer-plugins-bad*

-fuse-encfs
-tcplay
-realcrypt
-reiserfs-utils
%end

%post

# set NetworkManager-gnome applet autorun
mkdir -p /etc/skel/.kde/Autostart
ln -s /usr/bin/nm-applet /etc/skel/.kde/Autostart

# set qtcurve widgetstyle & colorscheme
mkdir -p /etc/skel/.kde/share/config/
CFG_FILE='/etc/skel/.kde/share/config/kdeglobals'
touch $CFG_FILE
cat > $CFG_FILE << MENU_EOF
[General]
ColorScheme=QtCurve
XftAntialias=true
XftHintStyle=hintfull
XftSubPixel=rgb
desktopFont=Liberation Mono,10,-1,5,50,0,0,0,0,0
fixed=Liberation Mono,10,-1,5,50,0,0,0,0,0
font=Liberation Mono,10,-1,5,50,0,0,0,0,0
menuFont=Liberation Mono,10,-1,5,50,0,0,0,0,0
shadeSortColumn=true
smallestReadableFont=Liberation Mono,8,-1,5,50,0,0,0,0,0
taskbarFont=Liberation Mono,9,-1,5,50,0,0,0,0,0
toolBarFont=Liberation Mono,10,-1,5,50,0,0,0,0,0
widgetStyle=qtcurve

[WM]
activeFont=Liberation Mono,9,-1,5,50,1,0,0,0,0
MENU_EOF

# set kwin3 style
CFG_FILE='/etc/skel/.kde/share/config/kwinrc'
touch $CFG_FILE
cat > $CFG_FILE << MENU_EOF
[Style]
PluginLib=kwin3_qtcurve
MENU_EOF

# Disable nepomuk
touch '/etc/skel/.kde/share/config/nepomukserverrc'
cat > /etc/skel/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

# Set akonadi backend & not autostart
mkdir -p /etc/skel/.config/akonadi
cat > /etc/skel/.config/akonadi/akonadiserverrc << AKONADI_EOF
[%General]
Driver=QSQLITE3

[QMYSQL]
StartServer=false
AKONADI_EOF

# disable Zeitgeist autostart
ZGFile="/etc/xdg/autostart/zeitgeist-datahub.desktop"
if [ -f $ZGFile ] ; then
    mv  $(ZGFile) $(ZGFile)".saved"
fi

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDE"
EOF

# make oxygen-gtk the default GTK+ theme for root (see #683855, #689070, #808062)
cat > /root/.gtkrc-2.0 << EOF
include "/usr/share/themes/oxygen-gtk/gtk-2.0/gtkrc"
include "/etc/gtk-2.0/gtkrc"
gtk-theme-name="oxygen-gtk"
EOF
mkdir -p /root/.config/gtk-3.0
cat > /root/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name = oxygen-gtk
EOF

# add initscript
cat >> /etc/rc.d/init.d/livesys << EOF

# set system keymaps
localectl set-x11-keymap us,ru pc105 , grp:alt_shift_toggle

if [ -e /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png ] ; then
    # use image also for kdm
    mkdir -p /usr/share/apps/kdm/faces
    cp /usr/share/icons/hicolor/96x96/apps/fedora-logo-icon.png /usr/share/apps/kdm/faces/fedora.face.icon
fi

# make liveuser use KDE
echo "startkde" > /home/liveuser/.xsession
chmod a+x /home/liveuser/.xsession
chown liveuser:liveuser /home/liveuser/.xsession

# set up autologin for user liveuser
sed -i 's/#AutoLoginEnable=true/AutoLoginEnable=true/' /etc/kde/kdm/kdmrc
sed -i 's/#AutoLoginUser=fred/AutoLoginUser=liveuser/' /etc/kde/kdm/kdmrc

# set up user liveuser as default user and preselected user
sed -i 's/#PreselectUser=Default/PreselectUser=Default/' /etc/kde/kdm/kdmrc
sed -i 's/#DefaultUser=johndoe/DefaultUser=liveuser/' /etc/kde/kdm/kdmrc

# add liveinst.desktop to favorites menu
mkdir -p /home/liveuser/.kde/share/config/
cat > /home/liveuser/.kde/share/config/kickoffrc << MENU_EOF
[Favorites]
FavoriteURLs=/usr/share/applications/kde4/konqbrowser.desktop,/usr/share/applications/kde4/dolphin.desktop,/usr/share/applications/kde4/systemsettings.desktop,/usr/share/applications/liveinst.desktop
MENU_EOF

# show liveinst.desktop on desktop and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# chmod +x ~/Desktop/liveinst.desktop to disable KDE's security warning
chmod +x /usr/share/applications/liveinst.desktop

# copy over the icons for liveinst to hicolor
cp /usr/share/icons/gnome/16x16/apps/system-software-install.png /usr/share/icons/hicolor/16x16/apps/
cp /usr/share/icons/gnome/22x22/apps/system-software-install.png /usr/share/icons/hicolor/22x22/apps/
cp /usr/share/icons/gnome/24x24/apps/system-software-install.png /usr/share/icons/hicolor/24x24/apps/
cp /usr/share/icons/gnome/32x32/apps/system-software-install.png /usr/share/icons/hicolor/32x32/apps/
cp /usr/share/icons/gnome/48x48/apps/system-software-install.png /usr/share/icons/hicolor/48x48/apps/
cp /usr/share/icons/gnome/256x256/apps/system-software-install.png /usr/share/icons/hicolor/256x256/apps/
touch /usr/share/icons/hicolor/

# Disable the update notifications of apper
cat > /home/liveuser/.kde/share/config/apper << APPER_EOF
[CheckUpdate]
autoUpdate=0
interval=0
APPER_EOF

# Disable kres-migrator
cat > /home/liveuser/.kde/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

# don't use prelink on a running KDE live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink

# small hack to enable plasma-netbook workspace on boot
if strstr "\`cat /proc/cmdline\`" netbook ; then
   mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
   sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop
fi
EOF

%end
