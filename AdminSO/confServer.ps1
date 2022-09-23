#script de configuración de equipo, hostname, red y SSH

param($newhostname="",$ifalias="Ethernet",$ipaddress="",$prefixlength="16",$defaultgateway="",$dnsservers="172.16.100.101,172.16.100.102,1.1.1.1",[switch]$ssh,[switch]$CredentialConsole,[switch]$WhatIf)

#set new hostname

if ($newhostname -ne "")
{

  Rename-Computer -NewName $newhostname -Confirm:$False
  
}

if ($ipaddress -ne "")
{

  #borrado de la configuracion actual
  Remove-NetIPAddress -InterfaceAlias $ifalias -Confirm:$false
  Set-NetIPInterface -InterfaceAlias $ifalias -Dhcp Disabled -Confirm:$false
  Remove-NetRoute -InterfaceAlias $ifalias -Confirm:$false
  Set-DnsClientServerAddress -InterfaceAlias $ifalias -ResetServerAddresses

  #asignacion de configuracion nueva
  if($defaultgateway -eq "")
  {
    
    New-NetIPAddress -InterfaceAlias $ifalias -IPAddress $ipaddress -PrefixLength $prefixlength -Verbose:$false

  }
  else
  {

    New-NetIPAddress -InterfaceAlias $ifalias -IPAddress $ipaddress -DefaultGateway $defaultgateway -PrefixLength $prefixlength -Verbose:$false

  }

  Set-DnsClientServerAddress -InterfaceAlias $ifalias -ServerAddresses $dnsservers

  #informacion de la configuracion
  Get-NetIPConfiguration -InterfaceAlias $ifalias -Detailed

}


#instalacion de SSH server
if ($ssh)
{

    #Primero abrimos los puertos 
    New-NetFirewallRule -DisplayName "SSH ALLOW TCP PORT 22" -Direction inbound -Profile Any -Action Allow -LocalPort 22 -Protocol TCP
    New-NetFirewallRule -DisplayName "ALLOW ping" -Direction inbound -Profile Any -Action Allow -Protocol ICMPv4 -IcmpType 8

    #Instalamos el servicio de SSH
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    Start-Service sshd
    Set-Service -Name sshd -StartupType 'Automatic'
}

if ($CredentialConsole)
{

  Set-ItemProperty -Path "HKLM:/SOFTWARE/Microsoft/PowerShell/1/ShellIDS" -Name ConsolePrompting -Value $True

}

#powershell como interperete por defecto [util para Core]
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name Shell -Value 'PowerShell.exe -NoExit'