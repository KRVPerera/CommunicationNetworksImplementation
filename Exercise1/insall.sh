#!/usr/bin/env bash

# Set a variable to determine whether to skip the section
SKIP_SECTION=true

# Check if the variable is set to true
if [ "$SKIP_SECTION" = true ]; then
    echo "Skipping section: Install Python 3 and create virtual environment"
else
    # Install Python 3, Python 3 development headers, and Python 3 pip
    sudo apt-get install python3 python3-dev python3-pip -y

    # Create virtual environment
    python3 -m venv cn1_lab_work

    # Activate virtual environment
    source cn1_lab_work/bin/activate

    # Install Python 3.10.12
    python3 -m pip install --upgrade pip
fi

# Clone the repository as a zip file
if [ ! -f master.zip ]; then
    git clone https://github.com/cwc-ns/cn1-impl-opt-coap.git
else
    echo "File already downloaded"
fi

# Unzip the file
cd cn1-impl-opt-coap/influxdb/new/installer

# Check if the file exists
if [ -f influxdb_1.8.10_amd64.deb ]; then
    if [ "$(sha256sum influxdb_1.8.10_amd64.deb | awk '{print $1}')" = "b2ace09231575df7309a41cea6f9dc7ad716fe4389dc06ac04470a14bd411456" ]; then
        echo "InfluxDb deb file is valid"
    else
        echo "InfluxDb deb file is invalid"
        wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.10_amd64.deb
    fi
else
    wget https://dl.influxdata.com/influxdb/releases/influxdb_1.8.10_amd64.deb
fi

# Check if influxdb is already installed
if dpkg --list | grep -q influxdb; then
    echo "InfluxDB is already installed"
    influxd version
else
    sudo dpkg -i influxdb_1.8.10_amd64.deb
fi


# start influxdb daemon
sudo systemctl start influxdb
sudo influxd
#sudo systemctl start influxdb

# Check if influxdb is running
netstat -ptuln | grep 8086

cd ../../

sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_10.2.0_amd64.deb
sudo dpkg -i grafana_10.2.0_amd64.deb
# Start Grafana server
sudo service grafana-server start

# Check if Grafana is running
sudo service grafana-server status

# Check if Grafana is running
netstat -ptuln | grep 3000

#sudo systemctl start influxdb
# Navigate inside the repository
cd cn1-impl-opt-coap







