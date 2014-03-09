#!/bin/sh
set -e
export PKG_PATH="http://ftp.NetBSD.org/pub/pkgsrc/packages/$(uname -s)/$(uname -m)/$(uname -r|cut -f '1 2' -d.)/All"

binary_pkgs='git-base tmux vim mosh offlineimap mutt python33 wget w3m irssi'
src_pkgs='wip/ekg2'

# Install binaries
pkg_add $binary_pkgs

# Install from source
for pkg in $src_pkgs; do
  pkg_info $(echo $pkg|cut -d/ -f2) > /dev/null ||
  (
    cd /usr/pkgsrc/$pkg
    make install
  )
done

useradd tlevine
for dir in git safe nsa; do
  su tlevine -c "mkdir ~/$dir"
done