#!/bin/bash

# Hostname hardcoded in script omdat dit een vaste waarde is voor SAP
HOSTNAME="vhcalnplci"
IP_ADDRESS=$1

if [[ -z "$1" ]]; then
    IP_ADDRESS=$(ifconfig eth1 | grep 'inet addr:' | cut -d : -f 2 | awk '{ print $1 }')
fi

# Installeer dependencies
zypper -n install uuidd
systemctl enable uuidd
systemctl start uuidd

# Past hosts file aan
echo $IP_ADDRESS $HOSTNAME $HOSTNAME.dummy.nodomain >> /etc/hosts

# Past hostname aan
echo $HOSTNAME > /etc/hostname

# Pas grub timeout aan om boot time te verbeteren
sed -i 's/GRUB_TIMEOUT=8/GRUB_TIMEOUT=0/g' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# Disable firewall
systemctl disable SuSEfirewall2_setup.service
systemctl disable SuSEfirewall2_init.service
