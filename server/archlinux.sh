#!/bin/sh

#https://www.archlinux.org/developers/
#https://www.archlinux.org/trustedusers/

#http://library.linode.com/web-servers/nginx/perl-fastcgi/arch-linux
#http://purebacon.com/articles/arch-linux-on-linode.html

### Node.js Pages
#https://github.com/joyent/node/wiki
#https://github.com/joyent/node/wiki/_pages

############################## login root

pacman-key --init; pacman-key --populate archlinux

pacman -Syu

pacman -S tzdata

#for key in EAE999BD F56C0C53 00F0D0F0 06361833 4FA415FA A9999C34 4CE1C13E 0F2A092B F04569AE; do
#  pacman-key --recv-keys $key
#  pacman-key --lsign-key $key
#  printf 'trustn3nquitn' | gpg --homedir /etc/pacman.d/gnupg/ --no-permission-warning --command-fd 0 --edit-key $key
#done
# /etc/rc.conf

# or edit /etc/group
groupadd sudo

# or useradd
adduser
#ssh-keygen -t dsa -C user@host
#ssh-copy-id -i id_rsa.pub user@host

# edit /etc/sudoers
  ## Uncomment to allow members of group wheel to execute any command
  # %sudo ALL=(ALL) ALL

# Locking out root
# sudo passwd -l root
# sudo passwd -u root

# `base-devel`
# Repository core
#   1) autoconf  2) automake  3) binutils  4) bison  5) fakeroot  6) flex  7) gcc
#   8) libtool   9) m4  10) make  11) patch  12) pkg-config
pacman -S base-devel

# `openssl`
pacman -S openssl

# `make`
pacman -S make

# `git`
pacman -S git

# `monit`
pacman -S monit
# /etc/monitrc
# mkdir /etc/monit.d

# `nginx`
pacman -S nginx
/etc/rc.d/nginx start
# /etc/group
groupadd http
# namei -om $HOME
# chmod o+x $HOME
# sudo chgrp http sites -R
# sudo chmod g+w sites -R
# /etc/rc.conf `deamon`
# /etc/nginx/nginx.conf
# mkdir /etc/nginx/sites-available
# mkdir /etc/nginx/sites-enabled
# sudo systemctlre start nginx.service

# `python2`
pacman -S python2

# `zeromq`
pacman -S zeromq

# `nodejs`
pacman -S nodejs

# uninstall default `npm`
# Because can custom set npm global prefix
npm uninstall -g npm

############################# login user
mkdir ~/bin
ln -s /usr/bin/python2 ~/bin/python

echo 'export TZ="Asia/Shanghai"' >> ~/.profile
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.profile
echo 'export PYTHON=`which python2`' >> ~/.profile

# #
# # ~/.bash_profile
# #
#
#  [[ -f ~/.bashrc ]] && . ~/.bashrc
#  [[ -f ~/.profile ]] && . ~/.profile


mkdir ~/{opt,repos}
cd ~/repos
# git clone https://github.com/joyent/node.git
# cd node
# ./configure --prefix=~/opt/node
# make && make install
echo 'export PATH="$HOME/opt/node/bin:$PATH"' >> ~/.profile
echo 'export NODE_PATH="$HOME/opt/node/lib/node_modules"' >> ~/.profile

############################# relogin
npm prefix -g
npm bin -g
npm root -g
echo $NODE_PATH

# install modules
npm install -g express
npm install -g jade
npm install -g stylus
npm install -g zmq
