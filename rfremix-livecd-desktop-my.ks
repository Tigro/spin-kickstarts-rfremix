# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:fedora-desktop-list@redhat.com

%include rfremix-live-base.ks

repo --name=tigro-repo --mirrorlist=http://russianfedora.tigro.info/13/.mirrorlist-tigro-$basearch
repo --name=chromium --baseurl=http://repos.fedorapeople.org/repos/spot/chromium/fedora-13/$basearch/
part / --size 6096 --fstype ext4

%packages
@games
@graphical-internet
@graphics
@sound-and-video
@gnome-desktop
@office
nss-mdns
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-openconnect

gimp
gthumb
evince-djvu
-evince-dvi

vim-enhanced
tigervnc

# new programs
easytag
stardict
stardict-dic-en-ru
stardict-dic-ru-en
stardict-dic-big-soviet-encyclopedia
stardict-dic-rus-explanatory
brasero
flash-plugin
liferea
gparted
-qutim*
gajim
avidemux-gtk
avidemux-plugins
deluge
exaile
-transmission
skype
shutter
revelation
htop
goldendict
wine
chromium
opera

# multimedia
gstreamer-plugins-ugly
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-nonfree
gstreamer-ffmpeg
xine-lib
xine-lib-extras-freeworld
libdvdcss
vlc
mplayer
mencoder
alacarte

# dictionaries are big
man-pages
man-pages-ru
-words

# save some space
-gnome-user-docs
-gimp-data-extras
-gimp-help
-gimp-help-browser
-evolution-help
-gnome-games
-gnome-games-help
-nss_db
vino
-isdn4k-utils
-dasher
-*amule*
-foo2*

-gok
-orca
-festival
-gnome-speech
-festvox-slt-arctic-hts

# not needed for gnome
-acpid

# these pull in excessive dependencies
tomboy
f-spot
banshee

# Russian Fedora 
nautilus-sound-converter
nautilus-image-converter
nautilus-sendto
empathy
pidgin
java-1.6.0-openjdk-plugin
mesa-dri-drivers-experimental
kmod-open-vm-tools

%end

%post
# apply new gnome configs
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/nautilus/preferences/always_use_browser true
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-terminal/global/use_menu_accelerators false
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /desktop/gnome/interface/toolbar_style "both-horiz"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t list --list-type=string /apps/gedit-2/preferences/encodings/auto_detected "[UTF-8,CURRENT,WINDOWS-1251,KOI8R,ISO-8859-5]"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/gnome/interface/menus_have_icons true
#gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/bluetooth-manager/show_icon false

# Do not show gnome-packagekit in KDE
sed -i '/Categories/ a NotShowIn=KDE;' /etc/xdg/autostart/gpk-update-icon.desktop

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
TimedLoginDelay=10
FOE

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

EOF

%end
