$ModuleName     = "Toolbox"
$ModuleRoot     = ($env:PSModulePath).Split(";")[0]
$ModuleFile     = "$ModuleRoot\$ModuleName\$ModuleName.psm1"
$ModuleManifest = "$ModuleRoot\$ModuleName\$ModuleName.psd1"

New-Item -ItemType File -Path $ModuleFile -Force
New-ModuleManifest -Path $ModuleManifest

psedit $ModuleFile

psedit $ModuleManifest
# RootModule = 'ToolBox.psm1'
# ModuleVersion = '0.0.1'
# FunctionsToExport = @("Get-MyService","Get-MyIpAddress")   # Double quotes, comma seperated
# 

Import-Module -Name $ModuleName -Force
Get-Module -Name $ModuleName