#!/bin/bash -e

install -m 644 files/actioncam.service "${ROOTFS_DIR}/lib/systemd/system/"

on_chroot << EOF
systemctl enable actioncam.service
EOF
