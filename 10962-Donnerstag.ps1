

[System.Math]::e

Get-Service -Name BITS | Get-Member
Get-Service -Name BITS | fl -Property StartType, Status
(Get-Service BITS).Status

(Get-Service BITS).Start()

(Get-Service BITS).GetType()

# Parameter Binding
# Fall A) ByValue
notepad
Get-Process notepad | Stop-Process

# Fall B) ByPropertyName
Get-Service BITS | Stop-Process 
Get-Service BITS | Select-Object @{n="Name";e={"notepad"}} | Stop-Process 
Get-Service BITS | Select-Object @{n="Name";e={"notepad"}} | Get-Member


# REST API Calls
Invoke-RestMethod -Uri http://ipinfo.io/json
Invoke-RestMethod -Uri http://ipinfo.io/json | Get-Member



# Error Handling
try {
    $a=1/0
}
catch {
    "Es ist ein Fehler aufgetreten."
}
finally {
    Get-Date
}
