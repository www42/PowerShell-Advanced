################################################################
# PowerShell Advanced - Tag 3
# 29/10/2018
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

     End{ $Global:Stone_Array[-1] }   
    }
#endregion



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
















#region Testarea
1..500 | 
    ForEach-Object -Process {New-Stone -Weight ($_ + ".56") -Form eckig -Type Mondstein -Color blau } `
                   -Begin   {$a = Get-Date} `
                   -End     {(Get-Date) - $a}


New-Stone -Weight 8.56 -Form eckig -Type Mondstein -Color blau 
New-Stone -Weight 18.56 -Form eckig -Type Schiefer -Color braun
New-Stone -Weight 118.56 -Form eckig -Type Marmor -Color grau 
New-Stone -Weight 1118.56 -Form eckig -Type Gneis -Color meliert 

#endregion