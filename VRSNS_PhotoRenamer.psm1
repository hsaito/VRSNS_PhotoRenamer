function Rename-ClusterPhoto {
    [CmdletBinding(SupportsShouldProcess)]
    param(
         [Parameter(Mandatory = $false, Position = 0, HelpMessage = "Location of the cluster photos.")]
        [string]$Location
    )

    if($Location -eq $null)
    {
        $Location = Get-Location
    }

    $items = Get-ChildItem $Location | Where-Object { $_.Name -match "\b[A-F0-9]{8}(?:-[A-F0-9]{4}){3}-[A-F0-9]{12}\b.png" }

    foreach($item in $items)
    {
        $writeTime = $item.CreationTime.ToString("yyyyMMdd_HHmmss")
        $newName =  ("{0}_{1}" -f $writeTime, $item.Name)
        if($PSCmdlet.ShouldProcess("$item -> $newName", "Rename File")){
            Move-Item -Path $item -Destination $newName
        }
    }
}

function Rename-VRChatPhoto {
    [CmdletBinding(SupportsShouldProcess)]
    param(
         [Parameter(Mandatory = $false, Position = 0, HelpMessage = "Location of the VRChat photos.")]
        [string]$Location
    )

    if($Location -eq $null)
    {
        $Location = Get-Location
    }

    $items = Get-ChildItem $Location | Where-Object { $_.Name -match "VRChat_(.*x.*?)_(.*\.*?)\.png" }

    foreach($item in $items)
    {
        $newName = $item.Name -ireplace 'VRChat_(.*x.*?)_(.*\.*?)\.png', 'VRChat_$2_$1.png'
        if($PSCmdlet.ShouldProcess("$item -> $newName", "Rename File")){
            Move-Item -Path $item -Destination $newName
        }
    }
}