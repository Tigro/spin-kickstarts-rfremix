# Kickstart file for composing the "Russian Fedora"
# Maintained by the Fedora Release Engineering team:
# https://fedoraproject.org/wiki/ReleaseEngineering
# mailto:rel-eng@lists.fedoraproject.org

# Use a part of 'iso' to define how large you want your isos.
# Only used when composing to more than one iso.
# Default is 695 (megs), CD size.
# Listed below is the size of a DVD if you wanted to split higher.
#part iso --size=4998

%include rfremix-packages.ks

# Add the repos you wish to use to compose here.  At least one of them needs group data.
# Fedora Repos
repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-18&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude kernel-tools* --exclude syslog-ng* --exclude astronomy-bookmarks --exclude generic* --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome --exclude fedora-release --exclude lorax

repo --name=fedora-updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f18&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude kernel-tools* --exclude syslog-ng* --exclude astronomy-bookmarks --exclude generic* --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome --exclude fedora-release --exclude lorax

repo --name=fedora-updates-testing --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f18&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude kernel-tools* --exclude syslog-ng* --exclude astronomy-bookmarks --exclude generic* --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome --exclude fedora-release --exclude lorax

# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-18&arch=$basearch
#repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-18&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-18&arch=$basearch
#repo --name=rpmfusion-nonfree-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-18&arch=$basearch

# Russian Fedora Repos
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-18&arch=$basearch
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-18&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-18&arch=$basearch --exclude=java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-18&arch=$basearch
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-18&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-18&arch=$basearch

# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (default groups for the configured repos are added by --default)
%packages --default
# core
kernel*
-kernel-tools*
-kernel-debug*
dracut-*

# Desktops

## common stuff
@base-x
@standard
@core
@dial-up
@fonts
@input-methods
@multimedia
@hardware-support
@printing

## GNOME
@firefox
@gnome-desktop
@epiphany
@libreoffice
@gnome-games

## KDE
@kde-desktop
@kde-apps
@kde-education
@kde-media
@kde-office

## XFCE
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media
@xfce-office

## LXDE
@lxde-desktop
@lxde-apps
@lxde-media
@lxde-office

## SUGAR
#@sugar-desktop
#@sugar-apps

# Web server
@web-server
@haproxy
@jbossas
@mongodb
@perl-web
@python-web
@php
@rubyonrails
@mysql
@sql-server

# Infrastructure server
@dns-server
@ftp-server
@mail-server
@network-server
@smb-server

# Workstation
@eclipse
@development-libs
@development-tools
@fedora-packager
@gnome-software-development
@kde-software-development
@x-software-development
@virtualization
@web-server
@jbossas
@mongodb
@perl-web
@php
@rubyonrails
@mysql
@sql-server
@design-suite
## Not included yet due to space concerns
#@milkymist
#@mingw32
#@ocaml
#@robotics-suite
#@electronic-lab

# Things needed for installation
@anaconda-tools

# Langpacks
aspell-*
autocorr-*
eclipse-nls-*
hunspell-*
hyphen-*
calligra-l10n-*
kde-l10n-*
kde-i18n-*
libreoffice-langpack-*
man-pages-*
mythes-*

# Removals
-PackageKit-zif
-zif

# RFRemix
@chromium
@gnome-desktop-minimal
@kde-desktop-minimal

# drop
-cairo-freeworld
-freetype-freeworld
-opera
-gimp-help
-java-1.7.0-openjdk-javadoc
-kdegames
-java-1.5.0-gcj-javadoc
-kernel-doc
-scribus-doc
-mate*
-imsettings-mate

%end
