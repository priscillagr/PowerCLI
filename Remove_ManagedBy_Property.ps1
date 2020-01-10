<#
Esse script irá remover a propriedade ManagedBy das máquina virtual descritas no arquivo vmnames.txt. 
Exemplos de ManagedBy: 
-ManagedBy vCloud Director
-ManagedBy SRM
-ManagedBy VIC
#>

Set-ExecutionPolicy -scope CurrentUser -ExecutionPolicy RemoteSigned
Connect-VIServer -Server vcenter.local -User administrator@vsphere.local -Password 'kkkehuehueessasenhaérealpodeconfiar'

#Essa parte do codigo ira configurar o SPEC vazio que iremos colocar na VM.

$extensionKey = ""
$managedType = ""

$spec = New-Object VMware.Vim.VirtualMachineConfigSpec
$manBy = New-Object VMware.Vim.ManagedByInfo
$spec.ManagedBy = $manBy
$manBy.Type = $managedType
$manBy.ExtensionKey = $extensionKey

#Essa parte do script irá trocar o spec da VM para o nosso spec vazio.

foreach($vmName in (Get-Content -Path C:\Users\vmnames.txt)){
   $name = Get-VM -Name $vmName
   $changeView = Get-View $name
   $taskMoRef = $changeView.ReconfigVM_Task($spec)
}
