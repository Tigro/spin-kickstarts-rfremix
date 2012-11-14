# fedora-livecd-xfce.ks
#
# Description:
# - Fedora Live Spin with the light-weight XFCE Desktop Environment
#
# Maintainer(s):
# - Rahul Sundaram    <sundaram@fedoraproject.org>
# - Christoph Wickert <cwickert@fedoraproject.org>
# - Kevin Fenzi       <kevin@tummy.com>
# - Adam Miller       <maxamillion@fedoraproject.org>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages

@mate-desktop
@firefox
@libreoffice

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
-system-config-boot
-system-config-lvm
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

# java plugin
icedtea-web

%end

%post
# xfce configuration

# create /etc/sysconfig/desktop (needed for installation)

cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startxfce4
DISPLAYMANAGER=/usr/sbin/lightdm
EOF

# do not use menu accelerators in gnome terminal
mateconftool-2 --direct --config-source=xml:readwrite:/etc/mateconf/mateconf.xml.defaults -s -t bool /apps/mate-terminal/global/use_menu_accelerators false
# menu have icons
mateconftool-2 --direct --config-source=xml:readwrite:/etc/mateconf/mateconf.xml.defaults -s -t bool /desktop/mate/interface/menus_have_icons true

# set up themes
cat > /usr/share/glib-2.0/schemas/org.mate.interface.gschema.override <<EOF
[org.mate.interface]
gtk-theme="Adwaita"
icon-theme="gnome"
EOF

cat > /usr/share/glib-2.0/schemas/org.mate.marco.gschema.override <<EOF
[org.mate.Marco.general]
theme="Adwaita"
EOF


cat >> /etc/rc.d/init.d/livesys << EOF

# disable screensaver locking
cat > /usr/share/glib-2.0/schemas/org.mate.lockdown.gschema.override <<EOF
[org.mate.lockdown]
disable-lock-screen=true
EOF

cat > /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override <<EOF
[org.gnome.desktop.lockdown]
disable-lock-screen=true
EOF

cat > /usr/share/glib-2.0/schemas/org.mate.screensaver.gschema.override <<EOF
[org.mate.screensaver]
lock-enabled=false
EOF

# But not trash and home
cat > /usr/share/glib-2.0/schemas/org.mate.caja.gschema.override << EOF
[org.mate.caja.desktop]
trash-icon-visible=false
home-icon-visible=false
EOF

# set up lightdm autologin
sed -i 's/^#autologin-user=/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=0/autologin-user-timeout=30/' /etc/lightdm/lightdm.conf
sed -i 's/^#show-language-selector=false/show-language-selector=true/' /etc/lightdm/lightdm-gtk-greeter.conf

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop/

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

