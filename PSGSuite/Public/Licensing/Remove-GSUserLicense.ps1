function Remove-GSUserLicense {
    <#
    .SYNOPSIS
    Removes a license assignment from a user
    
    .DESCRIPTION
    Removes a license assignment from a user. Useful for restoring a user from a Vault-Former-Employee to an auto-assigned G Suite Business license by removing the Vault-Former-Employee license, for example.
    
    .PARAMETER User
    The user's current primary email address
    
    .PARAMETER License
    The license SKU to remove from the user
    
    .EXAMPLE
    Remove-GSUserLicense -User joe -License Google-Vault-Former-Employee

    Removes the Vault-Former-Employee license from Joe
    #>
    [cmdletbinding(SupportsShouldProcess = $true,ConfirmImpact = "High")]
    Param
    (
        [parameter(Mandatory = $true,Position = 0,ValueFromPipeline = $true,ValueFromPipelineByPropertyName = $true)]
        [Alias("PrimaryEmail","UserKey","Mail")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $User,
        [parameter(Mandatory = $true,Position = 1)]
        [Alias("SkuId")]
        [ValidateSet("G-Suite-Enterprise","Google-Apps-Unlimited","Google-Apps-For-Business","Google-Apps-For-Postini","Google-Apps-Lite","Google-Drive-storage-20GB","Google-Drive-storage-50GB","Google-Drive-storage-200GB","Google-Drive-storage-400GB","Google-Drive-storage-1TB","Google-Drive-storage-2TB","Google-Drive-storage-4TB","Google-Drive-storage-8TB","Google-Drive-storage-16TB","Google-Vault","Google-Vault-Former-Employee","1010020020")]
        [string]
        $License
    )
    Begin {
        $serviceParams = @{
            Scope       = 'https://www.googleapis.com/auth/apps.licensing'
            ServiceType = 'Google.Apis.Licensing.v1.LicensingService'
        }
        $service = New-GoogleService @serviceParams
        $productHash = @{
            '1010020020'                   = 'Google-Apps'
            'G-Suite-Enterprise'           = 'Google-Apps'
            'Google-Apps-Unlimited'        = 'Google-Apps'
            'Google-Apps-For-Business'     = 'Google-Apps'
            'Google-Apps-For-Postini'      = 'Google-Apps'
            'Google-Apps-Lite'             = 'Google-Apps'
            'Google-Vault'                 = 'Google-Vault'
            'Google-Vault-Former-Employee' = 'Google-Vault'
            'Google-Drive-storage-20GB'    = 'Google-Drive-storage'
            'Google-Drive-storage-50GB'    = 'Google-Drive-storage'
            'Google-Drive-storage-200GB'   = 'Google-Drive-storage'
            'Google-Drive-storage-400GB'   = 'Google-Drive-storage'
            'Google-Drive-storage-1TB'     = 'Google-Drive-storage'
            'Google-Drive-storage-2TB'     = 'Google-Drive-storage'
            'Google-Drive-storage-4TB'     = 'Google-Drive-storage'
            'Google-Drive-storage-8TB'     = 'Google-Drive-storage'
            'Google-Drive-storage-16TB'    = 'Google-Drive-storage'
        }
    }
    Process {
        try {
            foreach ($U in $User) {
                if ($U -notlike "*@*.*") {
                    $U = "$($U)@$($Script:PSGSuite.Domain)"
                }
                if ($PSCmdlet.ShouldProcess("Revoking license '$License' from user '$U'")) {
                    Write-Verbose "Revoking license '$License' from user '$U'"
                    if ($License -eq "G-Suite-Enterprise") {
                        $License = "1010020020"
                    }
                    $request = $service.LicenseAssignments.Delete($productHash[$License],$License,$U)
                    $request.Execute()
                    Write-Verbose "License revoked for user '$U'"
                }
            }
        }
        catch {
            if ($ErrorActionPreference -eq 'Stop') {
                $PSCmdlet.ThrowTerminatingError($_)
            }
            else {
                Write-Error $_
            }
        }
    }
}