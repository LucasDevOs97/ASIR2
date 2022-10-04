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


# Instalación y configuración de un servidor DHCP

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


## Configuración servidor Linux

HDD: 100GB 
Memoria 3GB
Dos tarjetas de red:
    - Host-Only
    - Bridge

Nombre de usuario: lucas
pass: abc123.

Deshabilitar LVM

### Configuración de Red

El archivo de configuración está basado en YAML, hay que tener mucho cuidado con los indentados

Host-Only: 10.0.0.1 - 255.255.255.0
Bridge: 192.168.0.118 - 255.255.0.0 - 192.168.0.100 - 8.8.8.8

Después de cambiar la IP hay que ejecutar el comando: netplan apply

¿Cómo saber qué tarjetas de red son?
> ip a
La priemra que nos sale es un loopback
La segunda es la externa (bridge) -> enp0s3
La tercera es la interna (host-only) -> enp0s8

> sudo su -> modo administrador

Para configurar la red tenemos que hacer lo siguiente:
- Movernos al directorio /etc/netplan
- Hacemos una copia de seguridad del archivo por si acaso: cp 00-installer-config.yaml 00-installer-config.yaml.backup
- Ahora editamos el archivo, donde veremos las dos tarjetas que vimos antes con el comando ip a (ctrl + o para guardar, ctrl + x para salir)

Herramientas para conectarnos en remoto: PuTTy, nRemoteNG

### Linux Instalación de Software

comando apt:
- apt update: actualiza los repositorios.
- apt upgrade: actualiza el software.
- apt install <paqueteSoftware>: instalación de software (paquetes).
- apr autoremove: elimina software no utilizado, residual.
- apt dist-upgrade: actualiza el SO a una nueva versión.

### Configurar Servidor DHCP

Servidor DHCP: isc-dhcp-server

- Entramos con sudo su y ejecutamos el comando: apt install isc-dhcp-server

Tenemos 2 tarjetas de red, una que va a la red externa (puente: enp0s3) y otra que va a la red interna (solo anfitrión: enp0s8). Para hacer las pruebas utilizaremos la red interna.
Por defecto usa todas las tarjetas disponibles en el sistema, por lo que en el archivo de configuración le tendremos que indicar cuál queremos. Para ello tenemos que saber el nombre de cada tarjeta (ip a).

- nano /etc/default/isc-dhcp-server
- cd /etc/dhcp

El archivo que nos interesa es el archivo: dhcpd.conf (v4)
Primero creamos una copia por lo que pueda ocurrir:
- cp dhcpd.coon dhcpd.conf.backup

Configurar servicio DHCP con los siguientes parámetros:
    - Rango Direcciones: 10.0.0.10 - 10.0.0.100
    - Máscara: 255.255.255.0
    - Router (Ruta Enlace): 10.0.0.1
    - DNS: 10.0.0.1,8.8.8.8,1.1.1.1

Una vez configurado el ámbito, hay que reiniciar el servicio con (hay 2 formas):
    - service <nombreServicio> <accion>
    - systemctl (se empieza a usar más ahora) <accion> <nombreServicio>
    - Las acciones pueden ser:
        - Start: iniciar
        - Stop: Parar
        - Restart: Reiniciar
        - Reload: Recarga el servicio
        - Status: información sobre el estado

Para ver los errores hay que comprobar el fichero de log (auditoría) del sistema: /var/log/syslog (utilizar tail qe por defecto pone las últimas 10 líneas). El comando quedaría así:
    - tail [-n] /var/log/syslog
        - [-n]: opcional, número de líneas que queremos que muestre.

# Instalación y configuración de un servidor DNS

Cuando buscamos en el navegador, lo que hace es preguntarle al servidor DNS y le devuelve la máquina.