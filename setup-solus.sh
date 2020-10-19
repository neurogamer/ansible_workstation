#!/bin/bash
set -o pipefail

#####
# This script will take a fresh Solus install and make it suitable for getting stuff done.
#####

trap exit SIGINT SIGTERM

##### remove sudo reauthentication timeout
sudo sed -i.bak -e '$a\' -e 'Defaults timestamp_timeout=-1' -e '/Defaults timestamp_timeout=.*/d' /etc/sudoers

##### set better ssh defaults
sudo sed -i.bak -e '$a\' -e 'StrictHostKeyChecking=no' -e '/StrictHostKeyChecking=.*/d' /etc/ssh/ssh_config
sudo sed -i.bak -e '$a\' -e 'UserKnownHostsFile=\/dev\/null' -e '/UserKnownHostsFile=.*/d' /etc/ssh/ssh_config
sudo sed -i.bak -e '$a\' -e 'GlobalKnownHostsFile=\/dev\/null' -e '/GlobalKnownHostsFile=.*/d' /etc/ssh/ssh_config
sudo sed -i.bak -e '$a\' -e 'Compression=yes' -e '/Compression=.*/d' /etc/ssh/ssh_config

#### Remove useless default apps
sudo eopkg remove -y\
  gnome-mpv\
  hexchat\
  rhythmbox\
  thunderbird\

# Install packages from standard repo
sudo eopkg install -y\
  lynx\
  vim
  terminator\
  mc\
  ranger\
  i3\
  htop\
  variety\
  sshfs-fuse\
  steam\
  mpd\
  wine\
  wine-32bit\
  vulkan\
  neofetch\
  feh\
  cmus\
  deadbeef\
  lutris\
  docker\
  lxappearance\
  i3-style\
  conky\
  openra\
  pptp\
  w3m

#### Add user to groups
for group in docker fuse ; do
  sudo gpasswd -a $USER $group
done
