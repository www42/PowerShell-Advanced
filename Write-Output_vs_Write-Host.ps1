# Write-Output schreibt in die Pipeline
$a = 'Testing Write-Output' | Write-Output
$a

# Write-Host schreibt direkt auf die Konsole
$b = 'Testing Write-Host' | Write-Host
$b

# Write-Host is almost always wrong!
# http://www.jsnover.com/blog/2013/12/07/write-host-considered-harmful/