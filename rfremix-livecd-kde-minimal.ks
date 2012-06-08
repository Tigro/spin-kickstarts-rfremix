# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (@base is added by default unless you add --nobase to %packages)
# (default groups for the configured repos are added by --default)

%include rfremix-live-mini.ks
%include rfremix-live-minimization.ks

%packages --default
# core
kernel
-kernel*debug*
-kernel-kdump*
-kernel-*PAE*
-kernel*devel*
-kernel-headers*
-kernel-doc*
-kernel-tools*
-syslog-ng*
-plymouth*

# grub-efi and grub2 and efibootmgr so anaconda can use the right one on install. 
grub-efi
grub2
efibootmgr

# mactel-boot needs to be on the DVD for successful installation to intel macs.
-mactel-boot

# Desktop Packages
@dial-up

# Devel packages

# Server packages
#@network-server
#@server-cfg
-@samba*
-cifs-utils*
# Keep dap off the install media, makes Eng & Sci show up
-dap-server-cgi
#  groups
-@MySQL*

# Things needed for installation
@anaconda-tools

# Languages
@russian-support
# Langpacks
aspell-ru*
autocorr-ru*
man-pages
man-pages-ru
hunspell-ru*
hyphen-ru*

# KDE
kdm
kde-workspace
kde-l10n-*ru*
kde-i18n-*ru*
apper
qtcurve-kde4

# apps
k3b
@system-tools
mc
htop
konsole
fpaste
wget
system-config-firewall
system-config-network
system-config-firewall-base
grub-customizer
gnome-disk-utility
NetworkManager-gnome
psi-plus*

# Size removals
-libreoffice*
-eclipse*
-mythes*
-sendmail
-gimp
-gimp-help
-java-1.6.0-openjdk-src
-java-1.5.0-gcj-devel
-java-1.5.0-gcj-javadoc
-xorg-x11-docs
-java-1.5.0-gcj-src
-astronomy-bookmarks
-generic*
-btanks*
-*GConf2-*
-bluez-gnome
-libgcj-src
-frysk
-*gcj*
-PackageKit*
-zif
-kde-plasma-networkmanagement*
-gnome-packagekit
-gdisk
-gtkam
-digikam*
-libgphoto2
-avahi-autoipd
-tigervnc*
-amarok*
-kde-baseapps*
-kdepim*
-kdemultimedia*
-kdegames*
-kdegraphics*
-kdeaccessibility*
-kactivities*
-kdeartwork*
-kdenetwork*
-pykde4-akonadi*
-*akonadi*
-virtuoso*
-marble*
-samba*
-libsmbclient
-abrt*
-*mysql*
-qt-mysql*
-*MySQL*
-festival*
-kmod*
-openldap*
-krusader*
-BackupPC*
-kcalc*
-strigi-libs
-*strigi*
-oxygen-icon-theme
-gnome-icon-theme
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
-vlc*
-phonon-backend-vlc
-*nepomuk*
-*jack*
-xscreensaver*
-sane-*
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
-dhclient
-dhcp*
-meanwhile
-dirac-libs*
-redland*
-fcoe-utils
-json*
-cln
-polkit-qt
-scribus-*
-vim-*
-llvm-libs*
-ktorrent*
-slang
-ghostscript*
-zsh
-dejavu-*
-authconfig-gtk
-gstreamer-plugins-bad-free
-echo-icon-theme
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
widgetStyle=qtcurve
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
