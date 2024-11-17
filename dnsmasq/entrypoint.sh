#!/bin/sh

echo "Seeding the ip address"

sed -i "s/HOST_IP/${HOST_IP}/g" /etc/dnsmasq.conf
sed -i "s/PRIMARY_FORWARD_DNS/${PRIMARY_FORWARD_DNS}/g" /etc/dnsmasq.conf
sed -i "s/SECONDARY_FORWARD_DNS/${SECONDARY_FORWARD_DNS}/g" /etc/dnsmasq.conf

exec "$@"