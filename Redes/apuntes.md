# Unidades didácticas

1- Instalación y configuración de un servicor DHCP
2- Instalación y configuración de un servidor DNS
3- Instalación y configuración de servidores Web
4- Instalación y configuración de servidores FTP
5- Instalación y configuración de Servicios de Control Remoto
6- Instalación y configuración de Servicios de Correo Electrónico

Criterios de cualificación:
- Ejercicios en clase. Cuaderno de prácticas -> 40%
- Control (Examen tipo test + práctica en el ordenador) -> 25%
- Prueba de evaluación (Examen tipo test + práctica en el ordenador) -> 35%



## Características Windows Server (Virtualizado)

- HDD: 100GB
- Memoria: 3GB
- Tarjetas de Red: Bridge y Host-Only 
    - IP: 192.168.0.118
    - Máscara: 255.255.0.0
    - Gateway: 192.168.0.100

(Número de clase: 18)

(Pass server: abc123.)

La que pone Red es la tarjeta puente.

Accedemos a "Administrar" > "Agregar roles o características"; instalamos lo que viene por defecto + servidor DHCP

"Herramientas" > "DHCP", nos abre una aplicación mmc (Microsoft Management Console).

Trabajaremos en IPv4.

Ejemplo: Configurar servidor DHCP con las siguienres características: 
- Rango de Direcciones: (trabajaremos con la red interna: hostonly) 10.0.0.10 - 10.0.0.100; Máscara: 255.255.255.0; Puerta de enlace: 10.0.0.1; DNS: 8.8.8.8; 10.0.0.1

Click derecho sobre IPv4 > "Ámbito nuevo..."

Nos pide nombre del ámbito, en este caso será "Ejemplo1"

Exclusiones: Si dentro del rango que ponemos queremos reservar algunas IPs 
Dominio primario: dominio de búsqueda