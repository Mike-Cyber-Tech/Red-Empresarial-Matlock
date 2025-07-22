#!/bin/sh 

#Limpieza de las reglas <<iptables>> existentes

iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#Politicas por defecto que se aplicaran

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FOWARD DROP

#<<Lista de seguridad para accesos fijos>>

#Acepta todo el trafico entrante en el puerto 22 (Server SFTP Externo)

iptables -A INPUT -p tcp --dport 22 -j LOG --log-level 4 --log-prefix "[Firewall Puerto 22]"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

iptables -A INPUT -p udp --dport 22 -j ACCEPT
iptables -A OUTPUT -p udp --sport 22 -j ACCEPT

#Permitimos Conexiones salientes a través del interfeaz de la red

iptables -A OUTPUT -o enp0s3 -p tcp --sport 1024:65535 -j ACCEPT
iptables -A OUTPUT -o enp0s3 -p udp --sport 1024:65535 -j ACCEPT

#Permitimos consultas DNS  
iptables -A OUTPUT -o enp0s3 -p udp --sport 1024:65535 --dport 53 -m state --state NEW -j ACCEPT 

#Permite conexiones entrates que estén relacionadas o establecidas anteriormente
iptable -A INPUT -i enp0s3 -m state --state ESTABLISH,RELATED -j ACCEPT


