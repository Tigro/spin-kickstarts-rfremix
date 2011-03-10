# fedora-livecd-lxde.ks
#
# Description:
# - RFRemix Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Arkady L. Shane   <ashejn@yandex-team.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages
# LXDE desktop
@lxde-desktop
lxlauncher
obconf
gdm

# internet
firefox
sylpheed
lostirc
transmission
liferea
pidgin

abiword
gnumeric
osmo
inkscape

# graphics
epdfview
mtpaint

# audio & video
gmixer
lxmusic
asunder
totem
totem-mozplugin
gstreamer-plugins-ugly
flash-plugin

# I'm looking for something smaller than
gnomebaker

# utils
galculator
parcellite
xpad

# system
gigolo

# more Desktop stuff
hal-storage-addon
alsa-plugins-pulseaudio
NetworkManager-gnome
xcompmgr
xdg-user-dirs-gtk
# needed for xdg-open to support LXDE
perl-File-MimeInfo
# pam-fprint causes a segfault in LXDM when enabled
-fprintd-pam
# needed for automatic unlocking of keyring (#643435)
gnome-keyring-pam

# make sure kpackagekit doesn't end up the LXDE live images
gnome-packagekit*
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

# save some space
-nss_db
-sendmail
ssmtp
-acpid

# No java
-java-1.6.0-openjdk*

# drop some system-config things
-system-config-boot
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

%end

%post
# LXDE configuration

# set up timed auto-login for after 60 seconds
cat >> /etc/gdm/custom.conf << FOE
[daemon]
TimedLoginEnable=true
TimedLogin=liveuser
TimedLoginDelay=20
FOE

cat >> /etc/rc.d/init.d/livesys << EOF
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
MailClient=redhat-sylpheed.desktop
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

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

EOF

%end

