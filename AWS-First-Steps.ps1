# https://docs.aws.amazon.com/powershell/latest/userguide/pstools-welcome.html
# 3 Versions
#   a) Modularized version (Windows PowerShell and PowerShell)
#   b) One module version PowerShell
#   c) One module version Windows Powershell
#
# Let's choose a)
#
# https://www.powershellgallery.com/packages/AWS.Tools.Installer/
# Installer for installing modules e.g.
#Install-AWSToolsModule EC2,S3
#Update-AWSToolsModule -CleanUp
Find-Module -Name AWS.Tools.Installer
# There is a lot of modules
Find-Module -Name AWS.Tools.*

# Ok let's install
Install-Module -Name AWS.Tools.Installer
# We got only three cmdlets: Install, Uninstall, Update
Get-Command -Module AWS.Tools.Installer
# Install modules for ec2 and s3
Install-AWSToolsModule -Name ec2,s3 -Force
# Module `AWS.Tools.Common` was added automatically
Get-Module -ListAvailable -Name AWS*
Get-Command -Module AWS.Tools.Common

# Login to AWS
# -------------
# https://docs.aws.amazon.com/powershell/latest/userguide/specifying-your-aws-credentials.html
#
# Create IAM user with access keys
# Add a new profile
Set-AWSCredential `
    -AccessKey xxx `
    -SecretKey yyy `
    -StoreAs 'default'

ls -l $HOME/.aws
Get-Content $HOME/.aws/credentials

# Let's play around
Get-AWSRegion
Set-DefaultAWSRegion -Region eu-central-1

Get-Command -Module AWS.Tools.EC2 | ? Verb -EQ 'Get'
Get-EC2Instance
Get-EC2InstanceStatus
Get-EC2InstanceStatus | % InstanceId
Get-EC2InstanceStatus | % InstanceState
Get-EC2InstanceStatus | % Status

Get-Command -Noun EC2Instance
Stop-EC2Instance -InstanceId (Get-EC2InstanceStatus | % InstanceId) -Verbose