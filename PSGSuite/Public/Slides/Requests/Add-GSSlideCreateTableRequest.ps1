function Add-GSSlideCreateTableRequest {
    <#
    .SYNOPSIS
    Creates a CreateTableRequest to pass to Submit-GSSlideBatchUpdate.

    .DESCRIPTION
    Creates a CreateTableRequest to pass to Submit-GSSlideBatchUpdate.

    .PARAMETER Columns
    Accepts the following type: System.Nullable[int]

    .PARAMETER ElementProperties
    Accepts the following type: Google.Apis.Slides.v1.Data.PageElementProperties

    .PARAMETER ObjectId
    Accepts the following type: string

    .PARAMETER Rows
    Accepts the following type: System.Nullable[int]

    .EXAMPLE
    Add-GSSlideCreateTableRequest -Columns $columns -ElementProperties $elementProperties -ObjectId $objectId -Rows $rows
    #>
    [OutputType('Google.Apis.Slides.v1.Data.Request')]
    [CmdletBinding()]
    Param(
        [parameter()]
        [System.Nullable[int]]
        $Columns,
        [parameter()]
        [Google.Apis.Slides.v1.Data.PageElementProperties]
        $ElementProperties,
        [parameter()]
        [string]
        $ObjectId,
        [parameter()]
        [System.Nullable[int]]
        $Rows,
        [parameter(ValueFromPipeline = $true)]
        [Google.Apis.Slides.v1.Data.Request[]]
        $Requests
    )
    Begin {
        Write-Verbose "Adding CreateTableRequest to the pipeline"
    }
    Process {
        $Requests
    }
    End {
        $newRequest = New-Object 'Google.Apis.Slides.v1.Data.CreateTableRequest'
        foreach ($prop in $PSBoundParameters.Keys | Where-Object {$newRequest.PSObject.Properties.Name -contains $_}) {
            $newRequest.$prop = $PSBoundParameters[$prop]
        }
        New-Object 'Google.Apis.Slides.v1.Data.Request' -Property @{
            CreateTabl = $newRequest
        }
    }
}
