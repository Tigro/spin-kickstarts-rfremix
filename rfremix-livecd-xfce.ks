# rfremix-livecd-xfce.ks
#
# Description:
# - RFRemix Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <chris@christoph-wickert.de>
# - Kevin Fenzi       <kevin@tummy.com>
# - Arkady L. Shane   <ashejn@yandex-team.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages
firefox
NetworkManager-gnome
nss-mdns
claws-mail

# we don't include @office so that we don't get OOo.  but some nice bits
abiword
gnumeric
evince-djvu
-evince-dvi
galculator
-qutim*

# development
geany

# More Desktop stuff
transmission
remmina
exaile
florence
gnome-bluetooth
gnome-power-manager
gparted
libdvdcss
liferea
pidgin
ristretto
seahorse
stardict
totem-mozplugin
xdg-user-dirs
xscreensaver

# multimedia
alsa-plugins-pulseaudio
asunder
cheese
easytag
flash-plugin
gmixer
gstreamer-plugins-ugly
quodlibet
pavucontrol
parole
parole-mozplugin
xfburn
xine-lib-extras-freeworld

# Command line
ntfs-3g
powertop

# xfce packages
@xfce-desktop
Terminal
gtk-xfce-engine
orage
ristretto
hal-storage-addon
thunar-volman
thunar-media-tags-plugin
gigolo
xarchiver
xfce4-battery-plugin
# we already have thunar-volman
#xfce4-cddrive-plugin
xfce4-cellmodem-plugin
xfce4-clipman-plugin
xfce4-cpugraph-plugin
xfce4-datetime-plugin
xfce4-dict-plugin
xfce4-diskperf-plugin
xfce4-eyes-plugin
xfce4-fsguard-plugin
xfce4-genmon-plugin
xfce4-mailwatch-plugin
xfce4-mount-plugin
xfce4-netload-plugin
xfce4-notes-plugin
xfce4-places-plugin
xfce4-power-manager
xfce4-quicklauncher-plugin
xfce4-remmina-plugin
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-smartbookmark-plugin
xfce4-stopwatch-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
xfce4-volstatus-icon
# we already have nm-applet
#xfce4-wavelan-plugin
xfce4-weather-plugin
xfce4-websearch-plugin
# this one a compatibility layer for GNOME applets and depends on it
#xfce4-xfapplet-plugin
xfce4-xfswitch-plugin
xfce4-xkb-plugin
# system-config-printer does printer management better
#xfprint
xfwm4-themes

# more fun with space saving
-gimp-help

# save some space
-autofs
-nss_db
-acpid

-java-1.6.0-openjdk*
# drop some system-config things
-system-config-boot
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
EOF

mkdir -p /root/.config/xfce4

cat > /root/.config/xfce4/helpers.rc <<EOF
MailReader=sylpheed-claws
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

mkdir -p /home/liveuser/.config/xfce4

cat > /home/liveuser/.config/xfce4/helpers.rc << FOE
MailReader=sylpheed-claws
FOE

# disable screensaver locking
cat >> /home/liveuser/.xscreensaver << FOE
lock:   False
FOE
# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=20
FOE

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

EOF

%end

