
[PSCustomObject]@{ Name = 'tccd' } | Get-Process    # bind ByPropertyName
[PSCustomObject]@{ Foo = 'tccd' }  | Get-Process    # no binding
[PSCustomObject]@{ Id = 'tccd' }   | Get-Process    # no binding
[PSCustomObject]@{ Id = 400 } | Get-Process         # bind ByPropertyName

Get-Process | Where-Object Name -Match "^V.*"       # match Regular Expression

$pi = [math]::PI
Write-Host 'Here is pi: $pi'
Write-Host "Here is pi: $pi"
Write-Host "pi plus 1:  $($pi + 1)"
