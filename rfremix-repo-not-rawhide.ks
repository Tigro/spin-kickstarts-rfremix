# RPMFusion Repos
repo --name=rpmfusion-free --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-22&arch=$basearch
repo --name=rpmfusion-free-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-22&arch=$basearch
repo --name=rpmfusion-free-updates-testing --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-testing-$releasever&arch=$basearch
repo --name=rpmfusion-nonfree --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-22&arch=$basearch --exclude *nvidia*
repo --name=rpmfusion-nonfree-updates --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-22&arch=$basearch
repo --name=rpmfusion-nonfree-updates-testing --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-testing-$releasever&arch=$basearch

# Russian Fedora Repos
repo --name=russianfedora-free --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-$releasever&arch=$basearch
repo --name=russianfedora-free-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-nonfree --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-$releasever&arch=$basearch --exclude java*sun*
repo --name=russianfedora-nonfree-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-$releasever&arch=$basearch --exclude java*sun*
repo --name=russianfedora-fixes --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-$releasever&arch=$basearch
repo --name=russianfedora-fixes-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=fixes-fedora-updates-released-$releasever&arch=$basearch
repo --name=russianfedora-branding --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-$releasever&arch=$basearch
repo --name=russianfedora-branding-updates --mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=branding-fedora-updates-released-$releasever&arch=$basearch
