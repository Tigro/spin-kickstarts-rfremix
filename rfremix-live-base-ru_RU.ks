# include Russian Fedora and RPMFusion repos
%include rfremix-repo-not-rawhide.ks

# Fonts and input methods for Russia

%packages
# fonts for Russia
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts
ucs-miscfixed-fonts

# codecs
gstreamer-ffmpeg
gstreamer-plugins-bad-free
gstreamer-plugins-bad-nonfree
gstreamer-plugins-ugly
gstreamer1-libav
gstreamer1-plugins-bad-free
gstreamer1-plugins-ugly

# yes many peoples love flash
flash-plugin

# should be to feel better
bash-completion
fpaste
grub-customizer
mc
wget

# avoid theese
-*nvidia*
-freetype-freeworld
-ubuntu-font-family

# configuration
rfremix-config

%end

%post

cat >> /etc/rc.d/init.d/livesys << EOF

# set system keymaps
localectl set-x11-keymap us,ru pc105 , grp:alt_shift_toggle

EOF

%end
