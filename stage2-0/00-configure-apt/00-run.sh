#!/bin/bash -e

install -m 644 files/picymru.list ${ROOTFS_DIR}/etc/apt/sources.list.d/
on_chroot apt-key add - < files/picymru.gpg.key
on_chroot << EOF
apt-get update
EOF
