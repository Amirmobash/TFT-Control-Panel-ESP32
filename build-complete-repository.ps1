# Downloads original repository files, overlays reviewed documentation and writes a ZIP.
# Firmware source is preserved byte-for-byte from the downloaded repository archive.
$ErrorActionPreference = 'Stop'
$base = Split-Path -Parent $MyInvocation.MyCommand.Path
$temp = Join-Path $env:TEMP ('esp32_repo_' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp | Out-Null
try {
  $archive = Join-Path $temp 'original.zip'
  Invoke-WebRequest -Uri 'https://github.com/Amirmobash/TFT-Control-Panel-ESP32/archive/refs/heads/main.zip' -OutFile $archive
  Expand-Archive -Path $archive -DestinationPath (Join-Path $temp 'source')
  $root = Get-ChildItem (Join-Path $temp 'source') -Directory | Select-Object -First 1
  if (-not $root) { throw 'Source archive did not contain a repository directory.' }
  foreach ($file in @('README.md','README.de.md','HARDWARE.md','SECURITY.md')) {
    Copy-Item (Join-Path $base $file) (Join-Path $root.FullName $file) -Force
  }
  $output = Join-Path $base 'TFT-Control-Panel-ESP32-EN-DE-Complete.zip'
  if (Test-Path $output) { Remove-Item $output }
  Compress-Archive -Path (Join-Path $root.FullName '*') -DestinationPath $output -CompressionLevel Optimal
  Write-Host "Created: $output"
  Write-Host 'Inspect and test firmware before uploading.'
}
finally { Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue }
