# rfremix-livecd-kde-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include rfremix-live-base-ru_RU.ks
%include rfremix-livecd-kde.ks

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

%packages
@russian-support
-kde-i18n-Russian
hunspell-ru
%end

%post
# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
        if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
                sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
        fi
fi

%end
