- Windows Server
    - Dominios (con más de un controlador).
    - Relaciones de Confianza (entre dominios). Para trabajar entre empresas, departamentos...
    - CORE (Si establecemos dos dominios con CORE no pueden establecer relación de confianza). Utilizaremos PowerShell
    - CLUSTER

- Heterogéneos
    - Cliente (linux) -> Server Windows
    - Cleinte Windows -> AD GNU/Linux

- Scripting
    - PowerShell
    - Bash

- Alternativas a la virtualización estándar (containers, reducen recursos)
    - Docker. En vez de virtualizar la máquina completa, virtualiza los servicios.
    - Vagrant. Permite desplegar boxes para su posterior descarga.

Intentaremos utilizar isos más actualizadas. Windows 10 Pro y windows 2019 server.

Usar Cortana para ejecutar comandos. Idea de proyecto.

OOBE: Out of the box experience

Priemra práctica:

Necesitaremos 3 máquinas:

- Win 2019 server GUI
- Win 2019 server CORE
- Win 10 Pro

Vamos a tener un dominio (lrr.local) con 2 controladores de dominio (dc1 GUI y dc2 CORE) y una máquina cliente (WS1 (workstation))

Comando de interés: nslookup

Promocionamos DC! y unimos WS1 al dominio. Apagamos el cliente, dejamos el servidor encendido y unimos el dc2, al que también tenemos que condigurar como controlador DNS