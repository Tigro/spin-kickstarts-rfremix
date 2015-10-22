Create RFRemix Live Images
==========================

Cloning
=======

* git clone -b f23/master git://github.com/Tigro/spin-kickstarts-rfremix.git
* cd spin-kickstarts-rfremix
* git submodules update --init

Building Images
===============

```
sudo ./create-live 

Create RFRemix Live images based on Fedora 23 package base
from internet.

create-live <imagename> <i686|x86_64|all> <version>
	-c - Cinnamon LiveCD
	-g - Workstation (with GNOME) LiveCD
	-k - KDE LiveCD
	-x - XFCE LiveCD
	-l - LXDE LiveCD
	-m - MATE LiveCD
	-a - ALL Images
```
