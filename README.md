# PowerShell Advanced

## PowerShell Functions

- Von einem Einzeiler zu einer Function

- Die Parameterliste `param()`

- Das `[CmdletBinding()]` Attribute

- Mandatory und Optional Parameters

- Hilfe direkt in die Function schreiben (Comment-Based Help)

- Parameter Binding (`ByValue`, `ByPropertyName`)

- Pipeline Input (`Begin{}`, `PROCESS{}`, `END{}`)

## PowerShell Modules

- Die Variable `$env:PSModulePath`

- Das Manifest (`New-ModuleManifest`)

- Verwalten von Modulen in der PS Session

- Implicite Remoting am Beispiel des Moduls `ActiveDirectory`

## PowerShell Package Management

- Das Konzept (aka OneGet)

- PackageProvider

- `Nuget`, `Chocolatey` und die PowerShell Gallery

- Packages finden, installiern, verwalten

## REST APIs mit PowerShell verwenden

- Motivation

- REST API Syntax

- `Invoke-RestMethod`

- Windows IIS verwalten per REST API

## Fehlerbehandlung und Debugging in PowerShell

- Die möglichen Werte für `ErrorAction` bei Non-Terminating Errors

- Die Struktur von Error-Objekten

- Fehlerbehandlung mit `Try{}` `Catch{}` `Finally{}`

- Debugging mit PowerShell ISE

## PowerShell DSC

- Das Konzept (Declarativ im Gegensatz zu Imperitive)

- Push und Pull Konfiguration

- `configuration {}`

- Der Local Configuration Manager (LCM)

- Standard DSC Resourcen von Windows Server

- Zusätzliche DSC Resourcen finden und installieren

## Git und GitHub für PowerShell Scripting nutzen

- Das Konzept von Git und GitHub

- Vokabeln: Repo, Commit, Branch, Push, Pull

- Git installieren auf Windows Systemen