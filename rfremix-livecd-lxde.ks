# fedora-livecd-lxde.ks
#
# Description:
# - Fedora Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Christoph Wickert <cwickert@fedoraproject.org>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages
### LXDE desktop
@lxde-desktop
lxlauncher
obconf
gdm

### internet
firefox
icedtea-web
pidgin
thunderbird
transmission

### office
@office

### graphics
epdfview
-evince
mtpaint

### audio & video
alsa-plugins-pulseaudio
asunder
lxmusic
gxine
gxine-mozplugin
pavucontrol
# I'm looking for something smaller than
gnomebaker

### utils
galculator
parcellite
xpad

### system
gigolo

### more desktop stuff
# default artwork, subject to change - cwickert 2011-03-05
fedora-icon-theme

# needed for automatic unlocking of keyring (#643435)
gnome-keyring-pam

hal-storage-addon
NetworkManager-gnome

# needed for xdg-open to support LXDE
perl-File-MimeInfo

xcompmgr
xdg-user-dirs-gtk

gsmartcontrol

# use yumex instead of gnome-packagekit
yumex
-gnome-packagekit
-kpackagekit

# LXDE has lxpolkit. Make sure no other authentication agents end up in the spin.
-polkit-gnome
-polkit-kde

# make sure xfce4-notifyd is not pulled in
notification-daemon
-xfce4-notifyd

# make sure xfwm4 is not pulled in for firstboot
# https://bugzilla.redhat.com/show_bug.cgi?id=643416
metacity

# Command line
powertop
wget
yum-utils
yum-presto

# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# save some space
-nss_db
-sendmail
ssmtp
-acpid

# drop some system-config things
-system-config-boot
#-system-config-language
-system-config-lvm
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui
-gnome-disk-utility

%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF

# GDM configuration
cat >> /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startlxde
EOF

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

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# Add autostart for parcellite
cp /usr/share/applications/fedora-parcellite.desktop /etc/xdg/autostart

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

