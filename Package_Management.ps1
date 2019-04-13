$VmName = 'PSA'
$User = 'Administrator'
$Pw = 'Pa55w.rd'

$SecPw = ConvertTo-SecureString -String $Pw -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User,$SecPw

Start-VM -Name $VmName

$PSA = New-PSSession -VMName $VmName -Credential $Cred

Enter-PSSession $PSA




# =========================
# Module Package Management
# =========================

# -----
# Demo
# -----

# a) Architektur und PackageProvider
# ----------------------------------

# Architektur
Start-Process -FilePath https://github.com/oneget/oneget

# Es muss mindestens PS 5.0 sein
$PSVersionTable.PSVersion

# Es gibt PackageProvider
Get-PackageProvider

# Es gibt "PackageProvider" und "PackageManagemetProvider". Der Unterschied ist diffizil.
# In erster Näherung: PackageManagementProvider sind auch nur PackageProvider.

# "PackageProvider" sind etwas anderes als "PSProvider"
Get-PSProvider
Get-PackageProvider

# Vorinstalliert ist PackageProvider "PowerShellGet"
Get-PackageSource -ProviderName PowerShellGet | fl *

# PowerShellGet entspricht der PowerShell Gallery
# Was ist die PowerShell Gallery?
Start-Process -FilePath https://www.powershellgallery.com/

# "PowerShellGet" Location ist ein API Endpoint hat (nicht das Web Interface)
# "PowerShellGet" ist *nicht* vertrauenswürdig

# Der PackageProvider hat einen PackageManagementProvider (nuget)
Get-PackageSource -ProviderName PowerShellGet | % Details

# Was ist nuget?
Start-Process -FilePath https://www.nuget.org/

# Was ist Chocolaty?
Start-Process -FilePath https://chocolatey.org/

# Zurück zu PackageProvider
Get-PackageProvider

# Befehle für "PackageProvider"
Get-Command -Noun PackageProvider

# Was gibts denn noch? (Sag erstmal Nein zu nuget.)
Find-PackageProvider -ForceBootstrap

# Install PackageProvider nuget (Nuget braucht man immer.)
Install-PackageProvider -Name nuget
Get-PackageProvider

# Jetzt ist also nuget lokal installiert
(Get-PackageProvider nuget).ProviderPath
(Get-PackageProvider nuget).Features

# Optional: Was sind SWID Tags?
# Software Identification Tags = xml Metadata zu einem Software Paket)
Start-Process -FilePath https://tagvault.org/frequently-asked-questions-about-swids/

# Noch einmal Find - durch nuget findet man jetzt mehr
Find-PackageProvider

# Beispile: Es gibt den PackageProvider "NanoServerPackage"
Find-PackageProvider -Name NanoServerPackage | % Summary

# Den will ich haben
Install-PackageProvider -Name NanoServerPackage
Get-PackageProvider

# "PackageProvider" haben in der Regel "PackageSource", d.h. Endpoints, wo es die Pakete gibt
Get-PackageSource | ft ProviderName,Source,Location




# b) Pakete managen
# ------------------

# Was kann man machen mit Paketen?
Get-Command -Noun Package

# Ein konkretes Paket finden (nicht installieren)
Find-Package -Name SHiPS

# Alle Pakete eines Providers finden
Find-Package -Source PSGallery

# Doof
# "NanoServerPackage' hat Probleme aus VMs heraus, Bits?
Find-Package -Source NanoServerPackageSource

#

Find-Package | Group-Object -Property Source




# Unklar
# Was sind das für Pakete. Updates? Wie kommen die ohne den Provider auf das System?
Get-Package -ProviderName NanoServerPackage







# Misc
# -----

# Code name für PackageManagemnet war "OneGet"

# Schöne Zusammenfassung: OneGet is a package management aggregator.
# https://github.com/OneGet/oneget/wiki/Provider-Requests





# Übung
# ------

# Überzeugen Sie sich, dass es PowerShell Version >= 5.0 ist
$PSVersionTable.PSVersion

# Listen Sie alle installierten PackageProvider auf
Get-PackageProvider

# Listen Sie alle installierten PackageProvider auf, als Tabelle mit Name,Version,Installationspfad
Get-PackageProvider | ft Name,Version,ProviderPath

# Installieren Sie den PackageProvider "nuget"
Install-PackageProvider -Name nuget
