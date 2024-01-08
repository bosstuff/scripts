# AUTHOR: Arjan Cornelissen
# Connect via deviceauthentication and get the TenantID and User ObjectID
Connect-MgGraph -UseDeviceAuthentication
$context = Get-MgContext
$currentUser = (Get-MgUser -UserId $context.Account).Id

# Get all available roles
$myRoles = Get-MgRoleManagementDirectoryRoleEligibilitySchedule -ExpandProperty RoleDefinition -All -Filter "principalId eq '$currentuser'"

# Get SharePoint admin role info
$myRole = $myroles | Where-Object {$_.RoleDefinition.DisplayName -eq "Intune Administrator"}

# Setup parameters for activation
$params = @{
    Action = "selfActivate"
    PrincipalId = $myRole.PrincipalId
    RoleDefinitionId = $myRole.RoleDefinitionId
    DirectoryScopeId = $myRole.DirectoryScopeId
    Justification = "Enable Intune Admin Role for Autopilot Enroll"
    ScheduleInfo = @{
        StartDateTime = Get-Date
        Expiration = @{
            Type = "AfterDuration"
            Duration = "PT4H"
        }
    }
    TicketInfo = @{
        TicketNumber = TS46283
        TicketSystem = "FreshServiceSysytem"
    }
}

# Activate the role
New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $params