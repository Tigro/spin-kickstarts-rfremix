# rfremix-livedvd-kde-ru_RU.ks
#
# Maintainer(s):
# - Arkady L. Shane <ashejn [AT] russianfedora [DOT] ru>

%include rfremix-live-base-ru_RU.ks
%include rfremix-livedvd-kde.ks

lang ru_RU.UTF-8
keyboard ru
timezone Europe/Moscow

%packages
@russian-support
-kde-i18n-Russian
hunspell-ru
%end
