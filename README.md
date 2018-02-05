<<<<<<< HEAD
# PSGSuite

[![Join the chat at https://gitter.im/PSGSuite/Lobby](https://badges.gitter.im/PSGSuite/Lobby.svg)](https://gitter.im/PSGSuite/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
Powershell module wrapping G Suite (Google Apps) API calls in handy functions. Authentication is established using a service account via P12 key to negate the consent popup and allow for greater handsoff automation capabilities

Ready to get started? Visit the [Initial Setup page](https://github.com/nferrell/PSGSuite/wiki/Initial-Setup) and follow the directions there.

## Prerequisites
In order to use this module, you'll need to have the following:
* **Powershell 3.0 or higher** (module makes heavy use of Invoke-RestMethod).
* API Access Enabled in the Admin Console under Security
* Service Account key created and downloaded as **a P12 key file**.
* API Client access allowed for the Service Account that will be used towards the API scopes that you intend to utilize
* Domain-Wide Delegation enabled for the service account

## Tips & Tricks
* All functions support pre-acquired Access Tokens (using the _AccessToken_ parameter).
    * This is useful if you have a lot of recurring commands that leverage the same admin and scope(s) so you do not overrun the user API call quota, i.e. pulling info for a large set of emails in a user's inbox.
    * If the access token is not pre-acquired, then the _P12KeyPath_, _AppEmail_, _AdminEmail_, _CustomerID_, and _Domain_ parameters will default to reading from the PSGSuite config file (these can also be named in each function call, if preferred).
* If you plan on using this module on multiple computers or between multiple accounts on the same computer, you will need a new PSGoogle config created for each computer / user account pair. Read more here: [Using With Multiple Computers or Admins](https://github.com/nferrell/PSGSuite/wiki/Using-With-Multiple-Computers-or-Admins)

## Credits
Handling the Service Account OAuth procedure in Powershell:
- http://www.thingsthatmademeangry.com/2014/11/google-apps-oauth2-service-account.html

Initial expoloration into Google Apps management via command line:
- https://github.com/jay0lee/GAM  (thank you for all of your help along the way Jay & Ross!)
=======
# PSGSuite-2.0.0

[![Join the chat at https://gitter.im/PSGSuite/Lobby](https://badges.gitter.im/PSGSuite/Lobby.svg)](https://gitter.im/PSGSuite/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## 2.0.0 - Changes

### New Functionality

* All Drive functions now support Team Drives
* Get-GSGmailMessage can now save message attachments to a local path
* File uploads to Drive are now supported (including recursive folder uploads!)
* P12 Keys (service accounts) _and_ client_secrets.json (OAuth) are both now supported

### Breaking Changes in 2.0.0

#### Gmail Delegation Management Removed

The Gmail API does not yet support handling inbox delegation. The functionality addition has been pushed back again until Q3 of 2018. Once the Gmail API supports inbox delegation, those functions will be added.

* Please subscribe to [Issue #8](https://github.com/scrthq/PSGSuite/issues/8) for updates on this topic
* If you have scripts running that use the delegation functions, please have those scripts explicitly import the legacy version or avoid updating to 2.0.0 altogether until 2.1.0 is released with the delegation functions working.
* Delegation functions for reference:
    * Add-GSGmailDelegate
    * Get-GSGmailDelegates
    * Remove-GSGmailDelegate

#### Functions Removed

Please note that not all functions were ported to PSGSuite 2.0.0 due to restrictions within the .NET SDK and deprecated API calls. Here is the list of functions no longer existing in PSGSuite as of 2.0.0:  

* Get-GSToken: no need for this as the keys are being consumed by Googles Auth SDK directly now, which makes Access/Refresh tokens non-existent for P12 Key service accounts and token management is handled automatically
* Revoke-GSToken: same here, no longer needed due to auth service changes
* Start-PSGSuiteConfigWizard: no longer supported as WPF is not compatible outside of Windows


#### Functions Aliased

All other functions are either intact or have an alias included to support backwards compatibility in scripts. Full list of aliases:

```
Alias                             Maps To
-----                             -------
Add-GSDriveFilePermissions        Add-GSDrivePermission
Export-PSGSuiteConfiguration      Set-PSGSuiteConfig
Get-GSCalendarResourceList        Get-GSResourceList
Get-GSDataTransferApplicationList Get-GSDataTransferApplication
Get-GSDriveFileInfo               Get-GSDriveFile
Get-GSDriveFilePermissionsList    Get-GSDrivePermission
Get-GSGmailFilterList             Get-GSGmailFilter
Get-GSGmailLabelList              Get-GSGmailLabel
Get-GSGmailMessageInfo            Get-GmailMessage
Get-GSGroupList                   Get-GSGroup
Get-GSGroupMemberList             Get-GSGroupMember
Get-GSMobileDeviceList            Get-GSMobileDevice
Get-GSOrganizationalUnitList      Get-GSOrganizationalUnit
Get-GSOrgUnit                     Get-GSOrganizationalUnit
Get-GSOrgUnitList                 Get-GSOrganizationalUnit
Get-GSOU                          Get-GSOrganizationalUnit
Get-GSResourceList                Get-GSResource
Get-GSShortURLInfo                Get-GSShortURL
Get-GSTeamDrivesList              Get-GSTeamDrive
Get-GSUserASPList                 Get-GSUserASP
Get-GSUserLicenseInfo             Get-GSUserLicense
Get-GSUserLicenseList             Get-GSUserLicense
Get-GSUserList                    Get-GSUser
Get-GSUserSchemaInfo              Get-GSUserSchema
Get-GSUserSchemaList              Get-GSUserSchema
Get-GSUserTokenList               Get-GSUserToken
Import-PSGSuiteConfiguration      Get-PSGSuiteConfig
Move-GSGmailMessageToTrash        Remove-GSGmailMessage
New-GSCalendarResource            New-GSResource
Remove-GSGmailMessageFromTrash    Restore-GSGmailMessage
Set-PSGSuiteDefaultDomain         Switch-PSGSuiteConfig
Switch-PSGSuiteDomain             Switch-PSGSuiteConfig
Update-GSCalendarResource         Update-GSResource
Update-GSSheetValue               Export-GSSheet
```

## License

[Apache 2.0](https://tldrlegal.com/license/apache-license-2.0-(apache-2.0))
>>>>>>> 6bab2025cd134bea580f4d577c8e5147234a758d
