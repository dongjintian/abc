#!/bin/bash
ip1=`ifconfig eth0 |awk '/inet /{print $2}'`
ip2=`ifconfig eth1 |awk '/inet /{print $2}'`
yumdir='/etc/yum.repos.d/dvd.repo'

rm -rf /etc/yum.repos.d/*
echo [dvd] >> $yumdir
echo name=rhel7 >> $yumdir
echo enabled=1 >> $yumdir
echo gpgcheck=0 >> $yumdir

if [ -z $ip1 ];then
  ip=$ip2;
else
  ip=$ip1;
fi

case $ip in
192.168.4.100)
  hostnamectl set-hostname Client
  echo "baseurl=ftp://192.168.4.254/rhel7" >> $yumdir;;
192.168.4.5)
  hostnamectl set-hostname Proxy
  echo "baseurl=ftp://192.168.4.254/rhel7" >> $yumdir;;
192.168.2.100)
  hostnamectl set-hostname Web1
  echo "baseurl=ftp://192.168.2.254/rhel7" >> $yumdir;;
192.168.2.200)
  hostnamectl set-hostname Web2
  echo "baseurl=ftp://192.168.2.254/rhel7" >> $yumdir;;
*)
esac


