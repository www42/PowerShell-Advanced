################################################################
# PowerShell Advanced - Tag 4
# 30/10/2018
# Thomas.Troszczynski@gfn.de
#
# -Advanced functions


################################################################
# Advanced Function

#Get-Help -Name *about_func* 
#
#Get-Help -Name about_Functions -ShowWindow                       
#Get-Help -Name about_Functions_Advanced -ShowWindow              
#Get-Help -Name about_Functions_Advanced_Parameters -ShowWindow   
#Get-Help -Name about_Functions_CmdletBindingAttribute -ShowWindow

# Modulname = Geologie

class Stone
{
[double]$Weight 
[String]$Form 
[String]$Type
[String]$Color
[int64]$ID 
}


#region New-Stone
function New-Stone
    {
     Param(
        [parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, HelpMessage="Please use a dot to separate the weight-value.")]
        [double]$Weight, 

        [parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateSet("kantig", "rund", "oval", "eckig")]
        [String]$Form,

        [parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateSet("Sandstein", "Granit", "Gneis", "Mondstein", "Schiefer", "Marmor")]          
        [String]$Type,
        
        [parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [ValidateSet("braun", "grau", "weiss", "meliert", "gruen", "rot", "blau")]          
        [String]$Color 
        )

     Begin{}

     Process{
        if ( $Global:Stone_Array -eq $null )
            { [Stone[]]$Global:Stone_Array = @() ; $ID = 1 }
           else
            { $ID = $Global:Stone_Array[-1].ID  + 1 }

        $Stone_Values = @{ 
                          weight  = $Weight
                          form    = $Form
                          type    = $Type 
                          color   = $Color
                          id      = $ID
                          }
        
        $Global:Stone_Array += New-Object -TypeName Stone -Property $Stone_Values
              
        }

     End 
        { 
        $Global:Stone_Array[-1] 
                
        if (-not (Test-Path -Path $env:USERPROFILE\Desktop\Stone_LOG.csv))
            { Write-Output -InputObject '"EventID";"Date";"User";"Description"' | 
                Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv }

        Write-Output -InputObject ('"111";"' + (Get-Date).GetDateTimeFormats()[15] + '";"' + $env:USERNAME + '";"Der Datensatz mit der ID ' + $ID + ' wurde erstellt"') | 
            Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv -Append

        
        }   
    }
#endregion


#region Get-Stone
function Get-Stone
    {
    [cmdletbinding(DefaultParameterSetName=’ID’)]
     Param(

        [parameter(ParameterSetName="ID")]
        [ValidateScript({$_ -le $Global:Stone_Array.count})]
        [Int64]$ID,

        [parameter(ParameterSetName="Filter")]
        [ValidateSet("kantig", "rund", "oval", "eckig")]
        [String[]]$Form,

        [parameter(ParameterSetName="Filter")]
        [ValidateSet("Sandstein", "Granit", "Gneis", "Mondstein", "Schiefer", "Marmor")]          
        [String[]]$Type,
        
        [parameter(ParameterSetName="Filter")]
        [ValidateSet("braun", "grau", "weiss", "meliert", "gruen", "rot", "blau")]          
        [String[]]$Color 
        
        )
     Begin{}
     Process{

        # Wenn kein Parameter befüllt ist
        if ($Form -eq $null -and $Type -eq $null -and $Color -eq $null -and $id -eq 0)
         { $Global:Stone_Array }

         # Wenn nur ein Parameter befüllt ist
        elseif ($Form -eq $null -and $Type -eq $null -and $Color -eq $null -and $id -ne 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.ID -eq $ID } }
           
        elseif ($Form -ne $null -and $Type -eq $null -and $Color -eq $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Form -eq $Form } }  
         
        elseif ($Form -eq $null -and $Type -ne $null -and $Color -eq $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Type -eq $Type } }  
         
        elseif ($Form -eq $null -and $Type -eq $null -and $Color -ne $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Color -eq $Color} }
        
        # Wenn zwei Parameter befüllt sind
        elseif ($Form -ne $null -and $Type -ne $null -and $Color -eq $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Form -eq $Form -and $_.Type -eq $Type } }

        elseif ($Form -ne $null -and $Type -eq $null -and $Color -ne $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Form -eq $Form -and $_.Color -eq $Color } }

        elseif ($Form -eq $null -and $Type -ne $null -and $Color -ne $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Type -eq $Type -and $_.Color -eq $Color } }

        ## Wenn alle Parameter befüllt sind
        elseif ($Form -ne $null -and $Type -ne $null -and $Color -ne $null -and $id -eq 0)
         { $Global:Stone_Array | Where-Object -FilterScript { $_.Form -eq $Form -and $_.Type -eq $Type -and $_.Color -eq $Color } }

        }
     End{}   
    }
#endregion


#region Set-Stone
function Set-Stone
    {
     Param(
        [Parameter(Mandatory=$true)]
        [int64]$ID,


        [parameter(HelpMessage="Please use a dot to separate the weight-value.")]
        [double]$Weight, 

        [ValidateSet("kantig", "rund", "oval", "eckig")]
        [String[]]$Form,

        [ValidateSet("Sandstein", "Granit", "Gneis", "Mondstein", "Schiefer", "Marmor")]          
        [String[]]$Type,
        
        [ValidateSet("braun", "grau", "weiss", "meliert", "gruen", "rot", "blau")]          
        [String[]]$Color 
         
        )
     Begin{}
     Process{

     if (-not ($Weight -eq $null -or $Weight -eq 0))
        { $Global:Stone_Array[$ID - 1].Weight  = $Weight }

     if (-not ($Form -eq $null -or $Form -eq ""))
        { $Global:Stone_Array[$ID - 1].Form  = $Form }

     if (-not ($Type -eq $null -or $Type -eq ""))
        { $Global:Stone_Array[$ID - 1].Type  = $Type }
     
     if (-not ($Color -eq $null -or $Color -eq ""))
        { $Global:Stone_Array[$ID - 1].Color  = $Color }

        }

     End
        {
         $Global:Stone_Array[$ID - 1]
                 
        if (-not (Test-Path -Path $env:USERPROFILE\Desktop\Stone_LOG.csv))
            { Write-Output -InputObject '"EventID";"Date";"User";"Description"' | 
                Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv }

        Write-Output -InputObject ('"222";"' + (Get-Date).GetDateTimeFormats()[15] + '";"' + $env:USERNAME + '";"An dem Datensatz mit der ID ' + $ID + ' wurden folgende Werte geändert: Weight = ' + $Weight+', Form = '+$Form+', Type = '+$Type+', Color = '+$Color+'"') | 
            Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv -Append
         }   
    }
#endregion


#region Remove-Stone
function Remove-Stone
    {
     Param(
        [Parameter(Mandatory=$true)]
        [int64]$ID
        )
     Begin{}
     Process{
        
        $Global:Stone_Array[$ID - 1] = $null
        
        }
     End
        {
        Write-Host -Object "Sie haben den Datensatz Nr.$ID erfolgreich gelöscht!" -ForegroundColor Cyan
        
        if (-not (Test-Path -Path $env:USERPROFILE\Desktop\Stone_LOG.csv))
            { Write-Output -InputObject '"EventID";"Date";"User";"Description"' | 
                Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv }

        Write-Output -InputObject ('"666";"' + (Get-Date).GetDateTimeFormats()[15] + '";"' + $env:USERNAME + '";"Der Datensatz mit der ID ' + $ID + ' wurde gelöscht"') | 
            Out-File -FilePath $env:USERPROFILE\Desktop\Stone_LOG.csv -Append
        }   
    }
#endregion


#region Testarea
<#
1..500 | 
    ForEach-Object -Process {New-Stone -Weight ($_ + ".56") -Form eckig -Type Mondstein -Color blau } `
                   -Begin   {$a = Get-Date} `
                   -End     {(Get-Date) - $a}


New-Stone -Weight 8.56 -Form eckig -Type Mondstein -Color blau 
New-Stone -Weight 18.56 -Form rund -Type Schiefer -Color braun
New-Stone -Weight 118.56 -Form kantig -Type Marmor -Color grau 
New-Stone -Weight 1118.56 -Form oval -Type Gneis -Color meliert 

Get-Stone | Format-Table
Get-Stone -ID 5
Get-Stone -Form kantig
Get-Stone -Form eckig -Type Gneis

Set-Stone -ID 4 -Weight 100
Set-Stone -ID 5 -Form eckig -Color grau

Remove-Stone -ID 7

Import-Csv -Delimiter ";" -Path $env:USERPROFILE\Desktop\Stone_LOG.csv
#>
#endregion