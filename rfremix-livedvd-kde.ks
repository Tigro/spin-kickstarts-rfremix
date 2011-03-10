# rfremix-livecd-kde.ks
#
# Description:
# - RFRemix Live Spin with GNOME, KDE, XFCE and LXDE
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@yandex-team.ru>

%include rfremix-live-base.ks

part / --size 5096 --fstype ext4

%packages

# make kpackagekit the default on the kde live images
kpackagekit
-gnome-packagekit

# use system-config-printer-kde instead of system-config-printer
-system-config-printer
system-config-printer-kde

# make sure /usr/bin/pactl is there (#466544)
pulseaudio-utils

# make sure alsaunmute is there
alsa-utils

### The KDE-Desktop

@kde-desktop

# new applications
flash-plugin
goldendict
libdvdcss
-NetworkManager-gnome
xine-lib-extras-freeworld
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-base
gstreamer-plugins-espeak
gstreamer-plugins-fc
gstreamer-plugins-flumpegdemux
gstreamer-plugins-good
gstreamer-plugins-ugly
qmmp-plugins-freeworld
@java

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd

digikam
kaffeine 		### kaffeine has duplicate functionality with dragonplayer (~3 megs)
kdeartwork 		### kdeartwork is not really needed
kdeartwork-screensavers
kdeedu
kdegames 		### the removal of kdegames will free ~35 megs
kdeplasma-addons
kipi-plugins
ktorrent 		### kget has also basic torrent features (~3 megs)
scribus		### scribus is too big for the live images
-xscreensaver-gl-extras

# Other applications
koffice-filters
koffice-karbon
koffice-kchart
koffice-kplato
koffice-kpresenter
koffice-krita
koffice-kspread
koffice-kword
@office

# Useful additional KDE3 applications
amarok
arora
avidemux-qt
avidemux-plugins
compiz-kde
djview4
filelight
fwbuilder
k3b
k3b-extras-freeworld
k9copy
kchmviewer
kdenlive
kdiff3
keepassx
kmediafactory
knemo
kopete-cryptography
kphotoalbum
kplayer
kradio4
krusader
kopete-cryptography
kvirc
kvkbd
lastfm
lmms
psi-plus
psimedia
qtcurve-kde4
smb4k
tellico
twinkle
vlc
phonon-backend-vlc
kde-partitionmanager
transmission-qt

# some extras
fuse
liveusb-creator

# FIXME/TODO: recheck the removals here
# try to remove some packages from russianfedora-live-base.ks
-gdm
-authconfig-gtk

# save some space (from @base)
-autofs
%end

%post

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
DESKTOP="KDE"
DISPLAYMANAGER="KDE"
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

# show liveinst.desktop on and in menu
sed -i 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

# Disable the update notifications of kpackagekit
cat > /home/liveuser/.kde/share/config/KPackageKit << KPACKAGEKIT_EOF
[CheckUpdate]
autoUpdate=0
interval=0

[Notify]
notifyLongTasks=2
notifyUpdates=0
KPACKAGEKIT_EOF

# Disable nepomuk
cat > /home/liveuser/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

# make sure to set the right permissions
chown -R liveuser:liveuser /home/liveuser/.kde/

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

# mount all partitions by default
#if [ -f /usr/bin/polkit-action ]; then
#    /usr/bin/polkit-action --set-defaults-active \
#        org.freedesktop.hal.storage.mount-fixed yes
#fi

# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
    if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
	sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
    fi
fi

EOF

%end
