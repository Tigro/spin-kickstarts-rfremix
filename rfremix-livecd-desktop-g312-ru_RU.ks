# rfremix-livecd-desktop-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include rfremix-livecd-desktop.ks
%include rfremix-live-base-ru_RU.ks

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

repo --name=rhughes-f20-gnome-3-12 --baseurl=http://copr-be.cloud.fedoraproject.org/results/rhughes/f20-gnome-3-12/fedora-20-$basearch/
repo --name=russianfedora-addons-to-rhughes --baseurl=http://koji.russianfedora.pro/kojifiles/repos/rfr20-gnome-build/latest/$basearch/

%packages
aspell-ru
autocorr-ru 
hunspell-ru 
hyphen-ru 
libreoffice-langpack-ru  
mythes-ru
%end
