Import-Csv -Path .\control.csv -Delimiter ";" | ft

param($Path)

# Importación de los grupos
# ExpandProperty devuelve solo el valor, no devuelve el objeto, que es lo que hace el Select-Object sin el Expand
Import-Csv -Path $Path -Delimiter ";" -Encoding UTF8 | Select-Object -ExpandProperty group -unique | ForEach-Object {New-ADGroup -Name $_ -GroupScope DomainLocal -WhatIf}

#Importación de los usuarios
$ThePassword = ConvertTo-SecureString 0000.Abcd -AsPlainText -Force
Import-Csv -Path $Path -Delimiter ";" -Encoding UTF8 | ForEach-Object {

    New-ADUser -Name $_.Name -Surname %_.Surname -DisplayName $_.displayname -SamAccountName $_.samaccountname -AccountPassword $ThePassword -Enable $true -AccountExpirationDate "01/01/2023" -WhatIf

    Add-ADGroupMember -Identityp $_.group -Members $_.samaccountname -WhatIf

}






