# PowerShell profile: light-theme readability tweaks for PSReadLine
# Applies only when Windows app theme is Light.

$appsUseLightTheme = $null
try {
    $appsUseLightTheme = Get-ItemPropertyValue -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -ErrorAction Stop
} catch {
    $appsUseLightTheme = $null
}

if (
    $appsUseLightTheme -eq 1 -and
    (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue)
) {
    Set-PSReadLineOption -Colors @{
        Command          = "$($PSStyle.Foreground.FromRgb(0x0E, 0x74, 0x10))"
        Default          = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Member           = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Type             = "$($PSStyle.Foreground.FromRgb(0x1E, 0x1E, 0x1E))"
        Parameter        = "$($PSStyle.Foreground.FromRgb(0x5E, 0x5E, 0x5E))"
        Operator         = "$($PSStyle.Foreground.FromRgb(0x5E, 0x5E, 0x5E))"
        InlinePrediction = "$($PSStyle.Foreground.FromRgb(0x7A, 0x7A, 0x7A))"
    }
}
