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


1..1000 | ForEach-Object -Process {New-Stone -Weight ($_ + ".56") -Form eckig -Type Mondstein -Color blau } -Begin {$a = Get-Date} -End {(Get-Date) - $a}


New-Stone -Weight 8.56 -Form eckig -Type Mondstein -Color blau 
New-Stone -Weight 18.56 -Form eckig -Type Schiefer -Color braun
New-Stone -Weight 118.56 -Form eckig -Type Marmor -Color grau 
New-Stone -Weight 1118.56 -Form eckig -Type Gneis -Color meliert


Get-Variable -Name Stone_array
Remove-Variable -Name Stone_Array
$Stone_Array