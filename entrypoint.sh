#!/bin/bash

echo "Seeding the adminpageconf.json file with the username and password"

cat <<EOF > adminpageconf.json
{
  "username": "$DWC_ADMIN_USERNAME",
  "password": "$DWC_ADMIN_PASSWORD"
}
EOF

exec "$@"