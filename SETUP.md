# Raspberry Pi Setup Guide for DWC Server

## Initial Setup

### Prerequisites
1. **Hardware Requirements**
   - Any Raspberry Pi with both ethernet and WiFi capabilities.

2. **Operating System Installation**
   - Install Raspberry Pi OS Lite using the official Raspberry Pi Imager.
   - Configure the following settings in the imager:
     - Timezone
     - Username
     - SSH access
   - **Note:** Do not configure WiFi at this stage; it will be set up later.

3. **Basic Configuration**
   ```bash
   # Connect to your Raspberry Pi via SSH
   ssh username@raspberry-pi-ip
   ```

4. **Install Docker**
   - Follow the official Docker installation guide:
     - [Docker Installation Guide](https://docs.docker.com/engine/install/debian/#install-using-the-repository)
   - Complete post-installation steps:
     - [Post-Installation Steps](https://docs.docker.com/engine/install/linux-postinstall/)
     - Configure Docker group
     - Enable Docker to start on boot

5. **Install Docker Compose**
   ```bash
   # Download the latest Docker Compose release for ARM64
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose

   # Make Docker Compose executable
   sudo chmod +x /usr/local/bin/docker-compose
   ```

## Raspberry Pi as DWC Server Setup

### Install Required Software
- If prompted about IPv4 and IPv6, choose "yes".
    ```bash
    # Install necessary packages
    sudo apt install -y \
        dhcpcd5 \
        dnsmasq \
        hostapd \
        netfilter-persistent \
        iptables-persistent \
        rfkill
    ```

### Configure Access Point

#### Set the WiFi Country
- Change to your country if needed.
```bash
sudo raspi-config nonint do_wifi_country DE
```

#### 1. Stop Services Temporarily
```bash
sudo systemctl stop dnsmasq
sudo systemctl stop hostapd
```

#### 2. Configure Static IP for WiFi Interface
```bash
sudo nano /etc/dhcpcd.conf
```
- Add the following at the end (replace with your desired IP. Use a different subnet than your router):
```
interface wlan0
    static ip_address=192.168.50.1/24
    nohook wpa_supplicant
```

#### 3. Configure DHCP Server
```bash
# Backup the original configuration
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig

# Create a new configuration
sudo nano /etc/dnsmasq.conf
```
- Add the following (replace with your IP-range and IP):
```
interface=wlan0
dhcp-range=192.168.50.10,192.168.50.100,255.255.255.0,24h
dhcp-option=6,192.168.50.1
port=0
```

#### 4. Configure WiFi Access Point
```bash
sudo nano /etc/hostapd/hostapd.conf
```
- Add the following (replace with your SSID and passphrase):
```
interface=wlan0
driver=nl80211
ssid=YOURSSID
hw_mode=g
channel=9
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=YourPassphrase
wpa_key_mgmt=WPA-PSK
wpa_pairwise=TKIP
rsn_pairwise=CCMP
```

#### 5. Enable hostapd Configuration
```bash
sudo nano /etc/default/hostapd
```
- Find and modify:
```
DAEMON_CONF="/etc/hostapd/hostapd.conf"
```

#### 6. Enable IP Forwarding
```bash
sudo nano /etc/sysctl.conf
```
- Find and modify:
```
net.ipv4.ip_forward=1
```

- Confirm with:
```bash
sudo sysctl -p
```

#### 7. Configure Network Routing (NAT)
```bash
# Clear existing iptables rules
sudo iptables -F && \
sudo iptables -t nat -F && \
sudo iptables -t mangle -F && \
sudo iptables -X

# Setup NAT for network routing
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE && \
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT && \
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT

# Save the iptables rules
sudo netfilter-persistent save
```

#### 8. Enable and Start Services
```bash
# Unblock WiFi
sudo rfkill unblock wlan

# Enable necessary services
sudo systemctl unmask hostapd && \
sudo systemctl enable dhcpcd && \
sudo systemctl enable hostapd && \
sudo systemctl enable dnsmasq

# Start the services
sudo systemctl restart dhcpcd && \
sudo systemctl restart dnsmasq && \
sudo systemctl restart hostapd
```

#### 9. Disable Network Manager
```bash
sudo systemctl disable NetworkManager && \
sudo systemctl mask NetworkManager
```

### Reboot the System
```bash
sudo reboot
```
- **Note:** Your IP address might change after the reboot.

## Verification
1. **Check Service Status:**
   ```bash
   sudo systemctl status hostapd
   sudo systemctl status dnsmasq
   ```

2. **Verify WiFi Network:**
   - Ensure the SSID is visible on another device.
   - Connect using the configured password.
   - Verify you receive an IP in the range 192.168.50.10-100. (Or your configured range)
   - Confirm internet access.

## Setup DWC Server

1. **Change Ownership of /srv Directory**
   ```bash
   sudo chown -R $USER /srv
   ```

2. **Clone the Repository**
   ```bash
   cd /srv && \
   git clone https://github.com/Good-Games-Munich/dwc-server.git && \
   cd dwc-server
   ```

3. **Create an .env File**
   - Add the following content (replace with your desired values and IP):
   ```
   HOST_IP=192.168.50.1
   DWC_ADMIN_USERNAME=admin
   DWC_ADMIN_PASSWORD=password
   ```

4. **Start the Docker Container**
   ```bash
   docker-compose up --build -d
   ```

## Setup the Wiis

1. **Apply any NoSSL Patch**
2. **Use the Access Point for the Wii**

## Troubleshooting

1. **If WiFi is Blocked:**
   ```bash
   rfkill list all
   sudo rfkill unblock wlan
   ```

2. **Check Logs for Errors:**
   ```bash
   sudo journalctl -u hostapd -n 50
   sudo journalctl -u dnsmasq -n 50
   ```

3. **Restart All Services:**
   ```bash
   sudo systemctl restart dhcpcd && \
   sudo systemctl restart dnsmasq && \
   sudo systemctl restart hostapd
   ```