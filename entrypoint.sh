#!/bin/bash

# append proxy in dnf config if env var is set
if [ "$http_proxy" != "" ]; then
    grep "proxy" /etc/dnf/dnf.conf || echo "proxy=$http_proxy" >> /etc/dnf/dnf.conf
fi

# check if user accepts EULA to use microsoft core font
if [ "$ACCEPT_MSCOREFONT_EULA" == "yes" ]; then
    echo "You set ACCEPT_MSCOREFONT_EULA to yes, that means you accepted the EULA"
    echo "you've readed at http://corefonts.sourceforge.net/eula.htm"
    echo "If you decide to not accept the licence agreement, please remove the container and"
    echo "restart container creation without the ACCEPT_MSCOREFONT_EULA environment variable."
    sleep 5
    bash /opt/msfont.sh
fi

exec "$@"
