$src = "C:\Users\User\.minimax-agent\projects\tostiburguer\imgs"
$tmpDir = "C:\Users\User\.minimax-agent\projects\tostiburguer\_upload_args"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$results = [ordered]@{}
Get-ChildItem "$src\*.jpg" | Sort-Object Name | ForEach-Object {
  $name = $_.Name
  $path = $_.FullName -replace '\\', '\\'
  $json = "{""file_path"":""$path"",""filename"":""$name""}"
  $tmp = Join-Path $tmpDir ("_u_" + $_.BaseName + ".json")
  [System.IO.File]::WriteAllText($tmp, $json, $utf8NoBom)
  Write-Host "Subiendo $name..." -NoNewline
  $out = mavis mcp call matrix matrix_upload_to_cdn --file $tmp 2>&1 | Out-String
  Remove-Item $tmp -Force
  $url = ""
  if ($out -match '"cdn_url"\s*:\s*"([^"]+)"') { $url = $matches[1] }
  elseif ($out -match '"url"\s*:\s*"([^"]+)"') { $url = $matches[1] }
  $results[$name] = $url
  if ($url) { Write-Host (" OK -> {0}" -f $url) } else { Write-Host " FAIL"; Write-Host $out.Substring(0, [Math]::Min(200, $out.Length)) }
}
$jsonOut = $results | ConvertTo-Json
[System.IO.File]::WriteAllText((Join-Path $tmpDir "cdn_urls.json"), $jsonOut, $utf8NoBom)
Write-Host ""
Write-Host "=== Total subidas: $($results.Count) | OK: $(($results.Values | Where-Object { $_ }).Count) ==="