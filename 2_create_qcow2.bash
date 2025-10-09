#!/bin/bash

# convert ext4 to qcow2 image

rm -f rootfs.img rootfs.qcow2
dd if=/dev/zero of=rootfs.img bs=1 count=0 seek=16G
mkfs.ext4 rootfs.img
mkdir -p mp
sudo mount -oloop rootfs.img mp/
sudo cp -a debian-arm64/. mp/
sudo umount mp
qemu-img convert -O qcow2 rootfs.img rootfs.qcow2
