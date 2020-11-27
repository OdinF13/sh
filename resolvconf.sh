#!/bin/bash

if [ $EUID -ne 0 ]; then
	echo "run this script as root"
	exit 1
fi


echo "Installing \"resolvconf\""
apt install resolvconf -y

echo "Enbaling service"
systemctl enable resolvconf.service
systemctl start resolvconf.service

echo "Configuring"
echo "nameserver 1.1.1.1" > /etc/resolvconf/resolv.conf.d/base
echo "nameserver 1.1.1.1" > /etc/resolvconf/resolv.conf.d/head
echo "dns-nameservers 1.1.1.1 8.8.8.8" >> /etc/network/interfaces

systemctl restart resolvconf.service
systemctl restart NetworkManager

echo "Reboot and you're done!"
while [ -z "$answer" ]; do
	read -n 1 -p 'Do you want to reboot now?[Y/n] ' answer
done

echo
case ${answer,,} in
	y)	init 6	;;
esac
