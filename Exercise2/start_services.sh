#!/usr/bin/env bash


sudo systemctl start influxdb
sudo service grafana-server start

cd ~/projects/cn1-impl-opt-coap

# Start the CoAP server
cd server
source cn1_server/bin/activate
python3 server.py


cd ../client
source cn1_client/bin/activate
python3 client.py