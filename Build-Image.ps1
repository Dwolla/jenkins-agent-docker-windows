[CmdletBinding()]
param(
    [parameter(Mandatory = $false)]
    [switch] $Publish = $false
)

Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

Set-Variable -Name repository -Option Constant -Scope Local -Value "jenkins-agent-windows"
Set-Variable -Name organization -Option Constant -Scope Local -Value "dwolla"
Set-Variable -Name windowsHostVersion -Option Constant -Scope Local -Value ((Get-ComputerInfo).WindowsVersion)
Set-Variable -Name versionTag -Option Constant -Scope Local -Value (git.exe --git-dir=$PSScriptRoot/.git rev-parse HEAD)

Set-Variable -Name supportedWindowsVersions -Option Constant -Scope Local -Value @('1809')

Set-Variable -Name builds -Option Constant -Scope Local -Value @{
    "windowsservercore" = @{
        "Folder" = "windowsservercore-$windowsHostVersion";
        "Tags"   = @( "windowsservercore-$windowsHostVersion", "$versionTag-windowsservercore-$windowsHostVersion" );
    };
    'nanoserver'        = @{
        "Folder" = "nanoserver-$windowsHostVersion";
        "Tags"   = @( "nanoserver-$windowsHostVersion", "$versionTag-nanoserver-$windowsHostVersion" );
    };
}

if (!$supportedWindowsVersions.Contains($WindowsHostVersion)) {
    Write-Error "The Windows host version ""{0}"" does not belong to the set of supported versions ""{1}""" -f $windowsHostVersion, $supportedWindowsVersions -Join ","
}

foreach ($build in $builds.Keys) {
    foreach ($tag in $builds[$build]['Tags']) {
        Write-Output "Building $build => tag=$tag"
        $dockerfile = $builds[$build]['Folder'] + "\Dockerfile"
        docker build -f $PSScriptRoot\$dockerfile -t $organization/$repository`:$tag $PSScriptRoot

        if ($Publish) {
            Write-Output "Publishing $build => tag=$tag"
            docker push $organization/$repository`:$tag
        }
    }
}
