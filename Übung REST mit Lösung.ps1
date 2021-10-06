# RSS feed PowerShellBlog abrufen
#   https://blogs.msdn.microsoft.com/powershell/feed/ 
Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ 

Invoke-RestMethod -Uri https://blogs.msdn.microsoft.com/powershell/feed/ |
Format-Table -Property Title, pubDate


# IP info
#   http://ipinfo.io/json
Invoke-RestMethod -Uri http://ipinfo.io/json


# Wetter info (Console, nicht ISE)
#   http://wttr.in/heidelberg
Invoke-RestMethod http://wttr.in/heidelberg
