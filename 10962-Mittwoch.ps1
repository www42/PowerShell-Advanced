
function foo {
    param($a)

    $a
}


Get-Command Get-Date

$foo = Get-Date
$foo | Format-List -Property *
$foo | fl *

foo
$foo
$PSVersionTable

Get-Command foo

# Jeffrey Snover
# Leibniz  Monad PSConf Eu Hannover
# 2007
# 
# 1. Get-Command
# 2. Get-Help
# 3. Get-Member

Get-Command -Name *date*
Get-Command -Noun Date
Get-Command -Noun vm
Get-Command -Verb get | Measure-Object
Get-Command -Verb set | Measure-Object
Get-Verb

Get-Command -noun disk
Get-Module -ListAvailable | Measure-Object
Get-Module -ListAvailable -Name az

Get-Command | Group-Object -Property CommandType

Get-Command -CommandType function
Get-Command -Name add-printer |  % Definition

start-job { Update-Help }
Get-Help Add-Printer -online



get-date | get-member

(get-date).DayOfYear
(get-date).Month
(get-date).AddDays(-7)



function myping2 {
<#
.Description
Dieses Tool pingt etwas an.
.Example
Hie kommt jetzt ein tolles Beispiel.
#>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, 
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [string]
        $ip
    )
    ping $ip
}

get-help myping2
get-help myping2 -Examples



Get-Module -ListAvailable -Name Storage
Get-Command -Module Storage | Measure-Object
get-command Get-Disk 

# Module = Ordner
# .psm1  Moduldatei
# .psd1  Manifest (meta data)

notepad
$env:PATH
$env:PSModulePath.split(";")

new-item -itemtype directory -path C:\Users\tj\OneDrive\Dokumente\WindowsPowerShell\Modules\CorpTools

get-module -listavail -name CorpTools
get-command -noun module

find-module -name az
get-packageprovider