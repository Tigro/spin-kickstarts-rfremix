# rfremix-livecd-kde.ks
#
# Description:
# - RFRemix Live Spin with GNOME, KDE, XFCE and LXDE
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@yandex-team.ru>

%include rfremix-live-kde-base.ks
%include rfremix-live-minimization.ks

part / --size 5296 --fstype ext4

%packages

# make apper the default on the kde live images
apper
-gnome-packagekit

# use system-config-printer-kde instead of system-config-printer
-system-config-printer
system-config-printer-kde

# make sure /usr/bin/pactl is there (#466544)
pulseaudio-utils

# make sure alsaunmute is there
alsa-utils

### The KDE-Desktop

# new applications
flash-plugin
goldendict
libdvdcss
-NetworkManager-gnome
xine-lib-extras-freeworld
gstreamer-ffmpeg
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
gstreamer-plugins-base
gstreamer-plugins-espeak
gstreamer-plugins-fc
gstreamer-plugins-flumpegdemux
gstreamer-plugins-good
gstreamer-plugins-ugly
qmmp-plugins-freeworld
@java

# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd

digikam
kaffeine 		### kaffeine has duplicate functionality with dragonplayer (~3 megs)
kdeartwork 		### kdeartwork is not really needed
kdeartwork-screensavers
kdeedu
kdegames 		### the removal of kdegames will free ~35 megs
kdeplasma-addons
kipi-plugins
ktorrent 		### kget has also basic torrent features (~3 megs)
scribus		### scribus is too big for the live images
-xscreensaver-gl-extras

kde-wallpapers

# Other applications
@office

# Useful additional KDE3 applications
amarok
rekonq
#avidemux-qt
#avidemux-plugins
compiz-kde
djview4
fwbuilder
k3b
k3b-extras-freeworld
k9copy
kchmviewer
#kdenlive
kdeutils
kdiff3
keepassx
kmediafactory
knemo
kopete-cryptography
kphotoalbum
kplayer
kradio4
krusader
kopete-cryptography
kvirc
kvkbd
lmms
psi
psimedia
qtcurve-kde4
tellico
twinkle
vacuum
vlc
phonon-backend-vlc
transmission-qt

# some extras
fuse
liveusb-creator

# FIXME/TODO: recheck the removals here
# try to remove some packages from russianfedora-live-base.ks
-gdm
-authconfig-gtk

# save some space (from @base)
-autofs

-evince*

%end

%post
%end
