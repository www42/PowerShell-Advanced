# To round the value of Pi to three decimal places, run the following code:
[System.Math]::Round([System.Math]::PI,3)

# To display only the name of the currently signed-in user, run the following code:
[Security.Principal.WindowsIdentity]::GetCurrent() | Select-Object -Property Name

# To retrieve the current user identity, run the following code:
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()

# To convert the identity to a principal, run the following code:
$principal = [Security.Principal.WindowsPrincipal]$currentUser

# To retrieve the Administrator built-in role enumeration, run the following code:
$role = [Security.Principal.WindowsBuiltInRole]::Administrator

# To test the principal and determine whether it is in the built-in Administrator role, run the following code:
$principal.IsInRole($role)