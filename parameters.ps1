# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting

# The traditional way - no splatting
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf

# Splatting is a method of passing a collection of parameters values to a command

# Splatting with hash table
$foo = @{ 
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true 
}
# in a single line
$foo = @{ Path = "test.txt"; Destination = "test2.txt"; WhatIf = $true }
Copy-Item @foo

# Splatting with array (positional parameters only)
$bar = "test.txt", "test2.txt"
Copy-Item @bar -WhatIf

# Inline parameters
function f1 ($a, $b, $c) {
    $a
    $b
    $c
    $PSBoundParameters
    $PSCmdlet
}
f1 -a "a" -b 2 -c $true

# Parameter list
function f2 {
    param ($a, $b, $c)
    $a
    $b
    $c
    $PSBoundParameters
    $PSCmdlet
}
f2 -a "b" -b 2 -c $true
f2 2 a $false

# Advanced function
function f3 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,
                   Position=1,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string]
        $a,
        $b,
        $c
    )
    
    begin {}
    process {
        $a
        $b
        $c
        $PSBoundParameters
        $PSCmdlet.CurrentProviderLocation("FileSystem")   
    }
    end {}
}
f3 -a "a" -b 2 -c $true