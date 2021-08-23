<#
    if required:
        #Install-Module MicrosoftTeams -Force
        #Import-Module MicrosoftTeams

        .SYNOPSIS
        Simple script for a hybrid o365 environment, designed to
        take a newly created user and enrol and migrate to Teams
        online.

    author: djb-admin
#>

# Configuration variables
$userName = "shonia.o'brien@bdo.com.au"

$lineURI = "tel:+61740460088"

$voicePolicy = "AU-INTERNATIONAL"
    
$dialPlan = "AU-Queensland-07"
function Enable-TeamsUser($username,$LineURI,$VoicePolicy){

    try {
        # Enable Enterprise Voice and Hosted Voicemail
        Set-CsUser -Identity $username -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -ErrorAction stop  
        # Set LineURI
        Set-CsUser -Identity $username -OnPremLineURI $LineURI
        # Assign Dial Plan
        Grant-CsTenantDialplan -Identity $username -PolicyName $dialPlan   
        # Assign Voice Policy
        Grant-CsOnlineVoiceRoutingPolicy -Identity $username -PolicyName $voicePolicy
        # Assign Policy
        Grant-CsTeamsUpgradePolicy -Identity $username -PolicyName UpgradeToTeams    
    } catch {
        # What happened?
        Get-Error $_
        Return
    } 
}
# New session with Teams online
$teamsSession = Connect-MicrosoftTeams -Credential $userCreds

# Perform actions
Enable-TeamsUser -Dialplan $dialPlan -Username $username -VoicePolicy $voicePolicy -LineURI $lineURI

# Clean up sessions
get-pssession $teamsSession | remove-pssession | out-null

