[System.Math]::Round([System.Math]::PI,3)

[Security.Principal.WindowsIdentity]::GetCurrent() | Select-Object -Property Name

$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = [System.Security.Principal.WindowsPrincipal]$currentUser
$role = [System.Security.Principal.WindowsBuiltInRole]::Administrator
$principal.IsInRole($role)