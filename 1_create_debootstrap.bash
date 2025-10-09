#!/bin/bash

mkdir -p cache_debootstrap
sudo qemu-debootstrap --arch=arm64 --cache-dir=$(pwd)/cache_debootstrap --include "linux-image-arm64, openssh-server" buster ./debian-arm64 http://ftp.debian.org/debian

sudo chroot ./debian-arm64 /bin/bash -c 'apt update'

# Minimal weston
sudo chroot ./debian-arm64 /bin/bash -c 'export DEBIAN_FRONTEND=noninteractive; apt install -y sudo kbd weston libpam-systemd'

## Minimal x
#sudo chroot ./debian-arm64 /bin/bash -c 'export DEBIAN_FRONTEND=noninteractive; apt install -y xserver-xorg-core xserver-xorg-video-fbdev xserver-xorg-input-libinput x11-xserver-utils xterm openbox lightdm mesa-utils'

# Setup users root - root and arm -arm
sudo chroot ./debian-arm64 /bin/bash -c 'echo root:root | chpasswd'
sudo chroot ./debian-arm64 /bin/bash -c 'adduser --quiet --disabled-password --shell /bin/bash --home /home/arm --gecos "" arm'
sudo chroot ./debian-arm64 /bin/bash -c 'echo arm:arm | chpasswd'
sudo chroot ./debian-arm64 /bin/bash -c 'usermod -a -G weston-launch arm'
sudo chroot ./debian-arm64 /bin/bash -c 'usermod -a -G sudo arm'

# Enable dhcp
sudo cp files/10-wired.network debian-arm64/etc/systemd/network/
sudo chroot ./debian-arm64 /bin/bash -c 'systemctl enable systemd-networkd'

# Enable weston on startup
sudo cp files/weston.service debian-arm64/lib/systemd/system/
sudo chroot ./debian-arm64 /bin/bash -c 'systemctl enable weston.service'

## Enable autologin for X
#sudo cp files/02_lightdm_autologin.conf debian-arm64/usr/share/lightdm/lightdm.conf.d
#sudo chroot ./debian-arm64 /bin/bash -c 'chown root:root /usr/share/lightdm/lightdm.conf.d/02_lightdm_autologin.conf'
#sudo chroot ./debian-arm64 /bin/bash -c 'chmod 644 /usr/share/lightdm/lightdm.conf.d/02_lightdm_autologin.conf'
