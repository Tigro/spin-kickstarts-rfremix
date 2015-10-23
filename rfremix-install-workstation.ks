repo --name=fedora-updates --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-f$releasever&arch=$basearch --excludepkgs=fedora-productimg-cloud,fedora-productimg-server
repo --name=fedora-updates-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-released-source-f$releasever&arch=$basearch --excludepkgs=fedora-productimg-cloud,fedora-productimg-server

# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-22&arch=$basearch
repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-22&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-22&arch=$basearch --exclude *nvidia*
repo --name=rpmfusion-nonfree-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-22&arch=$basearch
repo --name=rpmfusion-free-source --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-source-22&arch=$basearch
repo --name=rpmfusion-nonfree-source --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-source-22&arch=$basearch
repo --name=rpmfusion-free-updates-source --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-source-22&arch=$basearch
repo --name=rpmfusion-nonfree-updates-source --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-source-22&arch=$basearch

# Russian Fedora Repos
repo --name=russianfedora-branding --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-$releasever&arch=$basearch
repo --name=russianfedora-branding-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch --exclude java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch --exclude java*sun*
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-$releasever&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-$releasever&arch=$basearch

repo --name=russianfedora-branding-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-source-$releasever&arch=$basearch
repo --name=russianfedora-branding-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-source-$releasever&arch=$basearch
repo --name=russianfedora-fixes-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-source-$releasever&arch=$basearch
repo --name=russianfedora-fixes-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-source-$releasever&arch=$basearch
repo --name=russianfedora-free-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-source-$releasever&arch=$basearch
repo --name=russianfedora-free-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-source-$releasever&arch=$basearch
repo --name=russianfedora-nonfree-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-source-$releasever&arch=$basearch
repo --name=russianfedora-nonfree-updates-source --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-source-$releasever&arch=$basearch

%include spin-kickstarts/fedora-install-workstation.ks
