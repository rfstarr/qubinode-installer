#!/bin/bash

name=qbn-rhel802
disk="/var/lib/libvirt/images/${name}-vda.qcow2"
mac=$(./macgen.py)
sudo virt-install --connect qemu:///system --import --name $name \
             --ram 4096 --vcpus 2 \
             --disk $disk,format=qcow2,bus=virtio \
             --network network=qubinet,mac=${mac} \
             --os-type=linux --os-variant=rhel8.0 --noautoconsole \
             --autostart

exit 0


sudo su -
LIBGUESTFS_TMP=$(mktemp -d)
wget http://download.libguestfs.org/binaries/appliance/appliance-1.40.1.tar.xz -O ${LIBGUESTFS_TMP}/appliance-1.40.1.tar.xz
tar xvfJ ${LIBGUESTFS_TMP}/appliance-1.40.1.tar.xz -C ${LIBGUESTFS_TMP}/
export LIBGUESTFS_PATH="${LIBGUESTFS_TMP}/appliance/"
export LIBGUESTFS_BACKEND=direct

sudo virt-customize -a $disk --root-password password:ad71150rod --uninstall cloud-init
