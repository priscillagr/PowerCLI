<#
O comando abaixo adiciona uma entrada no servidor DNS especificado pelo ZoneName.
#>

Add-DnsServerResourceRecordA -Name "hostname" -ComputerName "DNS" -ZoneName "domain_name" -AllowUpdateAny -IPv4Address "IP" -CreatePTR


<#
A variavel cmd abaixo pode ser utilizada pelo workflow "Run Script in a Guest" do vRealize Orchestrator para criar a entrada DNS. A linguagem utilizada é JavaScript
#>

cmd = 'Add-DnsServerResourceRecordA -Name "'+NodeToRegister+'" '
        +'-ComputerName "'+DNSServer+'" '
        +'-ZoneName "'+ZoneName+'" '
        +'-AllowUpdateAny -IPv4Address "'+IPAddres+'" '
        +'-CreatePTR;';
