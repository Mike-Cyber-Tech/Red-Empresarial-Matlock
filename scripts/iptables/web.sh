#!/bin/sh 

#Limpieza de las reglas <<iptables>> existentes

iptables -F
iptables -X
iptables -Z
iptables -t nat -F

#Politicas por defecto que se aplicaran

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#Acepta todo el trafico para el LOCALHOST  

iptables -A INPUT -s 127.0.0.1 -j ACCEPT
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT

#Permitir trafico ESTABLECIDO y RELACIONADO

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#Acepto todo el trafico entrate en el puerto: 80 (Server WEB Externo) 

iptables -A INPUT -p tcp --dport 80 -j LOG --log-level 4 --log-prefix "[Firewall-Server-Web HTTP]"

iptables -A INPUT -p tcp --dport 80 -j ACCEPT 
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT 
iptables -A INPUT -p udp --dport 80 -j ACCEPT 
iptables -A OUTPUT -p udp --dport 80 -j ACCEPT 

iptables -A INPUT -p tcp --dport 443 -j LOG --log-level 4 --log-prefix "[Firewall-Server-Web HTTPS]"

iptables -A INPUT -p tcp --dport 443 -j ACCEPT 
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT 
iptables -A INPUT -p udp --dport 443 -j ACCEPT 
iptables -A OUTPUT -p udp --dport 443 -j ACCEPT 


#Acepta la conexion del trafico al Servidor 3 por el Puerto 22

iptables -A INPUT -p tcp -s 10.1.0.2 --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp -d 10.1.0.2 --sport 22 -j ACCEPT

#Acepta el trafico desde la LAN 2

#iptables -A INPUT -p tcp -s 10.1.0.2/24 -d 10.2.0.2 --dport 80 -j ACCEPT
#iptables -A OUTPUT -p tcp -s 10.2.0.2 -d 10.1.0.2/24 --sport 80 -j ACCEPT

#iptables -A INPUT -p tcp -s 10.1.0.2/24 -d 10.2.0.2 --dport 443 -j ACCEPT
#iptables -A OUTPUT -p tcp -s 10.2.0.2 -d 10.1.0.2/24 --sport 443 -j ACCEPT
 
#Acepta conexion SSH Interior RED LAN 2


#iptables -A INPUT -p tcp -s 10.1.0.2/24 -d 10.2.0.2 --dport 22 -j ACCEPT
#iptables -A OUTPUT -p tcp -s 10.2.0.2 -d 10.1.0.2/24 --sport 22 -j ACCEPT


#Registro de conectividad HONEYPOT

iptables -A INPUT -p tcp -m multiport --dport 1:21 -j LOG --log-level 4 --log-prefix "[Firewall-HONEYPOT]"
iptables -A INPUT -p tcp -m multiport --dport 23:79 -j LOG --log-level 4 --log-prefix "[Firewall-HONEYPOT]"
iptables -A INPUT -p tcp -m multiport --dport 79:1024 -j LOG --log-level 4 --log-prefix "[Firewall-HONEYPOT]"

#Permitir DNS

iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p udp --sport 53 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT 
