# Azure API Browser: List ResourceGroups in a Subscription
# https://docs.microsoft.com/en-us/rest/api/resources/resource-groups

function Get-AzCachedAccessToken() {
    $ErrorActionPreference = 'Stop'
    
    if (-not (Get-Module -Name Az.Accounts)) {
        Import-Module -Name Az.Accounts
    }

    $azProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
    if(-not $azProfile.Accounts.Count) {
        Write-Error "Ensure you have logged in before calling this function."    
    }

    $currentAzureContext = Get-AzContext
    $profileClient = New-Object Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient($azProfile)

    Write-Debug ("Getting access token for tenant " + $currentAzureContext.Tenant.TenantId)
    
    $token = $profileClient.AcquireAccessToken($currentAzureContext.Tenant.TenantId)
    $token.AccessToken
}

Login-AzAccount

$SubscriptionId = '69aa003c-1d8d-4ce8-b47d-88a70d85145d'

$URL = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups?api-version=2017-05-10"

$Headers = @{ 
    "Authorization" = ("Bearer {0}" -f (Get-AzCachedAccessToken));
    "Content-Type" = "application/json";
}

$Response = Invoke-RestMethod -Uri $URL -Method Get -Headers $Headers

$Response | ConvertTo-Json
