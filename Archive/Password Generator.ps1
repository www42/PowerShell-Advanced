# Password Generator
# ------------------

$abcLowercase = @(65..90 )
$abcUppercase = @(97..122)
$123 = @(48..57)

$abc123 = $azLowercase + $azUppercase + $123

$abc123 | foreach {[char]$_} | Write-Host -NoNewline

$specials = @(37..46)
$specials | foreach {[char]$_} | Write-Host -NoNewline

$passwordLength = 16
$password = $null

for($i = 0; $i -lt $passwordLength; $i++){
    $random = Get-Random -Minimum 0 -Maximum ($abc123.length - 1)
    $password += [char]$abc123[$random]
}

$random = Get-Random -Minimum 0 -Maximum ($specials.length - 1)
$randomSpecial = [char]$specials[$random]

# Sonderzeichen nicht am Anfang
$randomPosition = Get-Random -Minimum 1 -Maximum ($passwordLength - 1)

$password.remove($randomPosition, 1).insert($randomPosition,$randomSpecial)

$password