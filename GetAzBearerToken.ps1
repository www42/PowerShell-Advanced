function Get-AzBearerToken {
    # From Stephane Lapointe
    # https://www.codeisahighway.com/
    # https://github.com/slapointe/azure-scripts/tree/master/bearer-token    
    
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


# Call the Microsoft Graph
$headers = @{ 
    "Authorization" = ("Bearer {0}" -f (Get-AzBearerToken));
    "Content-Type" = "application/json";
}

# Output response as a JSON file
Invoke-RestMethod -Method Get -Uri ("https://graph.microsoft.com/v1.0/me" -f $resourceId) -Headers $headers -OutFile $output