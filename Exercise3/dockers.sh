#!/usr/bin/env bash

sudo docker pull influxdb:1.8.10
sudo docker pull grafana/grafana:10.2.0

sudo docker run -p 8086:8086 -e INFLUXDB_DB='dht' -e INFLUXDB_ADMIN_USER='influxDBuser' -e INFLUXDB_ADMIN_PASSWORD='influxDBpass' -e INFLUXDB_HTTP_AUTH_ENABLED='true' influxdb:1.8.10 &

sudo docker run -p 3000:3000 grafana/grafana:10.2.0 & 

sudo docker pull drexon/dht_coap_server:1.0
sudo docker pull drexon/dht_coap_client:1.0

sudo docker run -p 5683:5683 --net='host' drexon/dht_coap_server:1.0 & 
sudo docker run -p 61616:61616 --net='host' drexon/dht_coap_client:1.0 &
