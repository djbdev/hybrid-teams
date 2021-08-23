<#
    if required:
        #Install-Module MicrosoftTeams -Force
        #Import-Module MicrosoftTeams
    author: djb-admin
#>

#session as daniel.bailey@bdo.com.au
$userCreds = Get-Credential
Connect-MicrosoftTeams -Credential $userCreds
# User to change
$user = "Myles.Frlan@bdo.com.au"

# Number to set
$number = "tel:+61740460069"

# Set phone number on prem
Set-CsUser -Identity $user -OnPremLineURI $number

# Change the users number to null to clear previous setting
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $number
