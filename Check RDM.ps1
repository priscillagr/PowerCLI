<#
Esse script irá verificar em todos os datastores do ambiente quais que possuem
discos RDM. Irá entregar três relatórios:
Not_Migrate.csv = Qual datastore não será possivel esvaziar sem downtime de alguma VM.
Migrate.csv = Datastores que dá para esvaziar sem downtime.
VMs_RDM.csv = Máquinas Virtuais com RDM.
VM_RDM_details.csv = Mais informacoes de discos RDM e VMs.
#>


Connect-VIServer -Server 

$Datastores = Get-Datastore
$notMigrateDS = @()
$migrateDS = @()
$vmsRDM = @()
$detailsVM = @()

Foreach ($Datastore in $Datastores) {
 Write-Host "Analisando o datastore " $Datastore
 $flag = 0
$VMs = Get-Datastore $Datastore | Get-VM
Foreach ($VM in $VMs){
$Disks = Get-VM $VM | Get-HardDisk
#Write-host "A VM " $VM.Name " tem " $Disks.Length " discos."
Foreach ($Disk in $Disks){
if ($Disk.DiskType -like "Raw*")
{
 #Write-Host "Disco: " $Disk.Name " eh um RDM"
 $flag = 1
 $vmsRDM += $VM
}

else {
 #Write-Host "Nao tem RDM"
}
}
}

if ($flag -eq "0") {
Write-Host "O datastore " $Datastore " tem RDM. "
$migrateDS += $Datastore
}

if ($flag -eq "1") {
Write-Host "O datastore " $Datastore " tem RDM. "
$notMigrateDS += $Datastore
}

}

Write-Host "Temos " $vmsRDM.Length " para checar."
$i = 0
Foreach ($VM in $vmsRDM){
$detailsVM += $VM | Get-HardDisk | Where-Object {$_.DiskType -like “Raw*”} | Select @{N=”VMName”;E={$_.Parent}},Name,DiskType,@{N=”LUN_ID”;E={$_.ScsiCanonicalName}},@{N=”VML_ID”;E={$_.DeviceName}},Filename,CapacityGB
$i +=
Write-Host "VM " $i " de " $vmsRDM.Lenght
}


$notMigrateDS | Select Name, FileSystemVersion | Export-Csv -Path C:\Not_Migrate.csv
$migrateDS | Select Name, FileSystemVersion | Export-Csv -Path C:\Migrate.csv
$vmsRDM | Select Name, @{N="Datastore";E={Get-Datastore -VM $_}} | Export-Csv -Path C:\VMs_RDM.csv
$detailsVM | Export-Csv C:\VM_RDM_details.csv -NoTypeInformation
