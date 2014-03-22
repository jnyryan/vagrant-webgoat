#!/bin/bash

echo Update and install Tomcat
apt-get update
apt-get install -y build-essential libncurses5-dev curl
tasksel install tomcat-server

#echo from http://samiux.blogspot.ie/2013/07/howto-webgoat-54-on-ubuntu-server-1204.html
echo 'Downloading and installing WebGoat'
wget http://webgoat.googlecode.com/files/WebGoat-5.4.war
mv WebGoat-5.4.war WebGoat.war
cp WebGoat.war /var/lib/tomcat6/webapps/

echo 'Edit Webgoat configuration /etc/tomcat6/tomcat-users.xml'

sed '/tomcat\-users/d' /etc/tomcat6/tomcat-users.xml
echo '<role rolename="webgoat_basic"/> \
<role rolename="webgoat_admin"/> \
<role rolename="webgoat_user"/> \
<role rolename="tomcat"/> \ 
<user password="webgoat" roles="webgoat_admin" username="webgoat"/> \
<user password="basic" roles="webgoat_user,webgoat_basic" username="basic"/> \
<user password="tomcat" roles="tomcat" username="tomcat"/> \
<user password="guest" roles="webgoat_user" username="guest"/> \
</tomcat-users>' >> /etc/tomcat6/tomcat-users.xml

echo Restart Tomcat.
/etc/init.d/tomcat6 restart

ifconfig

echo 'Test - Open a browser (e.g. Firefox) and point to the WebGoat (e.g. 192.168.56.102).'
#curl http://0.0.0.0:8080/WebGoat/attack
