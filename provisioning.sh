#!/bin/bash

echo "************ INICIO ARCHIVO DE PROVISIONAMIENTO ************"

apt install haproxy -y
systemctl enable haproxy

cat /home/vagrant/cluster.yml | sudo lxd init --preseed

echo "************ FIN ARCHIVO DE PROVISIONAMIENTO ************"