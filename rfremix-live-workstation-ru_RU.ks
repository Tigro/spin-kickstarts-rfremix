# rfremix-livecd-desktop-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include fedora-live-workstation.ks
%include rfremix-live-base-ru_RU.ks

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
gnome-classic-session
clipit
gnome-tweak-tool
%end

%post
cat >> /etc/rc.d/init.d/livesys << EOF
# enable menu accelerator
cat > /usr/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override <<FOE
[org.gnome.Terminal.Legacy.Settings]
menu-accelerator-enabled=false
FOE

%end

