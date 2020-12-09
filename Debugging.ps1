function Get-Weihnachten {
    [CmdletBinding()]
    Param (
        [string]$year=(Get-Date).year
    )
    $Weihnachten = Get-Date -Day 24 -Month 12 -Year $year -Hour 19 -Minute 0
    Write-Debug  '$Weihnachten berechnet.'
    $Weihnachten
}

function Get-TageBisWeihnachten {
    [CmdletBinding()]
    param (
        [string]$year=(Get-Date).year
    )
    $Jetzt = Get-Date
    $Weihnachten = Get-Weihnachten -year $year
    $TageBisWeihnachten = ($Weihnachten - $Jetzt).Days
    Write-Debug '$TageBisWeihnachten berechnet.'
    $TageBisWeihnachten
}

Write-Output "`n"
Write-Output "Zu Weihnachten wünsche ich mir ein Feuerwehrauto."
Write-Output "Weihnachten ist an einem $((Get-Weihnachten).DayOfWeek)."
Write-Output "Wie lange muss ich noch warten?"
$Tage = Get-TageBisWeihnachten
Write-Output "Noch $Tage Tage bis Weihnachten.`n"