$csv = Import-Csv "usuarios_grupos.csv"

$nombre = ""

$grupo = ""

$gp = ""

$userexists = Get-ADUser -Filter {SamAccountName -eq $nombre}

$grupo = Get-ADPrincipalGroupMembership $gp

$groupexists = Get-ADGroup -Filter {Identity -eq $gp}

foreach($line in $csv){

    $nombre = $line.nombre

    $gp = $line.grupo

    $pswd = $line.password

    $pass = ConvertTo-SecureString $pswd -AsPlainText -Force

    if(!$userexists){
    
        New-ADUser -Name $nombre -SamAccountName $nombre -AccountPassword $pass -Enabled 1

        <#Comprobar si pertenece a algún grupo y si este es el del csv, si no, comprobar que el grupo del csv existe y añadirlo y en caso de no existir, crear el grupo#>
        if(!$grupo){
        
            if(!$groupexists){
            
                New-ADGroup -Identity $gp -GroupScope DomainLocal -Confirm:$false

                Add-ADGroupMember -Identity $gp -Members $nombre
            
            }

            else{
            
                Add-ADGroupMember -Identity $gp -Members $nombre
            
            }
        
        }

        else{
        
            Write-Output "El usuario ya pertenece al grupo"
        
        }
    
    }

    else{
    
        if(!$grupo){
        
            if(!$groupexists){
            
                New-ADGroup -Identity $gp -GroupScope DomainLocal -Confirm:$false

                Add-ADGroupMember -Identity $gp -Members $nombre
            
            }

            else{
            
                Add-ADGroupMember -Identity $gp -Members $nombre
            
            }
        
        }

        else {
        
            Write-Output "El usuario $($nombre) ya existe y pertenece al grupo $($gp)"
        
        }
    
    }

}



<#
New-ADUser -Name $nombre -SamAccountName $nombre -AccountPassword $thepass -Enabled 1

Write-Output "Se ha creado el usuario $nombre correctamente"

$thepass=ConvertTo-SecureString $password -AsPlainText -Force#>

<#

Get-ADGroup -Filter 


#>