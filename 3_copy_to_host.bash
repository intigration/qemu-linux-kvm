#!/bin/bash

# to_windows_drive is a symlink out of my WSL2 container

cp rootfs.qcow2 debian-arm64/vmlinuz debian-arm64/initrd.img to_windows_drive
