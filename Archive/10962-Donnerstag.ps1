

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


# ----------------------------------- XML ---------------------
$sample = @"
<computers>
    <computer name="LON-DC1">
        <addresses>
            <ipaddress family="IPv4" adaptername="Ethernet" interfaceindex="0">192.168.12.4</ipaddress>
        </addresses>
    </computer>
    <computer name="LON-SVR1" />
</computers>
"@

$sample | out-file c:\inventory.xml

[xml]$xml = Get-Content C:\inventory.xml
$xml
$xml.computers
$xml.computers.computer[0]
$xml.computers.computer[0].addresses

$xml.computers.computer[0].addresses.ipaddress

$node = $xml.SelectSingleNode('//computer[@name="LON-DC1"]')
$node.InnerXml
$nodes = $xml.SelectNodes('//computer[@name="LON-DC1"]/addresses/ipaddress')
$nodes

Get-Command