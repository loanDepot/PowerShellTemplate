function InvokeDotnetNew {
    <#
        .SYNOPSIS
            Calls dotnet new with any arguments provided to it

        .EXAMPLE
            InvokeDotnetNew --install $Path

        .EXAMPLE
            InvokeDotnetNew PSModule --OutputPath $Path
    #>
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments)]
        $Arguments
    )
    process {
        dotnet new $Arguments
    }
}