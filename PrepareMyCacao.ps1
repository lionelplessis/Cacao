# Description: Boxstarter Script  
# Author: Laurent Kempé
# Dev settings for my app development

Disable-UAC


#--- Windows Features ---
# Show hidden files, Show protected OS files, Show file extensions
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions

#--- File Explorer Settings ---
# will expand explorer to the actual folder you're in
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
#adds things back in your left pane like recycle bin
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
#opens PC to This PC, not quick access
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1
#taskbar where window is open for multi-monitor
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

#--- Uninstall unecessary applications that come with Windows out of the box ---
Write-Host "Uninstall some applications that come with Windows out of the box" -ForegroundColor "Yellow"

function removeApp {
	Param ([string]$appName)
	Write-Output "Trying to remove $appName"
	Get-AppxPackage $appName -AllUsers | Remove-AppxPackage
	Get-AppXProvisionedPackage -Online | Where DisplayNam -like $appName | Remove-AppxProvisionedPackage -Online
}

$applicationList = @(
	"Microsoft.BingFinance"
	#"Microsoft.3DBuilder"
	"Microsoft.BingNews"
	"Microsoft.BingSports"
	"Microsoft.BingWeather"
	#"Microsoft.CommsPhone"
	"Microsoft.Getstarted"
	#"Microsoft.WindowsMaps"
	"*MarchofEmpires*"
	"Microsoft.GetHelp"
	#"Microsoft.Messaging"
	"*Minecraft*"
	#"Microsoft.MicrosoftOfficeHub"
	#"Microsoft.OneConnect"
	"Microsoft.WindowsPhone"
	#"Microsoft.WindowsSoundRecorder"
	"*Solitaire*"
	"Microsoft.MicrosoftStickyNotes"
	#"Microsoft.Office.Sway"
	"Microsoft.XboxApp"
	"Microsoft.XboxIdentityProvider"
	#"Microsoft.ZuneMusic"
	#"Microsoft.ZuneVideo"
	#"Microsoft.NetworkSpeedTest"
	#"Microsoft.FreshPaint"
	#"Microsoft.Print3D"
	#"*Autodesk*"
	"*BubbleWitch*"
            "king.com*"
	#"*Plex*"
);

foreach ($app in $applicationList) {
    removeApp $app
}


#--- Windows Subsystems/Features ---
# choco install -y Microsoft-Hyper-V-All -source windowsFeatures
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

#--- Tools ---
#--- Installing VS
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community 
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community 
# visualstudio2017professional
# visualstudio2017enterprise

choco install visualstudio2017professional -y --package-parameters "--add Microsoft.VisualStudio.Component.Git" 
Update-SessionEnvironment #refreshing env due to Git install

#--- Desktop and web workloads ---
choco install -y visualstudio2017-workload-manageddesktop
choco install -y visualstudio2017-workload-netweb

#--- Define Packages to Install ---
$Packages = 'git',`
            #'poshgit',`
            'visualstudiocode',`
            'notepadplusplus',`
            'nodejs',`
            'FiraCode',`
            'SourceTree',`
            'snoop',`
            'fiddler',`
            'keepass',`
            'cmdermini',`
            '7zip.install',`
            #'ngrok.portable',`
            #'winscp',`
            'GoogleChrome',`
            'Firefox',`
            #'paint.net',`
            #'rapidee',`
            'sharex',`
            'SwissFileKnife',`
            'sysinternals',`
            'windirstat',`
            #'rufus',`
            'openvpn',`
            'dropbox',`
            'ozcode-vs2017',`
            'resharper-ultimate-all /NoCpp'

#--- Install Packages ---
ForEach ($PackageName in $Packages)
{choco install $PackageName -y}

#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
