#!/bin/bash

qemu-system-aarch64 \
    -M virt -m 2G -cpu cortex-a57 \
    -kernel debian-arm64/vmlinuz \
    -initrd debian-arm64/initrd.img \
    -append "root=/dev/vda" \
    -drive if=virtio,format=qcow2,file=rootfs.qcow2 \
    -object rng-random,filename=/dev/urandom,id=rng0 \
    -device virtio-rng-pci,rng=rng0               \
    -device virtio-net-pci,netdev=net0            \
    -netdev user,id=net0,hostfwd=tcp::8022-:22    \
    -device virtio-gpu-pci \
    -display gtk,zoom-to-fit=off \
    -device qemu-xhci -device usb-tablet -device usb-kbd
