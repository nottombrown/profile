# Depends on the .fluxbox and .themes folders being in place.

PKGS=""
PKGS="$PKGS emacs23-nox emacs-goodies-el" # goodies-el provides color-theme mode
PKGS="$PKGS vlc"
PKGS="$PKGS rxvt-unicode"
PKGS="$PKGS wine"
PKGS="$PKGS chromium-browser chromium-codecs-ffmpeg-extra"
PKGS="$PKGS flashplugin-installer"
PKGS="$PKGS pidgin"
PKGS="$PKGS virtualbox-ose"
PKGS="$PKGS transmission"
PKGS="$PKGS git-core"
PKGS="$PKGS xlockmore-gl"
PKGS="$PKGS g++"
PKGS="$PKGS gtk-theme-switch"
PKGS="$PKGS smbfs"
#PKGS="$PKGS ubuntu-restricted-extras"
PKGS="$PKGS libdvdread4" # i think we only need this part of restricted-extras

sudo apt-get install $PKGS

# restricted dvd playback stuff
sudo /usr/share/doc/libdvdread4/install-css.sh

# git
git config --global user.name "Kevin Kelley"
git config --global user.email kelleyk@kelleyk.net

# aterm
echo "Aterm*scrollBar: false" >> ~/.Xresources

# gtk
gtk-theme-switch2 "Elegant Brit"

# nautilus
gconftool-2 --type=Boolean --set /apps/nautilus/preferences/always_use_location_entry true
