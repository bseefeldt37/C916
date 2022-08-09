# By: Benjamin Seefeldt Student ID: 006954697

#VARIABLE DECLARATION
$error0 = "Invalid selection, please choose from 1-5."

#FUNCTION DECLARATION
function Open-Menu {
    Clear-Host
    Write-Host "Welcome, please select an option below." -ForegroundColor DarkGreen
    Write-Host "
    1: Daily log
    2: Folder contents
    3: Current CPU and memory usage
    4: Running processes
    5: Exit
    "
}
function Show-Logs {
    Get-Date -DisplayHint Date
    Get-ChildItem ./ -Filter *.log | Select-Object Name | Sort-Object -Property Name | Out-File DailyLog.txt
    Get-Content ./DailyLog.txt
}
function Show-Files {
    Get-ChildItem ./ | Select-Object Name,LastWriteTime,Size | Sort-Object | Format-Table | Out-File C916contents.txt
    Get-Content ./C916contents.txt
}
function Show-Perf {
    Get-Counter '\Processor(_Total)\% Processor Time'
    Get-Counter '\Memory\Available MBytes'
}
Get-Process *
#BODY
Open-Menu
switch (Read-Host -Prompt "Selection") {
    {$_ -lt 1} {Write-Host $error0 -ForegroundColor Red}
    {$_ -gt 5} {Write-Host $error0 -ForegroundColor Red}
    1 {Show-Logs}
    2 {Show-Files}
    3 {Show-Perf}
    4 {Write-Host "You selected 4"}
    5 {Write-Host "Goodbye." -ForegroundColor Red
        Exit-PSHostProcess}
    default {Write-Host "Invalid selection, please choose from 1-5."}
}