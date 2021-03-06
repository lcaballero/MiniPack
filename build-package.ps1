<#
.Parameter ProjectName
     The name used in the .dll, the .nuspec, the .csproj, etc
     
.Parameter LocalFeed 
     Local directory where the package can be placed and then
     referenced by the package manager inside Visual Studio
#>
param (
    [string] $ConfigName,
    [string] $ProjectName)

<#
http://blogs.technet.com/b/heyscriptingguy/archive/2010/01/07/hey-scripting-guy-january-7-2010.aspx

.Parameter ProjectName
     The name used in the .dll, the .nuspec, the .csproj, etc
     
.Parameter LocalFeed 
     Local directory where the package can be placed and then
     referenced by the package manager inside Visual Studio
#>
function Build-Package
{
    param(
        [string] $ProjectName,
        [string] $LocalFeed)

    create-lib

    $dll = "$ProjectName.dll"
    $nuspec = "$ProjectName.nuspec"
    $pdb = "$ProjectName.pdb"
    $nupkg = "$ProjectName.1.0.0.nupkg"

    copy $dll -destination package/lib/net40 
    copy $pdb -destination package/lib/net40 
    copy $nuspec -destination package/

    $make_pkg = "nuget pack -OutputDirectory . -BasePath .\package .\package\$nuspec"
    iex $make_pkg
    
    $copy_pkg = "copy $nupkg -destination $LocalFeed"
    iex $copy_pkg

    $dll
    $nuspec
    $pdb
    $nupkg
    $LocalFeed
    (test-path $nupkg)
   
}

<#
Creates the directory structure used to create a new NuGet package
#>
function Create-Lib
{
    if (test-path package/) { rm -recurse -force package/ }
    
    mkdir package/
    mkdir package/lib/
    mkdir package/lib/net40/
    rm *.nupkg   
}

<#
Build from environment
#>
function Build-From-Env
{
    params(
        [string] $ConfigName,
        [string] $ProjectName)

    # Configs can be comma, colon, or semi-colon separated
    $regex = [regex] ",|:|;"

    # Configs are stored in MP_CONFIGS
    $configs = [Environment]::GetEnvironmentVariable("MP_CONFIGS", "Machine")
    $feed = [Environment]::GetEnvironmentVariable("MP_PKGS", "Machine")

    # Split about the separators
    $split = $regex.split( $configs );

    # Determine if we should run the build
    if ($split -contains $ConfigName) {
        clear
        Build-Package $ProjectName $feed
    }
}


Build-From-Env $ConfigName $ProjectName

