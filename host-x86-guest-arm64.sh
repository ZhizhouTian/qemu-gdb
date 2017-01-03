#!/bin/bash
#-device vhost-vsock-pci,id=vhost-vsock-pci0 \
set -e
kill_nc_vsock() {
	sudo pkill nc-vsock
}
trap kill_nc_vsock EXIT
#-serial telnet::1235,server,nowait  \
#sudo ~/linaro-code/vsock-qemu/qemu/aarch64-softmmu/qemu-system-aarch64 \
sudo /home/zhizhoutian/workspace/vms/qemu-master/build/aarch64-softmmu/qemu-system-aarch64 \
	-S \
	-serial telnet::1234,server,nowait \
	-gdb tcp::1235 \
	-monitor telnet::1236,server,nowait  \
	-machine virt \
	-cpu cortex-a57 \
	-m 1024 \
	-kernel out/arch/arm64/boot/Image \
	-nographic \
	-append "earlyprintk=pl011,0x9000000 console=ttyAMA0 mem=1024M loglevel=8"
#	-device virtio-vsock
