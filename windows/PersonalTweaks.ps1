$PathToCUExplorerAdvanced = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$PathToCUExplorer = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"
$PathToCUThemes = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes"
$PathToCUWindowsSearch = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
$PathToStart = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Start"

# Windows theme
New-ItemProperty -Path "$PathToCUThemes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUThemes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUThemes" -Name "CurrentTheme" -Value "C:\Windows\resources\Themes\dark.theme" -PropertyType String -Force
New-ItemProperty -Path "$PathToCUThemes" -Name "ThemeMRU" -Value "C:\Windows\resources\Themes\dark.theme;" -PropertyType String -Force

# Explorer
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "HideRecommendedSection" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorer" -Name "ShowFrequent" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorer" -Name "ShowRecent" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "Hidden" -Value 1 -PropertyType DWORD -Force

# Taskbar
New-ItemProperty -Path "$PathToCUWindowsSearch" -Name "SearchboxTaskbarMode" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "ShowTaskViewButton" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "TaskbarDa" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "ShowCopilotButton" -Value 0 -PropertyType DWORD -Force

# Start
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "Start_Layout" -Value 1 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "Start_IrisRecommendations" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToCUExplorerAdvanced" -Name "Start_TrackDocs" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToStart" -Name "ShowRecentList" -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path "$PathToStart" -Name "ShowFrequentList" -Value 0 -PropertyType DWORD -Force

# Power
powercfg -Change Monitor-Timeout-AC 5
powercfg -Change Monitor-Timeout-DC 10

powercfg -Change Hibernate-Timeout-AC 0
powercfg -Change Hibernate-Timeout-DC 0

powercfg -Change Standby-Timeout-AC 15
powercfg -Change Standby-Timeout-DC 15

powercfg -Change Disk-Timeout-AC 0
powercfg -Change Disk-Timeout-DC 0

Stop-Process -Name explorer