function Add-GSDocDeletePositionedObjectRequest {
    <#
    .SYNOPSIS
    Creates a DeletePositionedObjectRequest to pass to Submit-GSDocBatchUpdate.

    .DESCRIPTION
    Creates a DeletePositionedObjectRequest to pass to Submit-GSDocBatchUpdate.

    .PARAMETER ObjectId
    Accepts the following type: string

    .EXAMPLE
    Add-GSDocDeletePositionedObjectRequest -ObjectId $objectId
    #>
    [OutputType('Google.Apis.Docs.v1.Data.Request')]
    [CmdletBinding()]
    Param(
        [parameter()]
        [string]
        $ObjectId,
        [parameter(ValueFromPipeline = $true)]
        [Google.Apis.Docs.v1.Data.Request[]]
        $Requests
    )
    Begin {
        Write-Verbose "Adding DeletePositionedObjectRequest to the pipeline"
    }
    Process {
        $Requests
    }
    End {
        $newRequest = New-Object 'Google.Apis.Docs.v1.Data.DeletePositionedObjectRequest'
        foreach ($prop in $PSBoundParameters.Keys | Where-Object {$newRequest.PSObject.Properties.Name -contains $_}) {
            $newRequest.$prop = $PSBoundParameters[$prop]
        }
        New-Object 'Google.Apis.Docs.v1.Data.Request' -Property @{
            DeletePositionedObjec = $newRequest
        }
    }
}
