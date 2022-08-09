# By: Benjamin Seefeldt Student ID: 006954697

#VARIABLE DECLARATION


#FUNCTION DECLARATION
function Open-Menu {
    Clear-Host
    Write-Host "Welcome, please select an option below." -ForegroundColor DarkGreen
    Write-Host "
    1: Daily log
    2: Folder contents
    3: Current CPU and memory usage
    4: Running processes
    5: Exit"
    Read-Host -Prompt "Selection: __"
}

#BODY
Open-Menu