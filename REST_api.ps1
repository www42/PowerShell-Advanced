# Create Web App
# ---------------

# Host a web application with Azure App service
# https://docs.microsoft.com/en-us/learn/modules/host-a-web-app-with-azure-app-service/

# Install node.js
# https://nodejs.org/en/download/

# Create Zip File
# ----------------
$Root = 'C:\Git\PowerShell-Advanced'
cd $Root
mkdir helloworld
cd helloworld
& npm init
dir
Get-Content -Path package.json
New-Item -ItemType File -Path index.js

Compress-Archive -Path * -DestinationPath helloworld.zip

# Deploy Zip File with REST API
#PowerShell


$username = 'paul4711'
$password = 'Pa$$w0rd'
# $username = 'BestBike43\$BestBike43'
# $password = 'aJhx6csQvGvSmvBjMXhGeo6o3cdDo9TDxsKxkN0CTkkBMdY6d7FxhhKo12w6'
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $username, $password)))

$filePath = "helloworld.zip"
$apiUrl = "https://BestBike43.scm.azurewebsites.net/api/zipdeploy"
$userAgent = "powershell/1.0"
Invoke-RestMethod `
    -Uri $apiUrl `
    -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} `
    -UserAgent $userAgent `
    -Method POST `
    -InFile $filePath `
    -ContentType "multipart/form-data"