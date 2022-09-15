# By: Benjamin Seefeldt Student ID: 006954697


### BODY ###
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

# Creating SQL Database

# By: Benjamin Seefeldt Student ID: 006954697


### BODY ###

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
$inst = "SRV19-PRIMARY\SQLEXPRESS"
$dbname = "ClientDB"
$tbname = "Client_A_Contacts"

# Setting location
Set-Location "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL"

# Create DB
$db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database -ArgumentList $inst, $dbname
$db.Create()

#Create Table
<#cd "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA"
$dbinstance = "C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\ClientDB.mdf"
$tb = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Table -ArgumentList $dbinstance, $tbname

$Typestring = [Microsoft.SqlServer.Management.Smo.DataType]::varChar(50)
$Typezip = [Microsoft.SqlServer.Management.Smo.DataType]::varChar(5)
$Typephone = [Microsoft.SqlServer.Management.Smo.DataType]::varChar(12)

$col1 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"First_Name", $Typestring
$tb.Columns.Add($col1)

$col2 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"Last_Name", $Typestring
$tb.Columns.Add($col2)

$col3 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"City", $Typestring
$tb.Columns.Add($col3)

$col4 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"County", $Typestring
$tb.Columns.Add($col4)

$col5 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"Zip", $Typezip
$tb.Columns.Add($col5)

$col6 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"OfficePhone", $Typephone
$tb.Columns.Add($col6)

$col7 = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Column -ArgumentList $tb,"First_Name", $Typephone
$tb.Columns.Add($col7)

$tb.Create()#>

Invoke-Sqlcmd -ServerInstance

### TABLE DATA INSERT ###
Import-Csv .\Requirements2\NewClientData.csv | Write-SqlTableData -DatabaseName $dbname -SchemaName DBO -TableName $tbname
}
catch [System.OutOfMemoryException] {
    Write-Host "A memory issue has been detected, terminating program."
}