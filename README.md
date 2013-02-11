# MiniPack

MiniPack creates new NuGet packages in a few easy steps:

1. Create new class library in Visual Studio.
1. Add a Nuspec file and set it to copy to the output directory.
1. Add the Post-Build Event as shown below.
1. Build the project.

MiniPack is a really simple way to create packages from within Visual Studio.
This project merely sets some conventions, then once those conventions are
followed a new .NET project simply has to add a Post-Build Event that
automates adding a package to a local feed.

## Conventions

1. The name of the project, the .dll, the .pdb, and the .nuspec file have
the same name except for the file extension: My.Project.dll and
My.Project.csproj.

## Initial Setup

1. Install the command-line NuGet.exe
1. Clone the project to a location like C:\LocalNugetPackages\.
1. Set the execution policy of scripts in PowerShell for both the 64
and 32 bit versions.
1. Run the bootstrap.ps1 script, which sets a few environment variables.
1. Add post-build event to your class library project. See Post-Build Event.

## Future Projects

After the initial setup the only step that needs to be repeated from
project to project is to add the post-build event.  Of course, if
one were to create a new template project, they'd even remove that step.

## Environment Variables

Either manually or through the bootstrap.ps1 script these environment
variable should be set:

`MP_HOME` is set to the location where the project has been cloned,
and the build-package.ps1 file can be found.

`MP_CONFIGS` is a list of configurations *when* the package should be built,
and copied to the feed.  This helps if you want to build a package only when
the solution is building a specific configuration (perhaps Package).

`MP_PKGS` is a location where the build-package.ps1 script should place
generated .nupkg files.  Typically this is simply Nupkgs inside
the project clone directory, so C:\LocalNugetPackages\Nupkgs.  But it's
not a requirement.

## Post-Build Event:

```
%> powershell.exe -file %mp_home%\build-package.ps1 $(ConfigurationName) $(ProjectName)
```

## Bootstrap Script

This script permanently sets environment variables.  It's mostly a
convenience to ease setup for folks who are unfamiliar with PATH variables.

Running the `bootstrap.ps1` will add the environment variables `MP_HOME`,
`MP_BUILD`, and `MP_PKGS` setting them to the defaults.  The defaults
will be the absolute path of . when the script ran from the directory where
this project was cloned to.  I personally like C:\LocalNugetFeed\.  It will
also add a C:\LocalNugetFeed\Nupkgs where generated packages will be
stored.

## TODO

* Update Post-Build Event to a .bat script that can test for environment
variables before attempting to find and run .ps1 file, since clones of
projects might not have the MiniPack setup.  On those systems the project
should still compile, and not complain during the post-build step.
* Add support for error logging to a file.
* Add support for content directory and such.
* Add some support links to this README.
* Extract the version from the nuspec file in order to increment the version
on each build (if desired).
* Write a script to verify the conventions of each new project, to better
troubleshoot issues.
* Add reporting to the process, which may include adding a new Environment
variable to log information, much like logging errors.
* ... I'm sure there are other things missing.
