# By: Benjamin Seefeldt Student ID: 006954697

try {
    # Creation of OU
    New-ADOrganizationalUnit finance

    # Account import
    $financemembers = Import-Csv .\financePersonnel.csv
    $OUpath = Get-ADOrganizationalUnit -Filter 'name -like "finance"'

    foreach ($member in $financemembers) {
        $firstname = $member.First_Name
        $lastname = $member.Last_Name
        $displayname = $firstname + " " + $lastname

        New-ADUser -Name $displayname -GivenName $firstname -Surname $lastname -DisplayName $displayname -PostalCode $member.PostalCode -OfficePhone $member.OfficePhone -MobilePhone $member.MobilePhone -Path $OUpath.DistinguishedName -SamAccountName $member.samAccount

    }

    ### Creating SQL Database ###
    # Variable creation
    $inst = ".\SQLEXPRESS"
    $dbname = "ClientDB"
    $tbname = "Client_A_Contacts"

    # Setting location
    Set-Location "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL"

    # Create DB
    #$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -ArgumentList $inst, $dbname
    #$db.Create()
    Invoke-Sqlcmd -ServerInstance $inst -InputFile $PSScriptRoot\CreateDB.sql

    #Create Table
    #$PSfilepath = "C:\Users\LabAdmin\Documents\C916\Requirements2"
    Invoke-Sqlcmd -ServerInstance $inst -Database $dbname -InputFile $PSScriptRoot\CreateTable.sql

    ### TABLE DATA INSERT ###
    $ClientDataRows = Import-Csv $PSfilepath\NewClientData.csv |
        ForEach-Object { [PSCustomObject]@{
            first_name = $_.first_name;
            last_name = $_.last_name;
            city = $_.city;
            county = $_.county;
            zip = $_.zip;
            officePhone = $_.officePhone;
            mobilePhone = $_.mobilePhone
            }
        }

    Write-SqlTableData -ServerInstance $inst -DatabaseName $dbname -SchemaName "dbo" -TableName $tbname -InputData $ClientDataRows
}

catch [System.OutOfMemoryException] {
    Write-Host "A memory issue has been detected, terminating program."
}