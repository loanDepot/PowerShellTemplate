param($Script:ModuleName = $ModuleName)

Describe $ModuleName {
    BeforeAll {
        $command = InModuleScope $ModuleName {
            Get-Command -Module $ModuleName -Type Function, Cmdlet | ForEach-Object {
                @{
                    Name = $_.Name
                }
            }
        }

        $tests = Get-ChildItem -Path "$PSScriptRoot\.." -Filter "*.Tests.ps1" -Recurse -Name

        $commandHelp = foreach ($command in $commands) {
            $help = Get-Help -Name $command.Name
            $parameters = $command.Parameters.Keys.Where{ $_ -notin [System.Management.Automation.Cmdlet]::CommonParameters }
            @{
                Name        = $command.Name
                Synopsis    = $help.Synopsis
                Description = $help.Description
                Examples    = $help.Examples
                Parameters  = $parameters.ForEach{
                    @{
                        Name        = $command.Parameters["Name"].Name
                        Description = $help.Parameters.Parameter.Where{ $_.Name -eq "Name" }.Description.Text
                    }
                }
            }
        }
    }

    Describe "The <Name> command has help" -ForEach $commandHelp {
        It "Has a Synopsis" {
            $Synopsis | Should Not BeNullOrEmpty
        }
        It "Has a Description" {
            $Description | Should Not BeNullOrEmpty
        }

        It "Has an Example" {
            $Examples | Should Not BeNullOrEmpty
            $Examples | Out-String | Should -Match $Name
        }

        It "Has a description for parameter <Name>" -TestCases $Parameters {
            $Description | Should Not BeNullOrEmpty
        }
    }

    Describe "The <Name> command has tests" -ForEach $command {
        It "Has a pester tests file" {
            $Tests -like "*$Name.Tests.ps1" | Should -Exist
        }
    }
}