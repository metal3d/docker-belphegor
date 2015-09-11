#!/bin/bash

[[ -f /.msttcorefont-installed ]] && exit 0

dnf install -y wget rpm-build cabextract ttmkfdir
count=0;
# try to build rpm fonts - sometimes download stops, so we try 10 times
while [ ! -f /root/rpmbuild/RPMS/noarch/msttcorefonts-2.5-1.noarch.rpm ] && [ $count -lt 10 ]
do 
     echo "Building msttcorefont package, please wait..."
     rpmbuild -bb /root/rpmbuild/spec/msttcorefonts-2.5-1.spec 2>&1 >/dev/null
     count=$((count+1))
done || exit 1

# now install core font package
echo "Installing msttcorefonts..."
dnf install -y /root/rpmbuild/RPMS/noarch/msttcorefonts-2.5-1.noarch.rpm
rm -rf /root/rpmbuild
dnf clean all 
touch /.msttcorefont-installed
exit 0
