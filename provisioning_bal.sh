#!/bin/bash

echo "************ INICIO ARCHIVO DE PROVISIONAMIENTO BALANCEADOR ************"

sudo usermod -a -G lxd $(whoami)

echo " ---------- Nuevo grupo LXD ---------- "
sudo newgrp lxd

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Iniciar LXD ---------- "
sudo lxd init --auto

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Instalar contenedor HAPROXY ---------- "
sudo -i lxc launch ubuntu:18.04 haproxy

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Actualizar contenedor HAPROXY ---------- "
lxc exec haproxy -- sudo apt -y update
lxc exec haproxy -- sudo apt -y upgrade

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Instalar HAPROXY ---------- "
lxc exec haproxy -- sudo apt -y install haproxy

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Iniciar HAPROXY ---------- "
lxc exec haproxy -- sudo systemctl enable haproxy

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Configurar haproxy.cfg ---------- "
lxc file push /vagrant/shared_folder/haproxy.cfg haproxy/etc/haproxy/haproxy.cfg

echo " ---------- Configurar 503.http ---------- "
lxc file push /vagrant/shared_folder/503.http haproxy/etc/haproxy/errors/503.http

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Reiniciar HAPROXI ---------- "
lxc exec haproxy -- sudo systemctl restart haproxy

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Forwarding de puertos ---------- "
sudo lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80

#echo " ---------- Cluster Preseed File  ---------- "
#cat /home/vagrant/cluster.yml | sudo lxd init --preseed

echo "************ FIN ARCHIVO DE PROVISIONAMIENTO BALANCEADOR ************"