if ([String]::IsNullOrEmpty($env:APPVEYOR_BUILD_FOLDER))
{
    $rootPath = "./";
}
else
{
    $rootPath = $env:APPVEYOR_BUILD_FOLDER
}

$manifest = [System.IO.Path]::Combine($rootPath, "edgeextension\manifest")
$key = [System.IO.Path]::Combine($rootPath, "Electsys_StoreKey.pfx")
$appx = [System.IO.Path]::Combine($rootPath, "edgeextension\package\edgeExtension.appx")

if ([String]::IsNullOrWhiteSpace($signtool))
{
    $signtool = "C:\Program Files (x86)\Windows Kits\10\bin\x86\signtool.exe"
}
manifoldjs -l debug -p edgeextension package $manifest
&$signtool sign /fd sha256 /a /f $key $appx