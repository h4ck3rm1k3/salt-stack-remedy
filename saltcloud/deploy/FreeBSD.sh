#!/bin/sh

sed -i 's/jot -r 1 0 3600/jot -r 1 0 3/' /usr/sbin/portsnap
portsnap cron extract update
sed -i 's/jot -r 1 0 3/jot -r 1 0 3600/' /usr/sbin/portsnap
cd /usr/ports/ports-mgmt/pkg
make install clean
cd
/usr/local/sbin/pkg2ng
echo 'PACKAGESITE: http://pkgbeta.freebsd.org/freebsd-9-amd64/latest' > /usr/local/etc/pkg.conf
/usr/local/sbin/pkg install -y salt
mkdir -p /etc/salt/pki
echo '{{ vm['priv_key'] }}' > /usr/local/etc/salt/pki/minion.pem
echo '{{ vm['pub_key'] }}' > /usr/local/etc/salt/pki/minion.pub
echo '{{ minion }}' > /usr/local/etc/salt/minion
salt-minion -d

