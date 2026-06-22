Add-Type -AssemblyName System.Drawing
$src = "C:\Users\User\.minimax-agent\projects\tostiburguer\imgs"
$totalIn = 0
$totalOut = 0
Get-ChildItem "$src\*.png" | ForEach-Object {
  $inSize = $_.Length
  $totalIn += $inSize
  $img = [System.Drawing.Image]::FromFile($_.FullName)
  $out = Join-Path $src ($_.BaseName + ".jpg")
  $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq "image/jpeg" }
  $p = New-Object System.Drawing.Imaging.EncoderParameters(1)
  $p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [long]85)
  $img.Save($out, $enc, $p)
  $img.Dispose()
  Remove-Item $_.FullName -Force
  $newSize = (Get-Item $out).Length
  $totalOut += $newSize
  Write-Host ("{0,-20} {1,10:N0} -> {2,10:N0} bytes ({3:P0})" -f $_.Name, $inSize, $newSize, ($newSize / $inSize))
}
Write-Host ("TOTAL: {0:N0} -> {1:N0} bytes ({2:P0})" -f $totalIn, $totalOut, ($totalOut / $totalIn))
