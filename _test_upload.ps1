$json = '{"file_path":"C:\\Users\\User\\.minimax-agent\\projects\\tostiburguer\\imgs\\logo.jpg","filename":"logo.jpg"}'
[System.IO.File]::WriteAllText("C:\Users\User\.minimax-agent\projects\tostiburguer\_upload_args\_test.json", $json, (New-Object System.Text.UTF8Encoding $false))
Write-Host "JSON content:"
Get-Content "C:\Users\User\.minimax-agent\projects\tostiburguer\_upload_args\_test.json"
Write-Host "---"
Write-Host "Calling mavis..."
mavis mcp call matrix matrix_upload_to_cdn --file "C:\Users\User\.minimax-agent\projects\tostiburguer\_upload_args\_test.json"