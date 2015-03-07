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
repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-22&arch=$basearch
repo --name=fedora-updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f22&arch=$basearch
#repo --name=fedora-updates-testing --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f22&arch=$basearch

repo --name=fedora-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-source-22&arch=$basearch
repo --name=fedora-updates-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-source-f22&arch=$basearch
#repo --name=fedora-updates-testing-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-source-f22&arch=$basearch

# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch
repo --name=rpmfusion-free-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/free/fedora/development/22/source/SRPMS/
repo --name=rpmfusion-nonfree-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/nonfree/fedora/development/22/source/SRPMS/

# Russian Fedora Repos
repo --name=russianfedora-branding --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-22&arch=$basearch  --exclude russianfedora*
repo --name=russianfedora-branding-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-22&arch=$basearch
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-22&arch=$basearch  --exclude russianfedora*
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-22&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-22&arch=$basearch --exclude java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-22&arch=$basearch --exclude java*sun*
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-22&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-22&arch=$basearch

repo --name=russianfedora-branding-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-source-22&arch=$basearch
repo --name=russianfedora-branding-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-source-22&arch=$basearch
repo --name=russianfedora-fixes-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-source-22&arch=$basearch
repo --name=russianfedora-fixes-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-source-22&arch=$basearch
repo --name=russianfedora-free-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-source-22&arch=$basearch
repo --name=russianfedora-free-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-source-22&arch=$basearch
repo --name=russianfedora-nonfree-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-source-22&arch=$basearch
repo --name=russianfedora-nonfree-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-source-22&arch=$basearch


# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (default groups for the configured repos are added by --default)
# @base got renamed to @standard, but @base is still included by default by pungi.
%packages --default

-fedora-productimg-cloud
fedora-productimg-server
-fedora-productimg-workstation

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

## KDE
@kde-desktop
@kde-apps
@kde-education
@kde-media

## XFCE
@xfce-desktop
@xfce-apps
@xfce-extra-plugins
@xfce-media

## MATE
@mate-desktop

## CINNAMON
@cinnamon-desktop

# Workstation
@rfremix-workstation-product

@eclipse
@development-libs
@development-tools
@c-development
@rpm-development-tools
@fedora-packager
@x-software-development
@virtualization
@web-server
@perl-web
@php
@python-web
@mysql
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
kde-l10n-*
libreoffice-langpack-*
man-pages-*
mythes-*
-gimp-help-*

# Removals
-PackageKit-zif
-zif
%end
