################################################################
#
# PowerShell Advanced - Tag 1
# 25/10/2018
# Thomas.Troszczynski@gfn.de
#
# - Die wichtigsten PowerShell Befehle
# - PowerShell Klassen
# - Convert a String to a double
# - Hash_Table
#
################################################################


################################################################
#region Die wichtigsten PowerShell Befehle
# 1.) Get-Command
Get-Command
Get-Command -Verb install
Get-Command -Verb install -Noun *update*

Get-Command -Name get-ser*
Get-Command -Name *-ser*

Get-Command -Module *Update*

Get-Command -TotalCount 15

Get-Command -Syntax
Get-Command -Name Get-ser* -Syntax

Get-Command -Name Get-ser* -ShowCommandInfo

Get-Command -ParameterName ComputerName
Get-Command -ParameterName *key* -Syntax

# 2.) Get-Help
Update-Help 

Get-Help -Name Get-EventLog
Get-Help -Name Get-EventLog -Detailed
Get-Help -Name Get-EventLog -Full
Get-Help -Name Get-EventLog -Examples
Get-Help -Name Get-EventLog -ShowWindow

Get-EventLog -LogName Security -After (Get-Date -Day 24 -Month 10 -Year 2018)

# about_Files
Get-Help -Name *about*
Get-Help -Name *about* | Out-GridView 
Get-Help -Name *about* | Out-GridView -PassThru |Get-Help -ShowWindow

Get-Help -Name about_Hash_Tables -ShowWindow

# 3.) Get-Member
Get-Service | Get-Member 
#endregion

################################################################
#region PowerShell Klassen 

# Bauplan = Klasse

# BauplanName = Stein
#
# Eigenschaften:
#---------------------
# Gewicht <double>
# Form <String>
# Art <String>
# Farbe <String>

# Klasse definieren
class Stein
{
[double]$Gewicht 
[String]$Form 
[String]$Art 
[String]$Farbe 
}

# 1.) Neues Objekt erzeugen
Get-Help -Name New-Object -ShowWindow
Get-Help -Name New-Object -Online


New-Object -TypeName Stein -Property @{ Gewicht = 15 ; Form = "Rund" ; Art = "Sandstein" ; Farbe = "Blau"}

[Stein[]]$Steine = New-Object -TypeName Stein -Property @{ Gewicht = 15 ; Form = "Rund" ; Art = "Sandstein" ; Farbe = "Blau"}
$Steine

$obj = @{ Gewicht = 15 ; Form = "Rund" ; Art = "Sandstein" ; Farbe = "Blau"}
[Stein[]]$Steine = New-Object -TypeName Stein -Property $obj


# 2.) Neues Objekt erzeugen

[Stein[]]$Steine += @{
                      Gewicht = 105 
                      Form    = "Kantig" 
                      Art     = "Sandstein" 
                      Farbe   = "Rot"
                      }
$Steine


# 3.) Neues Objekt erzeugen
$Steine += [Stein]::new() 
$Steine[2].Gewicht = 102
$Steine[2].Form    = "Oval"
$Steine[2].Art     = "Granit"
$Steine[2].Farbe   = "Grau"
$Steine

$Steine | Get-Member
$Steine.GetType()


# Datensätze generieren und in einer CSV ausgeben
[String[]]$form  = "kantig", "rund", "oval", "eckig"
[String[]]$art   = "Sandstein", "Granit", "Gneis", "Mondstein", "Schiefer", "Marmor"
[String[]]$farbe = "braun", "grau", "weiss", "meliert", "gruen", "rot", "blau"

for ($i = 1; $i -lt 120; $i++)
{ 
   [Stein[]]$Steine += @{
                         Gewicht = ([System.Math]::Round((Get-Random -Minimum 0.5 -Maximum 1000),2))
                         Form    = (Get-Random -InputObject $form) 
                         Art     = (Get-Random -InputObject $art) 
                         Farbe   = (Get-Random -InputObject $farbe)
                         } 
}

$steine | Export-Csv -Path $env:USERPROFILE\desktop\steine.csv -Encoding UTF8 -Delimiter ";" -NoTypeInformation


# CSV-Datei importiert und Objekte konvertiert

Import-Csv -Path $env:USERPROFILE\desktop\steine.csv -Delimiter ";" | Get-Member #TypeName: System.Management.Automation.PSCustomObject

$csvImport = Import-Csv -Path $env:USERPROFILE\desktop\steine.csv -Delimiter ";"

$csvImport | ForEach-Object -Process { $Steine += @{
                                                    Gewicht = $_.Gewicht.ToDouble($null)
                                                    Form    = $_.Form
                                                    Art     = $_.Art
                                                    Farbe   = $_.Farbe
                                                    } `
                                      } `
                            -End {$Steine}   


$Steine | Get-Member
#endregion

################################################################
#region Convert a String to a double
[String]$zahl = "8,56"
$zahl | Get-Member #TypeName: System.String


[convert]::ToDouble($zahl) | Get-Member #TypeName: System.Double      

[double]($zahl.Replace(",","."))  | Get-Member #TypeName: System.Double

$zahl.Replace(",",".") -as [double] | Get-Member #TypeName: System.Double

$zahl.ToDouble($null) | Get-Member #TypeName: System.Double
#endregion

################################################################
#region HashTable
Get-Help -Name *hash*
Get-Help -Name about_Hash_Tables -ShowWindow
#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-6

# @  = Leitet die Hash_Table ein
# {} = Der Rahmen der Hash_Table
# ;  = Zeilenumbruch \ Separator \ Trennzeichen

# Beispiel:
$hash = @{ Number = 1; Shape = "Square"; Color = "Blue"}
#endregion






################################################################
# Die Pipeline

################################################################
# Advanced Function

Get-Help -Name *about_func* 

Get-Help -Name about_Functions -ShowWindow                       
Get-Help -Name about_Functions_Advanced -ShowWindow              
Get-Help -Name about_Functions_Advanced_Parameters -ShowWindow   
Get-Help -Name about_Functions_CmdletBindingAttribute -ShowWindow
