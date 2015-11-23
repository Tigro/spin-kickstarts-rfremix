# rfremix-livecd-desktop-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include spin-kickstarts/fedora-live-workstation.ks
%include rfremix-live-base-ru_RU.ks

part / --size 10144

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

%packages
aspell-ru
autocorr-ru 
hunspell-ru 
hyphen-ru 
libreoffice-langpack-ru  
mythes-ru

# Classic session for GNOME
@rfremix-workstation-product
chromium
chromium-pepper-flash
deluge
gcc
gcc-c++
gimp
kernel-devel
libappindicator
mpv
rpmdevtools
shutter
skype
telegram-desktop
viber
xchat
%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# add us,ru layouts by default
cat > /usr/share/glib-2.0/schemas/org.gnome.desktop.input-sources.gschema.override << FOE
[org.gnome.desktop.input-sources]
sources=[('xkb', 'us'), ('xkb', 'ru')]
xkb-options=['grp:rctrl_rshift_toggle,grp_led:scroll']
FOE

# enable menu accelerator
cat > /usr/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override <<FOE
[org.gnome.Terminal.Legacy.Settings]
menu-accelerator-enabled=false
dark-theme=true
FOE

glib-compile-schemas /usr/share/glib-2.0/schemas

EOF

%end

