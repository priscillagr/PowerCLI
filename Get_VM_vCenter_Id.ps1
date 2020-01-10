<#
Esse script irá resgatar o ID de vCenter das máquinas virtuais presentes no arquivo vmnames.txt.
#>


Connect-VIServer -Server vcenter.local -User administrator@vsphere.local -Password 'heuheuheueh'
$arrayVMs = @()

foreach($vmName in (Get-Content -Path C:\Users\vmnames.txt)){
   $name = Get-VM -Name $vmName
   $id = $name.Id
   $arrayVMs += $name
   Write-Host "                        "
   Write-Host "########################"
   Write-Host "                        "
   Write-Host "VM: " $name
   Write-Host "ID: " $id
   Write-Host "                        "
  
}

$arrayVMs | Select Name,Id | Export-Csv C:\Users\\VCENTER_ID.csv -NoTypeInformation
