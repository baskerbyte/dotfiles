$Features = @(
    "FaxServicesClientPackage"
    "IIS-*"
    "Internet-Explorer-Optional-*"
    "LegacyComponents"
    "MediaPlayback"
    "MicrosoftWindowsPowerShellV2"
    "MicrosoftWindowsPowershellV2Root"
    "Printing-PrintToPDFServices-Features"
    "Printing-XPSServices-Features"
    "WorkFolders-Client"
)

foreach ($Feature in $Features) {
    Get-WindowsOptionalFeature -Online -FeatureName $Feature | Where-Object State -Like "Enabled" | Disable-WindowsOptionalFeature -Online -NoRestart -Remove
}