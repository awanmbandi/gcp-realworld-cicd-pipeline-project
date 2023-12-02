## VM Instaructions
# Image: Ubuntu 22.04
# Instance type: 2CPU and 4 or 8+RAM

sudo vim /etc/security/limits.conf
```bash
sonarqube   -   nofile   65536
sonarqube   -   nproc    4096
```
sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install openjdk-17-jdk -y
sudo apt-get install openjdk-17-jre -y

sudo update-alternatives --config java
```yml
Switch to Java 17
```
java -version

## Step #2: Install and Setup PostgreSQL 10 Database For SonarQube
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
sudo apt-get -y install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo 'postgres:postgres' | sudo chpasswd
su - postgres
createuser sonar
psql

ALTER USER sonar WITH ENCRYPTED password 'sonar';
CREATE DATABASE sonarqube OWNER sonar;
GRANT all privileges on DATABASE sonarqube to sonar;

# Exit from DB and Root
\q
exit

## Step #3: How to Install SonarQube on Ubuntu 22.04 LTS
cd /tmp
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.65466.zip
sudo unzip sonarqube-9.9.0.65466.zip -d /opt
sudo mv /opt/sonarqube-9.9.0.65466 /opt/sonarqube

## Step #4:Configure SonarQube on Ubuntu 22.04 LTS
sudo groupadd sonar
sudo useradd -c "user to run SonarQube" -d /opt/sonarqube -g sonar sonar
sudo chown sonar:sonar /opt/sonarqube -R

sudo vim /opt/sonarqube/conf/sonar.properties
```bash
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
```

sudo vim /opt/sonarqube/bin/linux-x86-64/sonar.sh
```bash
RUN_AS_USER=sonar
```

## Start SonarQube


## Step #5:Configure Systemd service
sudo vim /etc/systemd/system/sonar.service
```bash
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=sonar
Group=sonar
Restart=always

LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
```

sudo systemctl start sonar
sudo systemctl enable sonar
sudo systemctl status sonar
