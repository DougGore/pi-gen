#!/bin/bash -e

install -m 644 files/actioncam.service "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/smb.conf "${ROOTFS_DIR}/etc/samba/"

on_chroot << EOF
echo i2c-dev >> /etc/modules

mkdir -m 1777 /share
chown pi:pi /share
smbpasswd -n -a pi

systemctl enable actioncam.service
EOF
