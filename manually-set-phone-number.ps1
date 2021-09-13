<#
    If required:
        #Install-Module MicrosoftTeams -Force
        #Import-Module MicrosoftTeams
        
    Remove < > and fill with relevant details.
    Author: djb-admin
#>

# Create session
$userCreds = Get-Credential
Connect-MicrosoftTeams -Credential $userCreds

# User to change
$user = "<Users UPN here>"

# Number to set
$number = "tel:+<Phone number here>"

# Set phone number on prem
Set-CsUser -Identity $user -OnPremLineURI $number

# Change the users number to null to clear previous setting
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number
