function Get-AzCachedAccessToken() {
    $ErrorActionPreference = 'Stop'
  
    if(-not (Get-Module Az.Accounts)) {
        Import-Module Az.Accounts
    }
    $azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    if(-not $azProfile.Accounts.Count) {
        Write-Error "Ensure you have logged in before calling this function."    
    }
  
    $currentAzureContext = Get-AzContext
    $profileClient = New-Object Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient($azProfile)
    Write-Debug ("Getting access token for tenant" + $currentAzureContext.Tenant.TenantId)
    $token = $profileClient.AcquireAccessToken($currentAzureContext.Tenant.TenantId)
    $token.AccessToken
}

Login-AzAccount

$SubscriptionId = 'ffcb38a5-8428-40c4-98b7-77013eac7ec5'

$URL = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups?api-version=2017-05-10"

$Headers = @{ 
    "Authorization" = ("Bearer {0}" -f (Get-AzCachedAccessToken));
    "Content-Type" = "application/json";
}

$Response = Invoke-RestMethod -Uri $URL -Method Get -Headers $Headers

$Response | ConvertTo-Json
