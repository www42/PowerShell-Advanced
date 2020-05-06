# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting

# Splatting is a method of passing a collection of parameters values to a command

# The traditional way - no splatting
Copy-Item -Path "test.txt" -Destination "test2.txt" -WhatIf

# Splatting with hash table
$foo = @{ 
    Path = "test.txt"
    Destination = "test2.txt"
    WhatIf = $true 
}
Copy-Item @foo

# Splatting with array (positional parameters only)
$bar = "test.txt", "test2.txt"
Copy-Item @bar -WhatIf

# Inline parameters
function f1 ($a, $b) {
    $a
    $b
    $PSCmdlet
}
f1 -a "a" -b 2

# Parameter list
function f2 {
    param ($a, $b)
    $a
    $b
    $PSCmdlet
}
f2 -a "a" -b 2


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
        $b
    )
    $a
    $b
    $PSCmdlet.GetType()
    $PSCmdlet.CurrentProviderLocation("FileSystem").Path   
}
f3 -a "a" -b 2