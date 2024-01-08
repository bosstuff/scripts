#Install Azure AD PIM Module
Install-Module Microsoft.Azure.ActiveDirectory.PIM.PSModule

#Check available commands you can use in this module
Get-Command -Module Microsoft.Azure.ActiveDirectory.PIM.PSModule

#Connect as any user who has the required privileges
Connect-PimService -UserName 'user@pass'

#View my eligible roles
Get-PrivilegedRoleAssignment

#Activate a role
$params = @{
             'RoleId'= '<IDROLE>';
             'Reason' = 'Testing PIM activation with PowerShell';
             'Duration' = '1.0'
            }

Enable-PrivilegedRoleAssignment @params