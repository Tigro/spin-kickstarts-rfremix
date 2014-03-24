# Fonts and input methods for Russia

%packages
# fonts for Russia
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts
-cjkuni-*-fonts
-jomolhari-fonts
-kacst-*-fonts
-khmeros-*-fonts
-lklug-fonts
-lohit-*-fonts
-sil-*-fonts
-paktype-*-fonts
-smc-*-fonts
-thai-scalable-fonts-common
-thai-scalable-fonts-compat
-thai-scalable-*-fonts
-un-extra-*-fonts
-un-core-*-fonts
-vlgothic-fonts
-vlgothic-fonts-common
-vlgothic-p-fonts
-vollkorn-fonts
-wqy-*-fonts

# install proper logos
rfremix-logos

# remove input methods to free space
-scim*
-m17n*
-ibus*
-anthy
-kasumi
-libhangul

# codecs
gstreamer-plugins-ugly
gstreamer-plugins-bad-free
gstreamer-plugins-bad-nonfree
gstreamer-ffmpeg

flash-plugin

bash-completion

# multimedia
paman
paprefs
pavucontrol
pavumeter

# usability
system-config-printer
#system-config-lvm

# utility
testdisk

%end

%post

cat >> /etc/rc.d/init.d/livesys << EOF

# set system keymaps
localectl set-x11-keymap us,ru pc105 , grp:alt_shift_toggle

EOF
%end
