#!/bin/bash

echo "Seeding the DNS config files"

find ./zones -type f -exec sed -i "s/HOST_IP/${HOST_IP}/g" {} +

exec "$@"