#!/bin/bash

echo "************ INICIO ARCHIVO DE PROVISIONAMIENTO WEB3 ************"

sudo usermod -a -G lxd $(whoami)

echo " ---------- Nuevo grupo LXD ---------- "
sudo newgrp lxd

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Iniciar LXD ---------- "
sudo lxd init --auto

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Instalar contenedor WEB3  ---------- "
sudo lxc launch ubuntu:18.04 web3

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Actualizar contenedor WEB3 ---------- "
lxc exec web3 -- sudo apt -y update
lxc exec web3 -- sudo apt -y upgrade

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Instalar APACHE ---------- "
lxc exec web3 -- sudo apt -y install apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Iniciar APACHE ---------- "
lxc exec web3 -- sudo systemctl enable apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Configurar index.html ---------- "
lxc file push /vagrant/shared_folder/index_web3.html web3/var/www/html/index.html

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Reiniciar APACHE ---------- "
lxc exec web3 -- sudo systemctl restart apache2

echo " ---------- Tiempo de espera... ---------- "
sudo sleep 10

echo " ---------- Forwarding de puertos ---------- "
sudo lxc config device add web3 http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80

echo "************ FIN ARCHIVO DE PROVISIONAMIENTO WEB3 ************"