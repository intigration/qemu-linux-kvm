& 'C:\Program Files\qemu\qemu-system-aarch64.exe' `
    -M virt -m 2G -cpu max -smp 4 `
    -kernel vmlinuz `
    -initrd initrd.img `
    -append "root=/dev/vda rw video=800x600" `
    -drive if=virtio,format=qcow2,file=rootfs.qcow2 `
    -device virtio-net-pci,netdev=net0 `
    -netdev user,id=net0,hostfwd=tcp::8022-:22  `
    -device virtio-gpu-pci `
    -display gtk,zoom-to-fit=off `
    -device qemu-xhci -device usb-tablet -device usb-kbd

