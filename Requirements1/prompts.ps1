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
    Write-Host "Today's Date: $gendate" -ForegroundColor DarkGreen
    Write-Host "Below is a list of log files"
    Get-ChildItem ./ -Filter *.log | Select-Object Name | Sort-Object -Property Name | Out-File DailyLog.txt -Append
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
# for the computer. It then selects the name and VM properties and sorts by VM.
function Show-Process {
    Get-Process * | select Name, VM | Sort-Object VM | Out-Gridview
}

### BODY ###
Clear-host

# Start of the try/catch statement. This is used to catch errors and terminate
# the script if needed.
try {

    # While is used to show the menu until the user input is equal to the
    # terminating condition, 5.
    while ($userinput -ne 5) {
        Open-Menu

        # This switch statement runs the functions outlined above. It also
        # includes error handeling if the nuber entered is less than 1 or greater
        # than 5.
        switch ($userinput = Read-Host -Prompt "Selection") {
            {$_ -lt 1} {Write-Host $error0 -ForegroundColor Red}
            {$_ -gt 5} {Write-Host $error0 -ForegroundColor Red}
            1 {Show-Logs}
            2 {Show-Files}
            3 {Show-Perf}
            4 {Show-Process}
            5 {Write-Host "Goodbye." -ForegroundColor Red
                Exit-PSHostProcess}
        }
}
}

# This is the catch for if the system has memory issues. It will terminate the
# script.
catch [System.OutOfMemoryException] {
    Write-Host "A memory issue has been detected, terminating program."
}

# This catch will display the section of the script that has run into an error
# for troubleshooting purposes.
catch {
    Write-Host "An error has occurred:" -ForegroundColor Red
    Write-Host $_
}