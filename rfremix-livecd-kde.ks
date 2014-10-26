# rfremix-livecd-kde.ks
#
# Description:
# - RFRemix Livecd Spin with the K Desktop Environment (KDE), default 1.4 GB version
#
# Maintainer(s):
# - Arkady L. Shane <ashejn@russainfedora.ru>
# - Sebastian Vahl <fedora@deadbabylon.de>
# - Fedora KDE SIG, http://fedoraproject.org/wiki/SIGs/KDE, kde@lists.fedoraproject.org

%include rfremix-live-kde-base.ks
%include rfremix-live-minimization.ks

# DVD payload
part / --size=8192

%packages
# unwanted packages from @kde-desktop
# don't include these for now to fit on a cd
-desktop-backgrounds-basic
-kdeaccessibility*
-kdeartwork-screensavers	# screensavers are not needed on live images
#-ktorrent			# kget has also basic torrent features (~3 megs)
digikam				# digikam has duplicate functionality with gwenview (~28 megs)
-amarok 			# amarok has duplicate functionality with juk (~23 megs)
kipi-plugins			# ~8 megs
-konq-plugins			# ~2 megs
kdeplasma-addons		# ~16 megs

# Additional packages that are not default in kde-desktop but useful
k3b				# ~15 megs
@libreoffice
#kdeartwork			# only include some parts of kdeartwork
#twinkle			# (~10 megs)
fuse
liveusb-creator
#pavucontrol			# pavucontrol has duplicate functionality with kmix
kaffeine*			# kaffeine has duplicate functionality with dragonplayer (~3 megs)

# only include kdegames-minimal
kdegames

kdegraphics-mobipocket
kdegraphics-strigi-analyzer
kdegraphics-thumbnailers

### space issues

# fonts (we make no bones about admitting we're english-only)
wqy-microhei-fonts                     # a compact CJK font, to replace:
-naver-nanum-gothic-fonts              # Korean
-vlgothic-fonts                                # Japanese
-adobe-source-han-sans-cn-fonts                # simplified Chinese
-adobe-source-han-sans-twhk-fonts      # traditional Chinese

-paratype-pt-sans-fonts	# Cyrillic (already supported by DejaVu), huge
#-stix-fonts		# mathematical symbols

# remove input methods to free space
-@input-methods
-scim*
-m17n*
-ibus*
-iok

# save some space (from @standard)
-make

# save space (it pulls in gdisk/udisks2/libicu)
-gnome-disk-utility

# save space
-argyllcms
-foo2*
-evince*
## avoid serious bugs by omitting broken stuff

# fix rf#1286
kde-partitionmanager

%end

%post
%end
