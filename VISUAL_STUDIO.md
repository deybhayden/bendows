# Visual Studio 2022

```shell
winget install "Visual Studio Community 2022"  --override "--add Microsoft.VisualStudio.Workload.ManagedDesktop Microsoft.VisualStudio.ComponentGroup.WindowsAppSDK.Cs" -s msstore
```

## Themes

"Use System Setting" is what I want long term, but until you can choose the Light & Dark themes for VS, it must be set manually for now because it picks "Blue" as the default Light theme.

- [Flexible VS Themes](https://devblogs.microsoft.com/visualstudio/flexible-theming-visual-studio/#set-your-visual-studio-theme-to-match-windows-theme)
- [Pick custom themes to coordinate with system settings](https://developercommunity.visualstudio.com/t/Pick-custom-themes-to-coordinate-with-sy/1493853?space=8)

## Extensions

- [Template Studio for WinUI](https://marketplace.visualstudio.com/items?itemName=TemplateStudio.TemplateStudioForWinUICs)
- [Open in VS Code](https://marketplace.visualstudio.com/items?itemName=MadsKristensen.OpeninVisualStudioCode)
- [Xaml Styler](https://marketplace.visualstudio.com/items?itemName=TeamXavalon.XAMLStyler)
- [AWS Toolkit for Visual Studio](https://marketplace.visualstudio.com/items?itemName=AmazonWebServices.AWSToolkitforVisualStudio2022)

## Repair

VS 2022 repair steps: https://docs.microsoft.com/en-us/visualstudio/install/repair-visual-studio?view=vs-2022

It will remove some extensions, but not all. Several settings are set back to default as well. But fixed the 17.5.3 upgrade hanging on solution load.
