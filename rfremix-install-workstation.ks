# Kickstart file for composing the "Russian Fedora"
# Maintained by the Fedora Release Engineering team:
# https://fedoraproject.org/wiki/ReleaseEngineering
# mailto:rel-eng@lists.fedoraproject.org

# Use a part of 'iso' to define how large you want your isos.
# Only used when composing to more than one iso.
# Default is 695 (megs), CD size.
# Listed below is the size of a DVD if you wanted to split higher.
#part iso --size=4998

# Add the repos you wish to use to compose here.  At least one of them needs group data.

# Fedora Repos
repo --name=fedora --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-21&arch=$basearch
repo --name=fedora-updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f21&arch=$basearch
#repo --name=fedora-updates-testing --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f21&arch=$basearch

repo --name=fedora-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=fedora-source-21&arch=$basearch
repo --name=fedora-updates-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-source-f21&arch=$basearch
#repo --name=fedora-updates-testing-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-source-f21&arch=$basearch

# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-rawhide&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-rawhide&arch=$basearch
repo --name=rpmfusion-free-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/free/fedora/development/21/source/SRPMS/
repo --name=rpmfusion-nonfree-source --baseurl=http://mirror.yandex.ru/fedora/rpmfusion/nonfree/fedora/development/21/source/SRPMS/

# Russian Fedora Repos
repo --name=russianfedora-branding --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-21&arch=$basearch  --exclude russianfedora*
repo --name=russianfedora-branding-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-21&arch=$basearch
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-21&arch=$basearch  --exclude russianfedora*
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-21&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-21&arch=$basearch --exclude java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-21&arch=$basearch --exclude java*sun*
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-21&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-21&arch=$basearch

repo --name=russianfedora-branding-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-source-21&arch=$basearch
repo --name=russianfedora-branding-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-source-21&arch=$basearch
repo --name=russianfedora-fixes-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-source-21&arch=$basearch
repo --name=russianfedora-fixes-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-source-21&arch=$basearch
repo --name=russianfedora-free-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-source-21&arch=$basearch
repo --name=russianfedora-free-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-source-21&arch=$basearch
repo --name=russianfedora-nonfree-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-source-21&arch=$basearch
repo --name=russianfedora-nonfree-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-source-21&arch=$basearch

%include rfremix-workstation-packages.ks
%include rfremix-packages.ks

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
-astronomy-bookmarks
-generic*

# core
kernel*

# Things needed for installation
@anaconda-tools

%end
