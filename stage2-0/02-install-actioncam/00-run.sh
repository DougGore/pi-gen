#!/bin/bash -e

install -m 644 files/actioncam.service "${ROOTFS_DIR}/lib/systemd/system/"
install -m 644 files/actioncam_usb.service "${ROOTFS_DIR}/lib/systemd/system/"
install -d "${ROOTFS_DIR}/usr/lib/actioncam"
install -m 755 files/setup_usb "${ROOTFS_DIR}/usr/lib/actioncam/"
install -m 644 files/smb.conf "${ROOTFS_DIR}/etc/samba/"
install -m 644 files/hostapd.conf "${ROOTFS_DIR}/etc/hostapd/"
install -m 644 files/70-persistent-net.rules "${ROOTFS_DIR}/etc/udev/rules.d/"

# WiFi AP setup
cat files/interfaces >> "${ROOTFS_DIR}/etc/network/interfaces"
cat files/dnsmasq.conf >> "${ROOTFS_DIR}/etc/dnsmasq.conf"
sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="\/etc\/hostapd\/hostapd.conf"/' "${ROOTFS_DIR}/etc/default/hostapd"
#sed -i '19i/sbin/ifup wlan0' "${ROOTFS_DIR}/etc/rc.local"

on_chroot << EOF
echo i2c-dev >> /etc/modules
echo libcomposite >> /etc/modules

mkdir -m 1777 /share
chown pi:pi /share
smbpasswd -n -a pi

systemctl enable actioncam.service
systemctl enable actioncam_usb.service
EOF
