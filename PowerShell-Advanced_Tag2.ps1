################################################################
# PowerShell Advanced - Tag 2
# 26/10/2018
# Thomas.Troszczynski@gfn.de
#
# -Advanced functions


################################################################
#region Advanced Function

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


# New-Stone
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

        $Stone_Values = @{ 
                          weight  = $Weight
                          form    = $Form
                          type    = $Type 
                          color   = $Color
                          id      = $Global:ID
                          }

        New-Object -TypeName Stone -Property $Stone_Values
       
        }

     End{}   
    }




# Get-Stone
function Get-Stone
    {
     Param()
     Begin{}
     Process{}
     End{}   
    }

# Set-Stone
function Set-Stone
    {
     Param()
     Begin{}
     Process{}
     End{}   
    }

# Remove-Stone
function Remove-Stone
    {
     Param()
     Begin{}
     Process{}
     End{}   
    }