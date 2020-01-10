<#
Esse script irá trocar a configuração de load balacing dos port groups para IP HASH descritos 
em um arquivo .txt.
#>


Connect-VIServer -Server vcenter.local -User administrator@vsphere.local -Password 'heuheuhe'
$VDS = 'VDS_PROD'
$tamanho = Get-Content -Path C:\Users\DPG.txt
$i = 1

foreach($DPG in (Get-Content -Path C:\Users\DPG.txt)){
 Write-Host 'Configurando ' $i ' de ' $tamanho.Length
 Write-Host 'Configurando DPV ' $DPG
 Get-vdswitch $VDS | Get-VDPortgroup $DPG | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -LoadBalancingPolicy 'LoadBalanceIP'
 $i += 1
}
