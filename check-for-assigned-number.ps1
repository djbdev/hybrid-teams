<#
    if required:
        #Install-Module MicrosoftTeams -Force
        #Import-Module MicrosoftTeams
    author: djb-admin

    .SYNOPSIS
    Simple script designed to search Teams online tenant for who a 
    particular number may be assigned to.

    Note: Does not check if the number is assigned to an AA service.
#>

# Create Session
$userCreds = Get-Credential
# Connect
$teamsSession = Connect-MicrosoftTeams -Credential $userCreds

# The phone number to search for:
$numberToFind = "<Number to find>"
# False until proven otherwise
$found = $false

# Check for number in users
try {
    write-host "*** Searching for number: $numberToFind *** `n"
    $found = Get-CsOnlineUser | Where-Object { $_.LineURI -like "*$numberToFind*" } | select-object UserPrincipalName, LineURI
}
catch {
    write-verbose -Message $_.exception.message
}

# Result output
if($null -eq $found){
    write-host "Number is not assigned to a CsOnlineUser."
} else {
    write-host "Number $($found.LineURI) `nis currently assigned to CsOnlineUser: $($found.UserPrincipalName)"
}

# Clean up
get-pssession $teamsSession | remove-pssession | out-null

