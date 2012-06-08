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
repo --name=russianfedora --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-russianfedora-$releasever&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude syslog-ng* --exclude java-1.5.0-gcj-devel --exclude astronomy-bookmarks --exclude generic* --exclude java-1.5.0-gcj-javadoc --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome
repo --name=russianfedora-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-russianfedora-updates-$releasever&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude syslog-ng* --exclude java-1.5.0-gcj-devel --exclude astronomy-bookmarks --exclude generic* --exclude java-1.5.0-gcj-javadoc --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome
#repo --name=russianfedora-updates-testing --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-russianfedora-updates-testing-$releasever&arch=$basearch --exclude kernel*debug* --exclude kernel-kdump* --exclude syslog-ng* --exclude java-1.5.0-gcj-devel --exclude astronomy-bookmarks --exclude generic* --exclude java-1.5.0-gcj-javadoc --exclude btanks* --exclude GConf2-dbus* --exclude bluez-gnome
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-rpmfusion-free-$releasever&arch=$basearch
repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-rpmfusion-free-updates-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-rpmfusion-nonfree-$releasever&arch=$basearch --exclude kmod-nvidia-3.3.0* --exclude kmod-nvidia-3.3.1* --exclude kmod-nvidia-3.3.4-3*
repo --name=rpmfusion-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=build-rpmfusion-nonfree-updates-$releasever&arch=$basearch --exclude kmod-nvidia-3.3.0* --exclude kmod-nvidia-3.3.1* --exclude kmod-nvidia-3.3.4-3*
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch --exclude=java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-$releasever&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-$releasever&arch=$basearch

# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (@base is added by default unless you add --nobase to %packages)
# (default groups for the configured repos are added by --default)
%packages --default
# core
tcsh
kernel*
dracut-*
# grub-efi and grub2 and efibootmgr so anaconda can use the right one on install. 
grub-efi
grub2
efibootmgr
# mactel-boot needs to be on the DVD for successful installation to intel macs.
mactel-boot
# Desktop Packages
@kde-desktop
@xfce-desktop
@lxde-desktop
@sugar-desktop
kdewebdev
echo-icon-theme
tracker
nspluginwrapper
liferea
esc
thunderbird
@dial-up
# apps
@eclipse
joe
emacs
k3b
@system-tools
mc
wireshark-gnome
# Devel packages
@development-libs
@development-tools
@fedora-packager
@gnome-software-development
@kde-software-development
@web-development
@x-software-development
# Server packages
@dns-server
@ftp-server
@mail-server
@mysql
@network-server
@news-server
@server-cfg
@smb-server
@sql-server
@web-server
# Keep dap off the install media, makes Eng & Sci show up
-dap-server-cgi
# Virt group
@virtualization --optional
# Things needed for installation
@anaconda-tools
# Languages
@afrikaans-support
@albanian-support
@arabic-support
@armenian-support
@assamese-support
@basque-support
@belarusian-support
@bengali-support
@bhutanese-support
@bosnian-support
@brazilian-support
@breton-support
@british-support
@bulgarian-support
@burmese-support
@catalan-support
@croatian-support
@czech-support
@danish-support
@dutch-support
@esperanto-support
@estonian-support
@ethiopic-support
@faroese-support
@filipino-support
@finnish-support
@french-support
@gaelic-support
@galician-support
@georgian-support
@german-support
@greek-support
@gujarati-support
@hebrew-support
@hindi-support
@hungarian-support
@icelandic-support
@indonesian-support
@inuktitut-support
@irish-support
@italian-support
@japanese-support
@kannada-support
@kashmiri-support
@kashubian-support
@khmer-support
@konkani-support
@korean-support
@lao-support
@latvian-support
@lithuanian-support
@low-saxon-support
@macedonian-support
@malay-support
@malayalam-support
@maori-support
@marathi-support
@mongolian-support
@nepali-support
@northern-sotho-support
@norwegian-support
@oriya-support
@persian-support
@polish-support
@portuguese-support
@punjabi-support
@romanian-support
@russian-support
@samoan-support
@serbian-support
@simplified-chinese-support
@sindhi-support
@sinhala-support
@slovak-support
@slovenian-support
@somali-support
@southern-ndebele-support
@southern-sotho-support
@spanish-support
@swati-support
@swedish-support
@tagalog-support
@tamil-support
@telugu-support
@thai-support
@tibetan-support
@tonga-support
@traditional-chinese-support
@tsonga-support
@tswana-support
@turkish-support
@ukrainian-support
@urdu-support
@venda-support
@vietnamese-support
@walloon-support
@welsh-support
@xhosa-support
@zulu-support
# Langpacks
aspell-*
autocorr-*
eclipse-nls-*
hunspell-*
hyphen-*
kde-l10n-*
kde-i18n-*
libreoffice-langpack-*
man-pages-*
mythes-*
# Size removals
-gimp-help
-java-1.6.0-openjdk-src
-xorg-x11-docs
-kernel-doc
-java-1.5.0-gcj-src
-java-1.5.0-gcj-devel
-libgcj-src
-frysk
-*gcj*
-PackageKit-zif
-zif

@desktop-minimal
%end
