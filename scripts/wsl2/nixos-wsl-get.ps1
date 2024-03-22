# Gets the latest release of nixos-wsl from the official repository

function main() {
    # Configure the repository to download from
    $tempFolder = [System.IO.Path]::GetTempPath()
    $output = Join-Path $tempFolder "nixos-wsl.tar.gz"
    $output_hash = Join-Path $tempFolder "nixos-wsl.tar.gz.sha256"

    # Downlaod the OS Archive
    downloadArchive -url (
        getURL -owner "nix-community" -repo "NixOS-WSL" -index 2
    ) -output $output
    downloadArchive -url (
        getURL -owner "nix-community" -repo "NixOS-WSL" -index 3
    ) -output $output_hash

    # Verify the download
    $output_hash = ((Get-Content $output_hash) -split ' ')[0]
    checkIntegrity $output -expectedHash $output_hash
}

function getURL() {
    <#
    .SYNOPSIS
    Gets the URL of the latest release of nixos-wsl from the official repository.
    #>
    param(
        [string]$owner,
        [string]$repo,
        [int]$index
    )

    try {
        $releaseURL = "https://api.github.com/repos/$owner/$repo/releases/latest"
        $releaseData = Invoke-RestMethod -Uri $releaseURL -Method Get

        # Extract the download URL from the response
        return $releaseData.assets[$index].browser_download_url

    }
    catch {
        Write-Error "Error retrieving release information: $_"
    }
}

function downloadArchive() {
    <#
    .SYNOPSIS
    Downloads the given URL to a temporary folder.
    #>

    param(
        [string]$url,
        [string]$output
    )

    try {
        if (Test-Path $output) {
            Write-Host "Skipping existing file: $output"
        }
        else {
            Invoke-WebRequest -Uri $url -OutFile $output
        }
    }
    catch {
        Write-Error "Error downloading archive: $_"
    }
}

function checkIntegrity() {
    <#
    .SYNOPSIS
    Verifies the integrity of the downloaded file.
    #>
    param(
        [string]$output,
        [string]$expectedHash
    )
    $expectedHash = $expectedHash.ToUpper()
    $actualHash = Get-FileHash -Algorithm SHA256 $output | Select-Object -ExpandProperty Hash
    Write-Output "Verifying checksum..."
    Write-Output "Expected: $expectedHash"
    Write-Output "Actual: $actualHash"
    if ($expectedHash -eq $actualHash) {
        Write-Host "Checksum verification successful."
    }
    else {
        Write-Host "Checksum verification failed."
    }
}

# Execute the main function
main
