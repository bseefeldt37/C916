# By: Benjamin Seefeldt Student ID: 006954697

#VARIABLE DECLARATION
$error0 = "Invalid selection, please choose from 1-5."
$userinput = 0
$gendate = Get-Date -DisplayHint Date

### FUNCTION DECLARATION ###

# This function is used to display the main menu of the script.
function Open-Menu {
    Write-Host "Welcome, please select an option below." -ForegroundColor DarkGreen
    Write-Host "
    1: Daily logs
    2: Folder contents
    3: Current CPU and memory usage
    4: Running processes
    5: Exit
    "
}

# This function searches the current folder for any files ending in .log.
# It then selects the name of each file and saves it to the DailyLog.txt file.
# Then the contents of the DailyLog.txt file is displayed in addition to the current date.
function Show-Logs {
    $specdate = Get-Date -Format "yyyy-MM-dd-HHmm"
    Write-Host "Today's Date: $gendate" -ForegroundColor DarkGreen
    Write-Host "Below is a list of log files"
    Get-ChildItem ./ -Filter *.log | Select-Object Name | Sort-Object -Property Name | Out-File $specdate`DailyLog.txt
    Get-Content ./DailyLog.txt
}

# This Function is used to save the current folder's contents to the C916contents.txt file
# and display them.
function Show-Files {
    Get-ChildItem ./ | Select-Object Name,LastWriteTime,Size | Sort-Object | Format-Table | Out-File C916contents.txt
    Get-Content ./C916contents.txt
}

# This function is used to display the current CPU and memory usage.
function Show-Perf {
    Get-Counter '\Processor(_Total)\% Processor Time'
    Get-Counter '\Memory\Available MBytes'
}

# This function is used to display the current running processes
# for the computer. 
Get-Process * | Format-List 

### BODY ###
Clear-host
try {
    while ($userinput -ne 5) {
        Open-Menu
        switch ($userinput = Read-Host -Prompt "Selection") {
            {$_ -lt 1} {Write-Host $error0 -ForegroundColor Red}
            {$_ -gt 5} {Write-Host $error0 -ForegroundColor Red}
            1 {Show-Logs}
            2 {Show-Files}
            3 {Show-Perf}
            4 {Write-Host "You selected 4"}
            5 {Write-Host "Goodbye." -ForegroundColor Red
                Exit-PSHostProcess}
        }
}
}
catch [System.OutOfMemoryException] {
    Write-Host "A memory issue has been detected, terminating program."
}
catch {
    Write-Host "An error has occurred:" -ForegroundColor Red
    Write-Host $_
}