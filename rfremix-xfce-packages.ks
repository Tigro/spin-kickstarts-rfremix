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


%packages

@networkmanager-submodules
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media
@firefox
@libreoffice

# unlock default keyring. FIXME: Should probably be done in comps
gnome-keyring-pam

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this
-aspell-*                   # dictionaries are big
-gnumeric
-stix-fonts
-ibus-typing-booster
#-man-pages-*
-adobe-source-han-* # save 94MB
-rodent-icon-theme  # save 34MB
-skkdic             # save 25MB
-naver-nanum-gothic-fonts # save 14MB

# drop some system-config things
-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui

# some stuff

thunderbird
liferea
pidgin
remmina
remmina-plugins-vnc
transmission

# multimedia
cheese
pavucontrol

# System
gparted

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
xfce4-screenshooter-plugin
xfce4-sensors-plugin
xfce4-smartbookmark-plugin
xfce4-systemload-plugin
xfce4-taskmanager
xfce4-time-out-plugin
xfce4-timer-plugin
xfce4-verve-plugin
xfce4-weather-plugin
xfce4-xkb-plugin

%end


