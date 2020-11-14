function Get-AzBearerToken {
    
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




function Get-AzCachedAccessToken()
{
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

function Get-AzBearerToken()
{
    $ErrorActionPreference = 'Stop'
    ('Bearer {0}' -f (Get-AzCachedAccessToken))
}





# Call the Microsoft Graph
$headers = @{ 
    "Authorization" = ("Bearer {0}" -f $token);
    "Content-Type" = "application/json";
}

# Output response as a JSON file
Invoke-RestMethod -Method Get -Uri ("https://graph.microsoft.com/v1.0/me" -f $resourceId) -Headers $headers -OutFile $output