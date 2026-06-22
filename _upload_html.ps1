$path = "C:\Users\User\.minimax-agent\projects\tostiburguer\index.html"
$json = "{""file_path"":""$($path -replace '\\','\\')"",""filename"":""index.html"",""mime_type"":""text/html""}"
$tmp = "C:\Users\User\.minimax-agent\projects\tostiburguer\_upload_args\_html.json"
$utf8 = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($tmp, $json, $utf8)
Write-Host "JSON enviado:"
Get-Content $tmp
Write-Host "---"
mavis mcp call matrix matrix_upload_to_cdn --file $tmp