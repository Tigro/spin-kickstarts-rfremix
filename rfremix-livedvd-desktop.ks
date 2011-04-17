# rfremix-livedvd-desktop.ks
#
# Description:
# - RFRemix Live DVD Spin with KDE
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@yandex-team.ru>

%include rfremix-live-desktop.ks
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
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-terminal/global/use_menu_accelerators false

cat >> /etc/rc.d/init.d/livesys << EOF

# Disable the update notifications of kpackagekit
cat > /home/liveuser/.kde/share/config/KPackageKit << KPACKAGEKIT_EOF
[CheckUpdate]
autoUpdate=0
interval=0

[Notify]
notifyLongTasks=2
notifyUpdates=0
KPACKAGEKIT_EOF

# Disable kres-migrator
cat > /home/liveuser/.kde/share/config/kres-migratorrc << KRES_EOF
[Migration]
Enabled=false
KRES_EOF

# Disable nepomuk
cat > /home/liveuser/.kde/share/config/nepomukserverrc << NEPOMUK_EOF
[Basic Settings]
Start Nepomuk=false

[Service-nepomukstrigiservice]
autostart=false
NEPOMUK_EOF

# don't use prelink on a running KDE live image
sed -i 's/PRELINKING=yes/PRELINKING=no/' /etc/sysconfig/prelink

# small hack to enable plasma-netbook workspace on boot
if strstr "\`cat /proc/cmdline\`" netbook ; then
   mv /usr/share/autostart/plasma-desktop.desktop /usr/share/autostart/plasma-netbook.desktop
   sed -i 's/desktop/netbook/g' /usr/share/autostart/plasma-netbook.desktop
fi

# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile lxde
@pulseaudio -D
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE
[Preferred Applications]
WebBrowser=mozilla-firefox.desktop
MailClient=mozilla-thunderbird.desktop
FOE

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=thunderbird
FileManager=Thunar
FOE

# deactivate xfconf-migration (#683161)
rm -f /etc/xdg/autostart/xfconf-migration-4.6.desktop || :

# deactivate xfce4-panel first-run dialog (#693569)
mkdir -p /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml
cp /etc/xdg/xfce4/panel/default.xml /home/liveuser/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

# change icon theme to gnome
sed -i '/IconThemeName/ s!Fedora!gnome!g' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
# hint style slight
sed -i '/HintStyle/ s!hintfull!hintslight!g' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end
