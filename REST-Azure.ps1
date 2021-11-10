# Azure API Browser: List ResourceGroups in a Subscription
# https://docs.microsoft.com/en-us/rest/api/resources/resource-groups

Login-AzAccount
Get-AzContext | fl *
$SubscriptionId = 'ffcb38a5-8428-40c4-98b7-77013eac7ec5'

$Token = Get-AzAccessToken | Select-Object -ExpandProperty Token

$URL = "https://management.azure.com/subscriptions/$subscriptionId/resourcegroups?api-version=2017-05-10"

$Headers = @{ 
    "Authorization" = ("Bearer {0}" -f $Token);
    "Content-Type" = "application/json";
}

$Response = Invoke-RestMethod -Uri $URL -Method Get -Headers $Headers

$Response | ConvertTo-Json
