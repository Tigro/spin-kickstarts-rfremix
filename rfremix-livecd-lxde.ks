# rfremix-livecd-lxde.ks
#
# Description:
# - RFRemix Live Spin with the light-weight LXDE Desktop Environment
#
# Maintainer(s):
# - Arkady L. Shane   <ashejn@russianfedora.ru>

%include rfremix-live-base.ks
%include rfremix-live-minimization.ks
%include rfremix-lxde-packages.ks

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

# create default config for clipit, otherwise it displays a dialog on startup
mkdir -p /home/liveuser/.config/clipit
cat .config/clipit/clipitrc  << FOE
[rc]
use_copy=true
use_primary=false
synchronize=false
automatic_paste=false
show_indexes=false
save_uris=true
use_rmb_menu=false
save_history=false
history_limit=50
items_menu=20
statics_show=true
statics_items=10
hyperlinks_only=false
confirm_clear=false
single_line=true
reverse_history=false
item_length=50
ellipsize=2
history_key=<Ctrl><Alt>H
actions_key=<Ctrl><Alt>A
menu_key=<Ctrl><Alt>P
search_key=<Ctrl><Alt>F
offline_key=<Ctrl><Alt>O
offline_mode=false
FOE

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
