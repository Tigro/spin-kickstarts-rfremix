# rfremix-livecd-mate.ks
#
# Description:
# - RFRemix Live Spin with the Mate Desktop Environment
#
# Maintainer(s):
# - Arkady L. Shane   <ashejn@russianfedora.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages

@cinnamon-desktop
@firefox
@libreoffice

# system tools
system-config-printer
system-config-printer-applet

# dictionaries are big
-aspell-*
#-man-pages-*

# more fun with space saving
-gimp-help
# not needed, but as long as there is space left, we leave this in
#-desktop-backgrounds-basic

# save some space
-autofs
-acpid

# drop some system-config things
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

# some stuff

thunderbird
pidgin
remmina
remmina-plugins-vnc
transmission

# multimedia
cheese
pavucontrol

# System
gparted

# system
dconf-editor

%end

%post

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/cinnamon-session
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF

# disable screensaver locking
#cat > /usr/share/glib-2.0/schemas/org.mate.lockdown.gschema.override <<FOE
#[org.mate.lockdown]
#disable-lock-screen=true
#FOE

#cat > /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override <<FOE
#[org.gnome.desktop.lockdown]
#disable-lock-screen=true
#FOE

#cat > /usr/share/glib-2.0/schemas/org.mate.screensaver.gschema.override <<FOE
#[org.mate.screensaver]
#lock-enabled=false
#FOE

# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
#sed -i 's/^#show-language-selector=.*/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf
# set Xfce as default session, otherwise login will fail
sed -i 's/^#user-session=.*/user-session=mate/' /etc/lightdm/lightdm.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

