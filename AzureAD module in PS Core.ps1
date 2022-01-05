# [How to use the AzureAD module in PowerShell Core | endjin](https://endjin.com/blog/2019/05/how-to-use-the-azuread-module-in-powershell-core)

# PowerShell module `AzureAD` does not load in MacOS (both M1 and Intel).
# But there is a test module `AzureAD.Standard.Preview` at PowerShell *Test*  Gallery
#
# `AzureAD.Standard.Preview` is also used by Azure Cloud Shell.

Get-PackageSource
Register-PackageSource -Name PoshTestGallery -Location https://www.poshtestgallery.com/api/v2/ -ProviderName PowerShellGet -Trusted:$false
Find-Module -Name AzureAD.Standard.Preview -AllVersions
Find-Module -Name AzureAD.Standard.Preview -AllVersions | Sort-Object PublishedDate -Descending | ft Name,Version,PublishedDate
# Version 0.0.0.10 is latest

# To install module at scope `AllUsers` run PowerShell as Admin
#   Bash$ sudo pwsh

Install-Module -Name AzureAD.Standard.Preview -RequiredVersion 0.0.0.10 -Scope AllUsers
Get-Module -ListAvailable -Name AzureAD.Standard.Preview

# Let's have fun with AzureAD
Get-Command -Module AzureAD.Standard.Preview
Connect-AzureAD
Get-AzureADDomain | fl *
Get-AzureADTenantDetail | fl *