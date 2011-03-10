# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:fedora-desktop-list@redhat.com

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

%packages
@graphical-internet
@sound-and-video
@gnome-desktop
nss-mdns
NetworkManager-vpnc
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-openconnect
-evince-djvu
-evince-dvi

# new programs
easytag
-stardict
brasero
flash-plugin
-liferea
gparted
-qutim*

# multimedia
gstreamer-plugins-ugly
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-nonfree
gstreamer-ffmpeg
libdvdcss
-xine-lib
-xine-lib-extras-freeworld
-vlc
-mplayer

# dictionaries are big
-man-pages-*
-words

# Help and art can be big, too
-gnome-user-docs
-evolution-help
-gnome-games-help
-desktop-backgrounds-basic
-*backgrounds-extras
-gnome-backgrounds

# Legacy cmdline things we don't want
-nss_db
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-nano
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-telnet
-ypbind
-yp-tools
-rpcbind

# Drop some system-config things
-system-config-boot
-system-config-network
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

# save some space
-gnome-games
-gnome-games-help
-nss_db
-isdn4k-utils
-dasher
-*amule*
-foo2*

-gok
-orca
-festival
-gnome-speech
-festvox-slt-arctic-hts

# Russian Fedora 
nautilus-sound-converter
nautilus-image-converter
nautilus-sendto
empathy
-pidgin

# Temporary list of things removed from comps but not synced yet
-specspo

# Drop the Java plugin
-java-1.6.0-openjdk-plugin
-java-1.6.0-openjdk

# Drop things that pull in perl
-linux-atm
-perf

# Opera contains some 32bit libraries, so
# it is not possible to add it into 64bit
# livecd
-opera

# This one needs to be kicked out of @base
-smartmontools

%end

%post
# apply new gnome configs
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/nautilus/preferences/always_use_browser true
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-terminal/global/use_menu_accelerators false
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t string /desktop/gnome/interface/toolbar_style "both-horiz"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t list --list-type=string /apps/gedit-2/preferences/encodings/auto_detected "[UTF-8,CURRENT,WINDOWS-1251,KOI8R,ISO-8859-5]"
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/gnome/interface/menus_have_icons true

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/gnome-screensaver/lock_enabled false >/dev/null
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /desktop/gnome/lockdown/disable_lock_screen true >/dev/null
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
chown -R liveuser.liveuser /home/liveuser/Desktop
chmod a+x /home/liveuser/Desktop/liveinst.desktop

# But not trash and home
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/nautilus/desktop/trash_icon_visible false >/dev/null
gconftool-2 --direct --config-source=xml:readwrite:/etc/gconf/gconf.xml.defaults -s -t bool /apps/nautilus/desktop/home_icon_visible false >/dev/null

# Turn off PackageKit-command-not-found while uninstalled
sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf

# turn off rfremixconf script
chkconfig --level 345 rfremixconf off 2>/dev/null

EOF

%end
