if ([String]::IsNullOrEmpty($env:APPVEYOR_BUILD_FOLDER))
{
    $rootPath = ".\";
}
else
{
    $rootPath = $env:APPVEYOR_BUILD_FOLDER
}

Set-Location $rootPath
git submodule update --init --recursive -q
if (!$?)
{
    Write-Error "Git submodule update failed."
    Throw "Git submodule update failed."
}
else
{
    Write-Host "Git submodule update succeeded." -ForegroundColor Green
}

$manifest = [System.IO.Path]::Combine($rootPath, "edgeextension\manifest")
$key = [System.IO.Path]::Combine($rootPath, "Electsys_StoreKey.pfx")
$appx = [System.IO.Path]::Combine($rootPath, "edgeextension\package\edgeExtension.appx")

$signtool = "C:\Program Files (x86)\Windows Kits\10\bin\x86\signtool.exe"

manifoldjs -l debug -p edgeextension package $manifest
&$signtool sign /fd sha256 /a /f $key $appx
if (!$?)
{
    Write-Error "Package signing failed."
    Throw "Package signing failed."
}
else 
{
    Write-Host "Package signing succeeded." -ForegroundColor Green
}

$cer = [System.IO.Path]::Combine($rootPath, "edgeextension\package\Electsys_StoreKey.cer");
Get-PfxCertificate -FilePath $key | Export-Certificate -FilePath $cer -Type CERT
if (!$?)
{
    Write-Error "Certificate export failed."
    Throw "Certificate export failed."
}
else 
{
    Write-Host "Certificate export succeeded." -ForegroundColor Green
}

[String]::Format("The appx is at {0}.`nThe certificate is at {1}. ", $appx, $cer) |
Write-Host -ForegroundColor Green