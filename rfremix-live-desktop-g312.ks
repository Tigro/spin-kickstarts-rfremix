# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

%include rfremix-live-base.ks
%include rfremix-desktop-packages.ks

part / --size 8192

%post
cat >> /etc/rc.d/init.d/livesys << EOF

# add us,ru layouts by default
cat > /usr/share/glib-2.0/schemas/org.gnome.desktop.input-sources.gschema.override << FOE
[org.gnome.desktop.input-sources]
sources=[('xkb', 'us'), ('xkb', 'ru')]
xkb-options=['grp:alt_shift_toggle']
FOE

# enable menu accelerator
cat > /usr/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override <<FOE
[org.gnome.Terminal.Legacy.Settings]
menu-accelerator-enabled=false
FOE

# disable updates plugin
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.updates.gschema.override << FOE
[org.gnome.settings-daemon.plugins.updates]
active=false
FOE

# enable dark terminal
cat >> /usr/share/glib-2.0/schemas/org.gnome.Terminal.gschema.override <<FOE
[org.gnome.Terminal.Legacy.Settings]
dark-theme=true
FOE

# don't run gnome-initial-setup
mkdir ~liveuser/.config
touch ~liveuser/.config/gnome-initial-setup-done

# make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

  cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'empathy.desktop', 'rhythmbox.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nautilus.desktop', 'gnome-documents.desktop', 'anaconda.desktop']
FOE

  # Make the welcome screen show up
  if [ -f /usr/share/anaconda/gnome/fedora-welcome.desktop ]; then
    mkdir -p ~liveuser/.config/autostart
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop /usr/share/applications/
    cp /usr/share/anaconda/gnome/fedora-welcome.desktop ~liveuser/.config/autostart/
  fi
fi

# rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

EOF

%end