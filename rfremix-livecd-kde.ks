# rfremix-livecd-kde.ks
#
# Description:
# - RFRemix Live Spin with the K Desktop Environment (KDE)
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@yandex-team.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

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
kde-partitionmanager
xine-lib-extras-freeworld
gstreamer-plugins-ugly

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd

-amarok*		# amarok has duplicate functionality with juk (~13 megs)
-desktop-backgrounds-basic
-digikam		# digikam has duplicate functionality with gwenview (~11 megs)
-kaffeine* 		### kaffeine has duplicate functionality with dragonplayer (~3 megs)
-kdeedu*
-kdegames* 		### the removal of kdegames will free ~35 megs
-kdeplasma-addons
-kipi-plugins
-ktorrent
-scribus		### scribus is too big for the live images
-xscreensaver-gl-extras

filelight
fpaste
-k3b*

# twinkle (~10 megs)
-twinkle

# some extras
fuse
liveusb-creator

# FIXME/TODO: recheck the removals here
# try to remove some packages from russianfedora-live-base.ks
-gdm
-authconfig-gtk

# save some space (from @base)
-autofs
-foo2*
-gstreamer-plugins-base
-java-1.6.0-openjdk*
-lftp
-liberation*
-make
-man-pages
-mplayer
-pavucontrol		### we do not need it in KDE
-stardict*
-stix-fonts
-vlc
-words
-konversation
-konq-plugins

# remove input methods to free space
-scim*
-m17n*
-ibus*

# save some space (from @base)
-make
-nss_db

## avoid serious bugs by omitting broken stuff
# fprintd-pam related crashes in kdm (http://bugzilla.redhat.com/605156) 
-fprintd-pam

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

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
	if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
		sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
	fi
fi

EOF

%end
