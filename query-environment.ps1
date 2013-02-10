<#
Simple script to examine what is set for the Mini Pack (MP) environment
variables.
#>
clear

function get-var {
    param($name)
    [Environment]::GetEnvironmentVariable($name, "Machine")    
}

@{
    "MP_HOME" = get-var "MP_HOME";
    "MP_CONFIGS" = get-var "MP_CONFIGS";
    "MP_PKGS" = get-var "MP_PKGS";
    "MP_ERRORS" = get-var "MP_ERRORS"
}
    
