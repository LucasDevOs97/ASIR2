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
    - Podemos hacerlo desde la herramienta DHCP, dentro del ámbito, en la carpeta de conjunto de direcciones, hacemos click derecho y le damos a Nuevo intervalo de exclusión.

Reservas: Asignar siempre la misma IP. Reconoce al equipo a través de la MAC.

Dominio primario: dominio de búsqueda

Vamos a asignarle la IP 10.0.0.25 a la máquina cliente:

- Priemro vamos a la máquina cliente y miramos la MAC, esto podemos hacerlo desde la interfaz de la red o desde consola con el comando ipconfig /all

- Ahora hacemos click derecho en la carpeta de Reservas > Añadir nueva reserva...
    - Nos pide un nombre para la reserva, la IP que le queremos dar y la MAC de la máquina

Cuando añadimos más ámbitos hay que tener cuidado con que los rangos no se superpongan

En el ejercicio tenemos que cambiar la IP y la máscara de red interna (host-only) 15.0.0.1 255.255.0.0

