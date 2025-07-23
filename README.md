**Infraestructura de Red – Matlock S.A**

Este proyecto presenta la simulación e implementación técnica de la infraestructura de red de la empresa ficticia "Matlock S.A", diseñada como parte del módulo de formación en Ciberseguridad Básica (CR-25-002) en colaboración con la Universidad de Extremadura e INCIBE.

La propuesta va más allá de una simple documentación estática, incluyendo un entorno de laboratorio virtualizado, documentación interactiva y una demostración en video publicada en YouTube, con el objetivo de ser un proyecto demostrativo y portafolio profesional.

---

**Objetivo**

Migrar de un entorno disperso y sin control a una infraestructura de red LAN estructurada, segura y funcional, implementando servicios internos y externos, segmentación de red, seguridad perimetral y gestión de usuarios en una empresa simulada dedicada al asesoramiento legal en tecnologías emergentes.

---

**Componentes Implementados**

* Firewalls OPNsense (Primario y Secundario)
* Servidor Web Apache2
* Servidor SFTP/SSH
* Servidores Internos para copias de seguridad, base de datos y gestión
* Terminales por departamento: Contabilidad y Fiscal
* Topología en subredes segmentadas
* Plan de pruebas con herramientas como netstat, iptables, ssh

---

**Demostración en YouTube**

Video explicativo donde se pone a prueba todo el entorno:

\[Enlace al video en YouTube]

---

**Estructura del Repositorio**

```
infraestructura-red-matlock/
│
├── docs/                    # Documentación técnica del proyecto
│   ├── topologia/           # Diagramas de red (PNG y .drawio)
│   ├── configuraciones/     # Configuraciones de firewall, servicios, red
│   ├── pruebas/             # Plan de pruebas y evidencias
│   │   ├── plan_pruebas.txt # Este archivo contiene el plan de pruebas detallado
│   │   └── capturas/        # Capturas de pantalla de los resultados
│   └── inventario/          # Equipos, precios y detalles del hardware
│
├── vms/                     # Configuración de las máquinas virtuales
│   ├── terminales/          # Terminales de contabilidad y fiscal
│   └── servidores/          # Servidores web, internos y SFTP
│
├── scripts/                 # Scripts de instalación o automatización (bash)
│   └── instalacion.sh       # Script opcional para levantar servicios
│
├── LICENSE                  # Licencia MIT del proyecto
├── README.md                # Descripción principal del proyecto
└── .gitignore               # Archivos que Git debe ignorar
```

---

**Topología y Segmentación de Red**

Red LAN Segmentada por zonas de seguridad:

* LAN Principal: 10.1.0.0/24
* Servidores Externos: 10.2.0.0/24
* Red Contabilidad: 10.1.1.0/24
* Red Fiscal: 10.1.2.0/24
* Servidores Internos: 10.1.3.0/24

(Se incluye diagrama lógico-físico en la carpeta docs/topologia)

---

**Seguridad y Configuraciones**

* Reglas NAT y filtrado configuradas en OPNsense
* Segmentación por subredes y zonas de confianza
* iptables con reglas de denegacion por defecto
* Aislamiento de áreas internas y servicios públicos

---

### Plan de Pruebas

```
PLAN DE PRUEBAS DE CONECTIVIDAD Y SEGURIDAD – PROYECTO MATLOCK S.A

Objetivo:
Validar la segmentación de red, seguridad perimetral y funcionamiento de servicios
dentro de la red simulada según el diseño propuesto.

-------------------------------------------------------
1. Pruebas de Servicios Web
-------------------------------------------------------
[✓] Acceso HTTP (puerto 80) al servidor web externo desde terminal  → Página debe cargar
[✓] Acceso HTTP desde Internet simulado al servidor web externo     → Página debe cargar

-------------------------------------------------------
2. Pruebas SSH y SFTP
-------------------------------------------------------
[✓] SSH desde terminal de Contabilidad a su servidor                → Conexión exitosa
[✓] SSH desde terminal de Fiscal a su servidor                      → Conexión exitosa
[✓] SSH entre departamentos (ej. Fiscal → Contabilidad)             → Debe FALLAR
[✓] SFTP desde terminal a servidor SFTP externo                     → Transferencia permitida (autenticación)

-------------------------------------------------------
3. Pruebas de Bases de Datos (MariaDB)
-------------------------------------------------------
[✓] Acceso a MariaDB (puerto 3306) desde terminales internas        → Conexión exitosa
[✓] Acceso desde Internet al puerto 3306                            → Debe FALLAR

-------------------------------------------------------
4. Pruebas de Firewall y Aislamiento
-------------------------------------------------------
[✓] Escaneo de puertos desde Internet hacia LAN2                    → Debe ser bloqueado
[✓] Acceso al servidor Jellyfin (puerto 8096) desde terminales      → Acceso exitoso
[✓] Acceso al servidor Jellyfin desde Internet                      → Debe FALLAR

-------------------------------------------------------
5. Pruebas de Reglas NAT
-------------------------------------------------------
[✓] NAT puerto 80 hacia servidor web externo                        → Redirección correcta
[✓] NAT puerto 22 hacia servidor SFTP externo                       → Redirección correcta
[✓] Validación de NAT para SSH internos                             → Solo accesos autorizados

-------------------------------------------------------
6. Pruebas de Acceso a Internet
-------------------------------------------------------
[✓] Acceso a Internet desde terminales internos                     → Permitido
[✓] Acceso a Internet desde servidores internos                     → Permitido según reglas

-------------------------------------------------------

Resultado Esperado:
Todas las políticas de acceso y segmentación deben cumplirse. Cualquier acceso no autorizado
debe ser denegado por los firewalls. Los servicios permitidos deben estar disponibles 
según la topología y reglas NAT aplicadas.
```

---
```
**Tecnologías Utilizadas**

* Linux Debian
* Apache2, MariaDB, SSH
* OPNsense Firewall
* VirtualBox 
* CLI (Linea de Comando de Linux) y scripts Bash

---

**Inventario Simulado**

Componente: Cisco Switch 24 puertos
Cantidad: 1
Descripción: Switch administrable de alto rendimiento

Componente: Servidor MySQL
Cantidad: 1
Descripción: Intel Xeon, 32GB RAM, Ubuntu Server

Componente: Servidor SFTP
Cantidad: 1
Descripción: Debian con RAID1, transferencia segura

Componente: Workstations oficina
Cantidad: 6
Descripción: Intel Core i5, 16GB, SSD, Ubuntu o Windows

Componente: Workstations sucursal
Cantidad: 3
Descripción: AMD Ryzen 5, 8GB, SSD

Componente: Firewall OPNsense
Cantidad: 2
Descripción: Reglas de control y filtrado

Componente: SAI
Cantidad: 1
Descripción: UPS 3000VA para respaldo energético

Componente: Periféricos, racks, monitores
Cantidad: varios
Descripción: Soporte físico de red y estaciones

Presupuesto estimado total: 12.500 €
```
---

**Cómo Reproducir el Proyecto**

1. Clonar el repositorio desde GitHub:
   git clone [https://github.com/tuusuario/infraestructura-red-matlock.git](https://github.com/tuusuario/infraestructura-red-matlock.git)

2. Revisar la documentación en la carpeta "docs/"

3. Levantar las máquinas virtuales según indicaciones

4. Aplicar configuraciones de red, firewalls y servicios

5. Realizar pruebas descritas y validar resultados

6. Ver el video en YouTube como guía visual

---

**Autor**

Desarrollado por: \Mike-Cyber-Tech
GitHub: [https://github.com/Mike-Cyber-Tech](https://github.com/Mike-Cyber-Tech)


---

**Licencia**

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo LICENSE para más información.
