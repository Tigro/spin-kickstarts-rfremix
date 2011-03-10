# rfremix-livedvd-desktop.ks
#
# Description:
# - RFRemix Live DVD Spin with KDE
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@yandex-team.ru>

%include rfremix-live-base.ks

part / --size 6096 --fstype ext4

%packages
@games
@graphical-internet
@graphics
@sound-and-video
qmmp-plugins-freeworld
@gnome-desktop
@kde-desktop
kdebase-runtime-flags
@xfce-desktop
@lxde-desktop
@java
nss-mdns
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-pptp

# Office support
inkscape
istanbul
sK1
@office

# avoid weird case where we pull in more festival stuff than we need
festival
festvox-slt-arctic-hts

# save some space
-gnome-user-docs
-gimp-help
-gimp-help-browser
-evolution-help
-gnome-games
-gnome-games-help
-nss_db
-vino
-isdn4k-utils
-dasher
evince-dvi
evince-djvu
acpid

# these pull in excessive dependencies
ekiga
tomboy
f-spot
banshee

# multimedia support
mplayer
mencoder
ffmpeg
lame
k3b-extras-freeworld
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

# Russian Fedora
easytag
liferea
gajim
-stardict*
libdvdcss
transmission
wxMaxima
thunderbird
vim-enhanced
flash-plugin
-opera

# Other
kde-partitionmanager
gparted
florence
gxneur
metromap
rdesktop
fbreader
midori
arora
btanks
frozen-bubble

nautilus-sound-converter
nautilus-image-converter
nautilus-sendto
empathy
-pidgin
soundconverter
thoggen
liveusb-creator

%end

%post
# apply new gnome configs
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/nautilus/preferences/always_use_browser true
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-terminal/global/use_menu_accelerators false
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /desktop/gnome/interface/toolbar_style "both-horiz"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t list --list-type=string /apps/gedit-2/preferences/encodings/auto_detected "[UTF-8,CURRENT,WINDOWS-1251,KOI8R,ISO-8859-5]"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/gnome/interface/menus_have_icons true
#gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/bluetooth-manager/show_icon false

# mount all partitions by default
#if [ -f /usr/bin/polkit-action ]; then
#    /usr/bin/polkit-action --set-defaults-active \
#        org.freedesktop.hal.storage.mount-fixed yes
#fi

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=20
FOE

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

# make sure to set the right permissions
chown -R liveuser:liveuser /home/liveuser/.kde

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

EOF

%end
