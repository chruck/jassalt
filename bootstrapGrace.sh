#!/bin/bash

# Script to use system `grace' as a bootstrapped system to get
# everything going.
#
# Assumptions:
# * grace is a bare Bodhi Linux system
#   * therefore, package manager is apt
# * grace will be a minion to itself first, until another master is
#   built

MASTER="grace"

# IPTables on a bare system is blank, so this is not needed:
# (but we want to enable it anyway for this master)
sudo iptables -A INPUT -m state --state new -m tcp -p tcp --dport 4505 -j ACCEPT
sudo iptables -A INPUT -m state --state new -m tcp -p tcp --dport 4506 -j ACCEPT

echo "== First, make sure OS is up-to-date =="
sudo apt update && sudo apt -y upgrade

echo "== Install salt-master package =="
sudo apt install -y salt-master salt-minion salt-doc

# If, instead, I want the latest salt (I don't, since Bodhi is now
# installing 2014.7.2 of salt)
#echo "== Install curl and git to bootstrap SaltStack =="
#sudo apt install -y git curl
#
#echo "== Download and execute SaltStack Bootstrap =="
#curl -L http://bootstrap.saltstack.org | sudo sh -s -- git develop

# These are all defaults, not needed:
#echo "== Create /etc/salt/master =="
#cat <<EOF >>"master"
## The network interface to bind to
#interface: 0.0.0.0
## The Request/Reply port
#ret_port: 4506
## The port minions bind to for commands, aka the publish port
#publish_port: 4505
#EOF
#sudo mv /etc/salt/master /etc/salt/master.orig
#sudo mv master /etc/salt

echo "== Create hostname 'salt' as alias to localhost =="
sudo sed -i "s/127.0.0.1.*/& salt/" /etc/hosts 

echo "== Starting daemons =="
sudo service salt-master restart
sudo service salt-minion restart

echo "== Accepting ${MASTER} =="
sudo salt-key -ya ${MASTER}

echo "== Checking out salt states =="
pushd /srv
sudo git clone https://github.com/chruck/jassalt.git
sudo ln -s jassalt/salt .
sudo ln -s jassalt/pillar .
popd

echo "== Now deploy to ${MASTER} =="
sudo salt "${MASTER}" state.highstate
