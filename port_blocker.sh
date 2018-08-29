#!/bin/sh

if [ $# -ne 3 ]; then
        echo "Usage: $0 [tcp|udp] [block|unblock] port"
        exit 1
fi
port=$3
if [ $2 = "block" ]; then
        if [ $1 = "tcp" ]; then
                iptables -A INPUT -p tcp --destination-port $port -j DROP
                iptables -L -n -v | grep -i DROP
        else
                iptables -A INPUT -p udp --destination-port $port -j DROP
                iptables -L -n -v | grep -i DROP
        fi

else
        if [ $1 = "tcp" ]; then
                iptables -D INPUT -p tcp --destination-port $port -j DROP
        else
                iptables -D INPUT -p udp --destination-port $port -j DROP
        fi
        iptables -L -n -v | grep -i DROP
fi
