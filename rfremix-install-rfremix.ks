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
repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-rawhide&arch=$basearch

repo --name=fedora-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-source-rawhide&arch=$basearch

# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch --exclude *nvidia*
repo --name=rpmfusion-free-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/free/fedora/development/rawhide/source/SRPMS/
repo --name=rpmfusion-nonfree-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/nonfree/fedora/development/rawhide/source/SRPMS/

# Russian Fedora Repos
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-rawhide&arch=$basearch  --exclude russianfedora*
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-rawhide&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch --exclude java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-rawhide&arch=$basearch --exclude java*sun*
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-rawhide&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-rawhide&arch=$basearch
repo --name=russianfedora-branding --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-rawhide&arch=$basearch
repo --name=russianfedora-branding-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-rawhide&arch=$basearch

repo --name=russianfedora-fixes-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-source-rawhide&arch=$basearch
repo --name=russianfedora-fixes-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-source-rawhide&arch=$basearch
repo --name=russianfedora-free-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-source-rawhide&arch=$basearch
repo --name=russianfedora-free-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-source-rawhide&arch=$basearch
repo --name=russianfedora-nonfree-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-source-rawhide&arch=$basearch
repo --name=russianfedora-nonfree-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-source-rawhide&arch=$basearch
repo --name=russianfedora-branding-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-source-rawhide&arch=$basearch
repo --name=russianfedora-branding-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-source-rawhide&arch=$basearch



# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (default groups for the configured repos are added by --default)
# @base got renamed to @standard, but @base is still included by default by pungi.
%packages --default --nobase

# pungi is an inclusive depsolver so that multiple packages are brought 
# in to satisify dependencies and we don't always want that. So we  use
# an exclusion list to cut out things we don't want

-kernel*debug*
-kernel-kdump*
-kernel-tools*
-syslog-ng*
-astronomy-bookmarks
-generic*
-GConf2-dbus*
-bluez-gnome
# Periods cause problems in paterns, so replace with *s
-java-1*8*0-openjdk
-community-mysql*
-jruby*

# core
kernel*
dracut-*

# Desktops

## common stuff
@base-x
@guest-desktop-agents
@guest-agents
@standard
@core
@dial-up
@fonts
@input-methods
@multimedia
@hardware-support
@printing
@admin-tools
@basic-desktop

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
#@kde-office

## XFCE
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media
#@xfce-office

## LXDE
@lxde-desktop
@lxde-apps
@lxde-media
#@lxde-office

## SUGAR
@sugar-desktop
@sugar-apps

## MATE
@mate-desktop

## CINNAMON
@cinnamon-desktop

# Workstation
@eclipse
@development-libs
@development-tools
@c-development
@rpm-development-tools
@fedora-packager
@gnome-software-development
@kde-software-development
@x-software-development
@virtualization
@web-server
@mongodb
@perl-web
@php
@python-web
@rubyonrails
@mysql
@sql-server
@design-suite
## Not included yet due to space concerns
#@jbossas
#@milkymist
#@mingw32
#@ocaml
#@robotics-suite
#@electronic-lab

# Things needed for installation
@anaconda-tools

# Langpacks
autocorr-*
eclipse-nls-*
hunspell-*
hyphen-*
calligra-l10n-*
kde-l10n-*
libreoffice-langpack-*
man-pages-*
mythes-*
-gimp-help-*

# Removals
-PackageKit-zif
-zif
%end
