#!/bin/sh 

#1. Limpieza previa

iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#2. Politicas por defecto 

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#3. Permitir localhost

iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT

#4. Permitir trafico establecido y relacionado 

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#5. Permitir SSH desde el terminal admin

iptables -A INPUT -p tcp -s 10.1.3.253 --dport 22 -j ACCEPT

#6. Permite HTTP desde Contabilidad

iptables -A INPUT -p tcp -s 10.1.1.0/24 --dport 80 -j ACCEPT

#7. Permitir DNS saliente 

iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#8. Permitir HTTP/HTTPS para actualizaciones

iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
