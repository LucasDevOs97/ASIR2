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

OOBE: Out of the box experience

Priemra práctica:

Necesitaremos 3 máquinas:

- Win 2019 server GUI
- Win 2019 server CORE
- Win 10 Pro

Vamos a tener un dominio (lrdom.local) con 2 controladores de dominio (dc1 GUI y dc2 CORE) y una máquina cliente (WS1 (workstation))

Comando de interés: nslookup

Promocionamos DC1 y unimos WS1 al dominio. Apagamos el cliente, dejamos el servidor encendido y unimos el dc2, al que también tenemos que condigurar como controlador DNS.

En el core la promoción se puede hacer de forma interactiva y de forma no interactiva (más recomendada).

Características de las máquinas:

- DC01:2GB

- DC02: 1GB

- W10- W11: 2-3 GB

Opciones para las tarjetas de red:
- Bridge
- NAT + Host-Only

192.168.200.018 -> IP
255.255.0.0

127.0.0.1,1.1.1.1

Hostname del servidor con GUI: ServerLRR

Remove-NetRoute -InterfaceAlias Ethernet -confirm:$false

Buscar como configurar el core para que se abra con powershell (tenemos que cambiar el valor de registro):
- Abrir powershell
- Ejecutar el siguiente comando:
    - Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\WinLogon' -Name Shell -Value 'PowerShell.exe'
- Después tendremos que reiniciar y ya debería abrirse PowerShell (Restart-Computer -Force)

Una vez tenemos configurados los parámetros de la red del servidor, ya podemos promocionarlo a Domain Controller; pero antes configuraremos el SSH:
- Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
- Start-Service sshd
- Set-Service -Name sshd -StartupType 'Automatic'
- New-NetFirewallRule -DisplayName "SSH ALLOW TCP PORT 22" -Direction inbound -Profile Any -Action Allow -LocalPort 22 -Protocol TCP
- New-NetFirewallRule -DisplayName "ALLOW ping" -Direction inbound -Profile Any -Action Allow -Protocol ICMPv4 -IcmpType 8

Comandos para promocionar a DC:
- Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
- Test-ADDSForestInstallation
- Install-ADDSForest
- Add-ADDSForest

//$credenciales="ANTONIO\Administrator"
Install-ADDSDomainController -DomainName "antonio.cao" -InstallDns -Credential (get-credential $credenciales)  -DatabasePath "C:\ADDS\DB" -LogPath "C:\ADDS\Log" -SysvolPath "C:\ADDS\SYSVOL"//

Manage > ADD Roles And Features > Role-Based or Feature-Based installation

En el servidor GUI para promocionar a DC lo hacemos desde añadir roles y características, en roles tenemos que seleccionar servidor DNS y servicio de dominio de Active Directory

- Nombre dominio: lucas.local
- Nombre de Dominio NetBios: LUCAS
- Rutas de acceso: 
    - Base de datos y archivos de registro: C:\\Windows\NTDS
    - SYSVOL: C:\\Windows\SYSVOL

CREDENCIALES: 
    - Por SSH no funciona el -Credential (get-credential), hay dos posibles soluciones:
        - modificar Get-Credential para que lo pida por consola
        - Guardar las credenciales y exportarlas a un archivo

Configuración de Red del CORE:

- IP y Máscara: 192.168.200.118/16
- Gateway: 192.168.0.100
- DNS: 127.0.0.1, 192.168.200.18

Set-ItemProperty "HKLM:/Software/Microsoft/PowerShell/1/ShellIDS" ConsolePrompting $true -> Para pedir las credenciales por consola.

Configuración de Red del Cliente:

IP -> 192.168.200.119/16   
Default gateway-> 192.168.0.100

DNS:
- 192.168.200.18
- 192.168.200.118


Usuario de la máquina cliente: prueba1


Página de interés: chocolatey

Acronis true image   

Crear otro dominio distinto en el CORE

Reenviadores condicionales (Conditional Forwarders), cuando las máquinas se resuelven es cuando establecemos la relación de confianza

Configuración de red:
- 192.168.200.218/16
- 192.168.0.100
- 127.0.0.1,1.1.1.1

Comandos:
- Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
- Install-ADDSForest -DomainName lucasramos.local -ForestMode Win2016 -DomainMode Win2016 -DomainNetbiosName LUCASRAMOS -InstallDns:$true 


- Import-Module ADDSDeployment



wmic computersystem get domain