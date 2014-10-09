#!/bin/sh

cp /vagrant/provision/rc.conf.local /etc/
cp /vagrant/provision/relayd.conf /etc/

if [ -r /var/run/relayd.sock ] ; then
  relayctl reload
else
  . /etc/rc.conf.local
  relayd $relayd_flags
fi
