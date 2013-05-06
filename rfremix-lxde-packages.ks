# fedora-livecd-lxde.ks
#
# Description:
# - Fedora Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Christoph Wickert <cwickert@fedoraproject.org>

%packages
### LXDE desktop
@lxde-desktop
@lxde-apps
@lxde-media
osmo
@firefox

# pam-fprint causes a segfault in LXDM when enabled
-fprintd-pam


# LXDE has lxpolkit. Make sure no other authentication agents end up in the spin.
-polkit-gnome
-polkit-kde

# make sure xfce4-notifyd is not pulled in
notification-daemon
-xfce4-notifyd

# make sure xfwm4 is not pulled in for firstboot
# https://bugzilla.redhat.com/show_bug.cgi?id=643416
metacity


# dictionaries are big
-aspell-*
-man-pages-*
-words

# save some space
-sendmail
ssmtp
-acpid

# drop some system-config things
-system-config-boot
#-system-config-language
-system-config-lvm
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui
-gnome-disk-utility

# we need UPower for suspend and hibernate
upower

# some stuff
thunderbird
transmission

@libreoffice
pavucontrol

yumex

# Display Manager
lxdm

%end
