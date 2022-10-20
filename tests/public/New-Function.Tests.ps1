param($ModuleName = $ModuleName)
Describe "New-Function" {
    BeforeAll {
        $CommandUnderTest = Get-Command New-Function
        # We don't want to affect the global PSDefaultParameterValues
        $PSDefaultParameterValues = $PSDefaultParameterValues + @{
            "Mock:ModuleName"              = $ModuleName
            "Assert-MockCalled:ModuleName" = $ModuleName
            "Assert-MockCalled:Scope"      = "Context"
        }
    }

    Context "Parameter Validation" {
        It "Requires ModuleName as a mandatory parameter" {
            $CommandUnderTest | Should -HaveParameter ModuleName -Mandatory
        }

        It "Supports Path as an optional parameter" {
            $CommandUnderTest | Should -HaveParameter Path
        }
    }

    # If we want to reinitialise a mock before each context block, we can use BeforeEach


    # We cannot guarantee that the build server has the prerequisite dotnet installation
    # So we test the function to see that it proceeds as we'd expect.
    Context "Example 1: Invoke-Thing" {
        It "Serves as a placeholder" {
            $result = Invoke-Thing
            $result | Should -Be "something"
        }
    }
}
