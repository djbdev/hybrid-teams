<#
    if required:
        #Install-Module MicrosoftTeams -Force
        #Import-Module MicrosoftTeams
    author: djb-admin

    .SYNOPSIS
    Used to clear a phone number for reuse in Teams.
    Designed for a hybrid environment where the lineuri is set first
    in the on premise environment, then migrated to Teams online.
#>

# Get credentials
$userCreds = Get-Credential

# Create new session
$teamsSession = Connect-MicrosoftTeams -Credential $userCreds

# Specify the user account to which a number has been assigned
$user= "narelle.newton"

# Clear the assigned number from the user
Set-CsUser -identity $user -onpremlineuri $null

# Change the users number to null in Teams online
Set-CsOnlineVoiceUser -Identity $user -TelephoneNumber $null

# Clean up
Get-PSSession $teamsSession | Remove-PSSession | Out-Null
