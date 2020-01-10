<#
Esse script irá trocar a configuração de teaming failover dos port groups descritos 
em um arquivo .txt. Esse script em especifico coloca o LAG como uplink.
#>

Connect-VIServer -Server vcenter.local -User administrator@vsphere.local -Password 'kkkkkk'
$VDS = 'vDS_PRODUCAO'
$tamanho = Get-Content -Path C:\Users\DPG.txt
$i = 1

foreach($DPG in (Get-Content -Path C:\Users\DPG.txt)){
 Write-Host 'Configurando ' $i ' de ' $tamanho.Length
 Write-Host 'Configurando DPV ' $DPG
 Get-vdswitch $VDS | Get-VDPortgroup $DPG | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -UnusedUplinkPort 'Uplink 1'
 Get-vdswitch $VDS | Get-VDPortgroup $DPG | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -UnusedUplinkPort 'Uplink 2'
 Get-vdswitch $VDS | Get-VDPortgroup $DPG | Get-VDUplinkTeamingPolicy | Set-VDUplinkTeamingPolicy -ActiveUplinkPort 'LAG_PRD'
 $i += 1
}
