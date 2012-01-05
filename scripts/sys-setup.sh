# Depends on the .fluxbox and .themes folders being in place.

PKGS=""
PKGS="$PKGS emacs23-nox emacs-goodies-el" # goodies-el provides color-theme mode
PKGS="$PKGS vlc"
# X terminal emulator.
PKGS="$PKGS rxvt-unicode"
# Chromium and extra codecs (some media files, like e.g. the ones that
# Pandora serves, won't play without them).
PKGS="$PKGS chromium-browser chromium-codecs-ffmpeg-extra"
PKGS="$PKGS flashplugin-installer"
PKGS="$PKGS virtualbox-ose"
# Torrent client.
PKGS="$PKGS transmission"
# Everyone's favorite DVCS.
PKGS="$PKGS git-core"
# Locking screensaver.
PKGS="$PKGS xlockmore-gl"
# C++ compiler for installing goodies.
PKGS="$PKGS g++"
# Theme switching tool for making GTK apps pretty.
PKGS="$PKGS gtk-theme-switch"
# Samba support for mounting shared Windows drives.
PKGS="$PKGS smbfs"
# Nautilus integration for Dropbox.  (This will also install Dropbox
# itself.)
PKGS="$PKGS nautilus-dropbox"
# Java support for Closure Compiler.
PKGS="$PKGS openjdk-7-jre"
# Sass
PKGS="$PKGS libhaml-ruby"
# NodeJS and CoffeeScript.
PKGS="$PKGS nodejs npm coffeescript"
# Visual diff tool.  (The git-meld script and git alias are installed
# by sync-dotfiles).
PKGS="$PKGS meld"
PKGS="$PKGS python-virtualenv"
# Command-line image processing tools (required by stitchbg, my
# background-setting script).
PKGS="$PKGS imagemagick"

sudo apt-get install $PKGS

# Docco and pygments, a dependency that does syntax highlighting.
# Ignore npm whining about running as root.
sudo apt-get install python-pygments
sudo npm install docco

# restricted dvd playback stuff
sudo apt-get install libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh

# gtk
gtk-theme-switch2 "Elegant Brit"

# Must be done manually...
# - run sync-dotfiles.py
# - copy private SSH key to .ssh/id_rsa
# - install Adobe AIR from dropbox/software/packages
# - copy closure-compiler shell script to /usr/local/bin/closure-compiler
# - put latest compiler.jar (from Closure Compiler website)
#       in /usr/local/closure-compiler/
# - Pandora, HipChat, and other Air applications can be installed the
#       normal way (by visiting their websites).  You /will/ have to
#       symlink their binaries into the system path.

# nautilus TODO: Because of the recent switch from gconf to dconf,
# these lines don't really do much.  You shoudl install dconf-tools
# and then use dconf-editor to set org.gnome.nautilus options.
gconftool-2 --type bool --set /apps/nautilus/preferences/always_use_location_entry true
gconftool-2 --type bool --set /apps/nautilus/preferences/show_desktop false

# Spotify
echo -e "\ndeb http://repository.spotify.com stable non-free\n" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4E9CFF4E
apt-get update
apt-get install spotify-client-qt
