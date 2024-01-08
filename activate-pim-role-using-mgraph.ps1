<#
    Script to activate PIM role using MgGraph

    Author: Arjan Cornelissen
	Editor: bosstuff
#>
param (
    # height of largest column without top bar
    [Parameter(Mandatory=$true)]
    [string]$roleReq  
)

# Connect via device authentication and get the TenantID and User ObjectID
Connect-MgGraph -UseDeviceAuthentication
$context = Get-MgContext
$currentUser = (Get-MgUser -UserId $context.Account).Id

# Get all available roles
$myRoles = Get-MgRoleManagementDirectoryRoleEligibilitySchedule -ExpandProperty RoleDefinition -All -Filter "principalId eq '$currentuser'"

# Get SharePoint admin role info
$myRole = $myroles | Where-Object {$_.RoleDefinition.DisplayName -eq $roleReq}

# Setup parameters for activation
$params = @{
    Action = "selfActivate"
    PrincipalId = $myRole.PrincipalId
    RoleDefinitionId = $myRole.RoleDefinitionId
    DirectoryScopeId = $myRole.DirectoryScopeId
    Justification = "Enable Admin Role for Admin Task on MgGraph"
    ScheduleInfo = @{
        StartDateTime = Get-Date
        Expiration = @{
            Type = "AfterDuration"
            Duration = "PT2H"
        }
    }
}

# Activate the role
New-MgRoleManagementDirectoryRoleAssignmentScheduleRequest -BodyParameter $params
