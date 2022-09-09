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
    $username = $member.samAccount
    $displayname = $firstname + " " + $lastname

    New-ADUser -Name $displayname -GivenName $firstname -Surname $lastname -DisplayName $displayname -PostalCode $member.PostalCode -OfficePhone $member.OfficePhone -MobilePhone $member.MobilePhone -Path $OUpath.DistinguishedName -SamAccountName $member.samAccount

}

# Creating SQL Database

