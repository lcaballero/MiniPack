# MiniPack

MiniPack is a really simple way to create packages from within Visual Studio.
This project merely sets some conventions, then once those conventions are
followed a new .NET project simply has to add a Post-Build Event that
automates adding a package to a local feed (some location at the root
C:\ level).

## Initial Setup

1. Clone the project.
1. Set the execution policy of scripts in PowerShell for both the 64
and 32 bit versions.
1. Run the bootstrap.ps1 script.
1. Add post-build event.

### Adding Additional projects

After the initial setup the only step that needs to be repeated for future
projects is to add the post-build event.

## Environment Variables

Either manually or through the bootstrap.ps1 script these environment
variable should be set:

`MP_HOME` is set to the location where the project has been cloned,
and the build-package.ps1 file can be found.

`MP_CONFIGS` is a list of configurations *when* the package should be built,
and copied to the feed.  This helps if you want to build a package only when
the solution is building a specific configuration (perhaps Package).

`MP_PKGS` is a location where the build-package.ps1 script should place
generation .nupkg files.  Typically this is simply Nupkgs inside
the clone of this project (which is cloned to the root C:\ drive).  But
it's not a requirement, especially if this offends one's sensibilities.



## Post-Build Event:

```
%> %windir%\System32\WindowsPowerShell\v1.0\powershell.exe -file .\build-package.ps1 $(ConfigurationName) $(ProjectName)
```

## Bootstrap Script

This script permanently sets environment variables.  It's mostly a
convenience to ease setup for folks who are unfamiliar with PATH variables.

Running the `bootstrap.ps1` will add the environment variables `MP_HOME`,
`MP_BUILD`, and `MP_PKGS` setting them to the defaults.  The defaults
will be the absolute path of . when the script ran from the directory where
this project was cloned to.  I personally like C:\LocalNugetFeed\.



## TODO

* Add support for error logging to a file
* Add support for content directory and such
* .... I'm sure there are other things missing
