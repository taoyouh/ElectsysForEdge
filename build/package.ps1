if ([String]::IsNullOrWhiteSpace($signtool))
{
    $signtool = "C:\Program Files (x86)\Windows Kits\10\bin\x86\signtool.exe"
}
manifoldjs -l debug -p edgeextension package .\edgeextension\manifest
&$signtool sign /fd sha256 /a /f .\Electsys_StoreKey.pfx .\edgeextension\package\edgeExtension.appx