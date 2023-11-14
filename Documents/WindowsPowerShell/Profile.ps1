Set-PSReadLineOption -EditMode Emacs

# ghq
if ((Get-Command ghq -ErrorAction SilentlyContinue) -and (Get-Command peco -ErrorAction SilentlyContinue)) {
    function g {
        $dir = ghq list | peco
        if (![string]::IsNullOrEmpty($dir)) {
            $path = (ghq root) + "/$dir"
            Set-Location -LiteralPath $path
        }
    }

    if (Get-Command code -ErrorAction SilentlyContinue) {
        function c {
            $dir = ghq list | peco
            if (![string]::IsNullOrEmpty($dir)) {
                $path = (ghq root) + "/$dir"
                code -n $path
            }
        }
    }
}
