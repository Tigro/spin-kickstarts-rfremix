# rfremix-livecd-xfce-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include spin-kickstarts/fedora-live-xfce.ks
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

xfce4-kbdleds-plugin
xfce4-xkb-plugin
%end
