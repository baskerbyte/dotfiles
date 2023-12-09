$Capabilities = @(
    "App.StepsRecorder*"
    "Browser.InternetExplorer*"
    "MathRecognizer*"
    "Microsoft.Windows.PowerShell.ISE*"
    "Microsoft.Windows.WordPad*"
    "Print.Fax.Scan*" 
    "Print.Management.Console*" 
    "Hello.Face*"
)

foreach ($Capability in $Capabilities) {
    Get-WindowsCapability -Online -Name "$Capability" | Where-Object State -eq "Installed" | Remove-WindowsCapability -Online
}