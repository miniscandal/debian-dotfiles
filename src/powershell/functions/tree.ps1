function Get-Tree {
    <#
    .SYNOPSIS
        Custom function to display directory structure using eza.
    #>
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        $RemainingArgs
    )

    $argsList = @("--tree", "--level=2")

    if ($RemainingArgs.Count -gt 0 -and $RemainingArgs[0] -eq "-m") {
        $cleanArgs = $RemainingArgs[1..($RemainingArgs.Count - 1)]
        
        $env:LC_ALL = "C"
        eza $argsList --color=never $cleanArgs
    }
    else {
        eza $argsList --icons $RemainingArgs
    }
}
