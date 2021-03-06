$PackageDir = "Nupkgs"
$DirectoryOfBootstrap = Split-Path $MyInvocation.MyCommand.Path
$ConfigsToBuild = "Debug,Release"
$LocalPackageFeed = "$DirectoryOfBootstrap\$PackageDir"
$ErrorFile = "$DirectoryOfBootstrap\errors.txt"

############################
# Output to console
############################
$DirectoryOfBootstrap
$ConfigsToBuild
$LocalPackageFeed
$PackageDir
$ErrorFile

#######################################
# Create Local Package Feed Directory
#######################################
if (!(test-path $LocalPackageFeed)) {
    mkdir $LocalPackageFeed
}

[Environment]::SetEnvironmentVariable("MP_HOME", $DirectoryOfBootstrap, "Machine")
[Environment]::SetEnvironmentVariable("MP_CONFIGS", $ConfigsToBuild, "Machine")
[Environment]::SetEnvironmentVariable("MP_PKGS", $LocalPackageFeed, "Machine")
[Environment]::SetEnvironmentVariable("MP_ERRORS", $ErrorFile, "Machine")