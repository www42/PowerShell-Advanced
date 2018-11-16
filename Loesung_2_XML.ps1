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
        
        if ( Test-Path -Path "$env:TEMP\AllStones.stone" )
        { 

        [Stone[]]$XML_Import = Import-Clixml -Path "$env:TEMP\AllStones.stone"

        $MaxIndex = $XML_Import | 
            Measure-Object -Property ID -Maximum | 
                Select-Object -ExpandProperty Maximum 

        $Index = ++$MaxIndex
        }
        else
        {
         [int]$Index = 1
         }
        
        
        $Stone_Values = @{ 
                          weight  = $Weight
                          form    = $Form
                          type    = $Type 
                          color   = $Color
                          id      = $Index
                          }

        $XML_Import += New-Object -TypeName Stone -Property $Stone_Values -OutVariable "Output"
        
        $XML_Import | Export-Clixml -Path "$env:TEMP\AllStones.Stone" -Force            

         
        }

     End{ $Output }   
    }

New-Stone -Weight 8.56 -Form eckig -Type Mondstein -Color blau 
New-Stone -Weight 18.56 -Form eckig -Type Schiefer -Color braun
New-Stone -Weight 118.56 -Form eckig -Type Marmor -Color grau 
New-Stone -Weight 1118.56 -Form eckig -Type Gneis -Color meliert 

  
#region Import     
[Stone[]]$Import = Import-Clixml -Path "$env:TEMP\AllStones.stone" 
$Import 

#endregion 