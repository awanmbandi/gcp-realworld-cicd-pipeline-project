#!/bin/bash
## VM Instaructions
# Image: Ubuntu 22.04
# Instance type: 2CPU and 4 or 8+RAM
sudo su
apt-get update -y
apt install openjdk-8-jre-headless -y
wget https://download.sonatype.com/nexus/3/latest-unix.tar.gz -P /opt
tar -zxvf /opt/latest-unix.tar.gz -C /opt/
mv /opt/nexus-3.62.0-01 /opt/nexus
useradd nexus -m
echo "nexus:nexus" | chpasswd  ## Ubuntu
echo "nexus ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
chown -R nexus:nexus /opt/nexus
chown -R nexus:nexus /opt/sonatype-work
sed -i 's/run_as_user=""/run_as_user="nexus"/g' /opt/nexus/bin/nexus.rc
cat << EOF | sudo tee /etc/systemd/system/nexus.service >/dev/null
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

systemctl start nexus
systemctl enable nexus
systemctl status nexus
