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

iptables -A INPUT -p tcp -s 10.1.3.253 --dport 22 -m state --state NEW -j ACCEPT

#6. Permite MySQL desde los DPTOs (redes  de Contabilidad y Fiscal)

iptables -A INPUT -p tcp -s 10.1.1.0/24 --dport 3306 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -s 10.1.2.0/24 --dport 3306 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -s 10.1.3.0/24 --dport 3306 -m state --state NEW -j ACCEPT

#Nota: No se necesitan las reglas OUTPUT con el --dport 3306 si ya tengo las reglas  ESTABLISHED 
#las respuestas salientes se permitirian automaticamente con la regla OUTPUT de estado.

#7. Permitir DNS saliente 

iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

#8. Permitir HTTP/HTTPS para actualizaciones

iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
