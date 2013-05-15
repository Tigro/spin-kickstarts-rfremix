# Desktop with customizationst to fit in a CD sized image (package removals, etc.)
# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include rfremix-live-desktop.ks
%include rfremix-live-minimization.ks

%packages
# First, no office
-planner

# Java plugin
icedtea-web
# Drop things that pull in perl
-linux-atm

# No printing
-foomatic-db-ppds
-foomatic

# Dictionaries are big
# we're going to try keeping hunspell-* after notting, davidz, and ajax voiced
# strong preference to giving it a go on #fedora-desktop.
# also see http://bugzilla.gnome.org/681084
-aspell-*
-man-pages*
-words

# Help and art can be big, too
-gnome-user-docs
-evolution-help
-desktop-backgrounds-basic
-stix-fonts
-ibus-typing-booster*backgrounds-extras

# Legacy cmdline things we don't want
-krb5-auth-dialog
-krb5-workstation
-pam_krb5
-quota
-nano
-minicom
-dos2unix
-finger
-ftp
-jwhois
-mtr
-pinfo
-rsh
-telnet
-nfs-utils
-ypbind
-yp-tools
-rpcbind
-acpid
-ntsysv

# Drop some system-config things
-system-config-boot
-system-config-rootpassword
-system-config-services
-policycoreutils-gui

# utility
gparted
shutter

%end

%post

# This is a huge file and things work ok without it
rm -f /usr/share/icons/HighContrast/icon-theme.cache

%end
