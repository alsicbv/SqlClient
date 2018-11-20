# Script: buildfunctionaltests.ps1
# Author: Keerat Singh
# Date:   14-Nov-2018
# Comments: This script builds the functional tests and its dependencies with specified arguments.
#

param(
    [Parameter(Mandatory=$true)]
    [string]$Configuration,
    [Parameter(Mandatory=$true)]
    [string]$Platform,
    [Parameter(Mandatory=$true)]
    [string]$ProjectRoot,
    [Parameter(Mandatory=$true)]
    [string]$TestTargetOS
    )

    $buildTool = 'dotnet msbuild'
    $testPath = "$ProjectRoot/src/Microsoft.Data.SqlClient/tests"
    # Restore required dependencies
    Function RestorePackages()
    {
        
        $buildCmd = "dotnet restore '$testPath/FunctionalTests/Microsoft.Data.SqlClient.Tests.csproj' /p:TestTargetOS='$TestTargetOS'"
        Write-Output "*************************************** Restoring Packages ***************************************"
        Write-Output $buildCmd
        Write-Output "******************************************************************************"
        Invoke-Expression  $buildCmd
    }

    Function SetBuildArguments()
    {
        if ($TestTargetOS -like "*Windows*" -and  $Platform -like "x86")
        {
            $Platform = 'Win32'
        }

        $buildArguments = "/p:Platform='$Platform' /p:Configuration='$Configuration' /p:TestTargetOS='$TestTargetOS' /p:BuildProjectReferences=false"

        if($TestTargetOS -like "*Unix*")
        {
            $buildArguments = $buildArguments + " /p:TargetsWindows=false /p:TargetsUnix=true"
        }
        
        return $buildArguments
    }
    Function BuildTests()
    {
        $buildArguments = SetBuildArguments
        $projectPaths = "$testPath/tools/TDS/TDS/TDS.csproj",
                        "$testPath/tools/TDS/TDS.EndPoint/TDS.EndPoint.csproj",
                        "$testPath/tools/TDS/TDS.Servers/TDS.Servers.csproj",
                        "$testPath/tools/CoreFx.Private.TestUtilities/CoreFx.Private.TestUtilities.csproj",
                        "$testPath/ManualTests/SQL/UdtTest/UDTs/Address/Address.csproj",
                        "$testPath/FunctionalTests/Microsoft.Data.SqlClient.Tests.csproj"

        foreach ($projectPath in $projectPaths)
        {
            $buildCmd = "$buildTool $projectPath $buildArguments"
            Write-Output "*************************************** Build Command ***************************************"
            Write-Output $buildCmd
            Write-Output "******************************************************************************"
            Invoke-Expression  $buildCmd
        }
    }
    RestorePackages
    BuildTests