# Gets the latest release of nixos-wsl from the official repository

$url = "http://example.com/archive.zip"
$tempFolder = [System.IO.Path]::GetTempPath()
$output = Join-Path $tempFolder "nixos-wsl.tar.gz"

Invoke-WebRequest -Uri $url -OutFile $output
