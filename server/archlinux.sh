#!/bin/sh

#https://www.archlinux.org/developers/
#https://www.archlinux.org/trustedusers/

#http://purebacon.com/articles/arch-linux-on-linode.html

### Node.js Pages
#https://github.com/joyent/node/wiki
#https://github.com/joyent/node/wiki/_pages

############################## login root

for key in EAE999BD F56C0C53 00F0D0F0 06361833 4FA415FA A9999C34 4CE1C13E 0F2A092B F04569AE; do
  pacman-key --recv-keys $key
  pacman-key --lsign-key $key
  printf 'trustn3nquitn' | gpg --homedir /etc/pacman.d/gnupg/ --no-permission-warning --command-fd 0 --edit-key $key
done

pacman -S tzdata

pacman -Syu

pacman-key --init; pacman-key --populate archlinux

# or edit /etc/group
groupadd sudo

# or useradd
adduser
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

# `nginx`
pacman -S nginx
# /etc/nginx/config/nginx.conf
/etc/rc.d/nginx start
# /etc/group
groupadd http
# sudo chgrp http www -R
# sudo chmod g+w www -R

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

echo 'export TZ="Asia/Shanghai"' >> ~/.profile
echo 'export PATH="/home/cfd/bin:$PATH"' >> ~/.profile
echo 'export NODE_PATH="/home/cfd/lib/node_modules"' >> ~/.profile
echo 'export PYTHON=`which python2`' >> ~/.profile
echo 'prefiX = /home/cfd' >> ~/.npmrc

git clone https://github.com/joyent/node.git
make install

# #
# # ~/.bash_profile
# #
#
#  [[ -f ~/.bashrc ]] && . ~/.bashrc
#  [[ -f ~/.profile ]] && . ~/.profile

############################# relogin
npm prefix -g
# /home/cfd
npm bin -g
# /home/cfd/bin
npm root -g
# /home/cfd/lib/node_modules
echo $NODE_PATH

# install modules
npm install -g express
npm install -g jade
npm install -g stylus
npm install -g zmq
