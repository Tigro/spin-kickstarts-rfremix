# rfremix-livecd-lxde.ks
#
# Description:
# - RFRemix Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Arkady L. Shane   <ashejn@russianfedora.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks

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
-hunspell-*
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
%end

%post
# LXDE and LXDM configuration

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/usr/bin/startlxde
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
/usr/libexec/notification-daemon
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE
[Preferred Applications]
WebBrowser=firefox.desktop
MailClient=redhat-sylpheed.desktop
FOE

# set up auto-login for liveuser
sed -i 's|# autologin=dgod|autologin=liveuser|g' /etc/lxdm/lxdm.conf

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


#cat > /etc/skel/.config/pcmanfm/LXDE/pcmanfm.conf << EOF
#[config]
#bm_open_method=0
#su_cmd=
#
#[volume]
#mount_on_startup=1
#mount_removable=1
#autorun=1
#
#[desktop]
#wallpaper_mode=1
#wallpaper=/usr/share/backgrounds/beefy-miracle/default/standard/beefy-miracle.png
#desktop_bg=#2e3552
#desktop_fg=#ffffff
#desktop_shadow=#000000
#desktop_font=Sans 12
#show_menu=0
#
#[ui]
#always_show_tabs=0
#max_tab_chars=32
#win_width=946
#win_height=694
#splitter_pos=150
#side_pane_mode=1
#view_mode=0
#show_hidden=0
#sort_type=0
#sort_by=2
#EOF
