# rfremix-livecd-kde-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include rfremix-livecd-kde-minimal.ks

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

%packages
-kde-i18n-Russian
kde-l10n-Russian
hunspell-ru
aspell-ru
%end

%post
# make kdm russian
if [ -f /etc/kde/kdm/kdmrc ]; then
        if [ "\`echo \$LANG | awk -F_ '{print \$1}'\`" == "ru" ]; then
                sed -i 's!#Language=de_DE!Language=ru_RU!' /etc/kde/kdm/kdmrc
        fi
fi

%end
