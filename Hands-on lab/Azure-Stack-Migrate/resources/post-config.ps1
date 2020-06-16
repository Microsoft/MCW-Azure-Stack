Param (
    [Parameter(Mandatory=$true)]
    [string]
    $Username = "__administrator"
)
$ErrorActionPreference = 'SilentlyContinue'


function DownloadWithRetry([string] $Uri, [string] $DownloadLocation, [int] $Retries = 5, [int]$RetryInterval = 10)
{
    while($true)
    {
        try
        {
            Start-BitsTransfer -Source $Uri -Destination $DownloadLocation -DisplayName $Uri
            break
        }
        catch
        {
            $exceptionMessage = $_.Exception.Message
            Write-Host "Failed to download '$Uri': $exceptionMessage"
            if ($retries -gt 0) {
                $retries--
                Write-Host "Waiting $RetryInterval seconds before retrying. Retries left: $Retries"
                Clear-DnsClientCache
                Start-Sleep -Seconds $RetryInterval
    
            }
            else
            {
                $exception = $_.Exception
                throw $exception
            }
        }
    }
}

$defaultLocalPath = "C:\AzureStackOnAzureVM"
New-Item -Path $defaultLocalPath -ItemType Directory -Force

$logFileFullPath = "$defaultLocalPath\postconfig.log"
$writeLogParams = @{
    LogFilePath = $logFileFullPath
}

DownloadWithRetry -Uri "https://raw.githubusercontent.com/yagmurs/AzureStack-VM-PoC/master/config.ind" -DownloadLocation "$defaultLocalPath\config.ind"
$gitbranchconfig = Import-Csv -Path $defaultLocalPath\config.ind -Delimiter ","
$gitbranchcode = $gitbranchconfig.branch.Trim()
$gitbranch = "https://raw.githubusercontent.com/yagmurs/AzureStack-VM-PoC/$gitbranchcode"

DownloadWithRetry -Uri "$gitbranch/scripts/ASDKHelperModule.psm1" -DownloadLocation "$defaultLocalPath\ASDKHelperModule.psm1"

if (Test-Path "$defaultLocalPath\ASDKHelperModule.psm1")
{
    Import-Module "$defaultLocalPath\ASDKHelperModule.psm1"
}
else
{
    throw "required module $defaultLocalPath\ASDKHelperModule.psm1 not found"   
}

#Download Install-ASDK.ps1 (installer)
DownloadWithRetry -Uri "$gitbranch/scripts/Install-ASDK.ps1" -DownloadLocation "$defaultLocalPath\Install-ASDK.ps1"

#Download and extract Mobaxterm
DownloadWithRetry -Uri "https://aka.ms/mobaxtermLatest" -DownloadLocation "$defaultLocalPath\Mobaxterm.zip"
Expand-Archive -Path "$defaultLocalPath\Mobaxterm.zip" -DestinationPath "$defaultLocalPath\Mobaxterm"
Remove-Item -Path "$defaultLocalPath\Mobaxterm.zip" -Force

#Enable remoting firewall rule
Get-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC | Get-NetFirewallAddressFilter | Set-NetFirewallAddressFilter -RemoteAddress any -PassThru -OutVariable firewallRuleResult | Get-NetFirewallRule | Enable-NetFirewallRule
Write-Log @writeLogParams -Message $firewallRuleResult
Remove-Variable -Name firewallRuleResult -Force -ErrorAction SilentlyContinue

#Disables Internet Explorer Enhanced Security Configuration
Disable-InternetExplorerESC

#Enable Internet Explorer File download
New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' -Force
New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0' -Force
New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' -Name 1803 -Value 0 -PropertyType DWORD -Force
New-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\0' -Name 1803 -Value 0 -PropertyType DWORD -Force


$AzureImage = $true
if ($AzureImage)
{
    New-Item HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials -Force
    New-Item HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentials -Name 1 -Value "wsman/*" -Type STRING -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Name 1 -Value "wsman/*" -Type STRING -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentials -Value 1 -Type DWORD -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentialsWhenNTLMOnly -Value 1 -Type DWORD -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name ConcatenateDefaults_AllowFresh -Value 1 -Type DWORD -Force
    Set-ItemProperty -LiteralPath HKLM:\Software\Policies\Microsoft\Windows\CredentialsDelegation -Name ConcatenateDefaults_AllowFreshNTLMOnly -Value 1 -Type DWORD -Force
    Set-Item -Force WSMan:\localhost\Client\TrustedHosts "*"
    Enable-WSManCredSSP -Role Client -DelegateComputer "*" -Force
    Enable-WSManCredSSP -Role Server -Force

    Install-PackageProvider nuget -Force

    Set-ExecutionPolicy unrestricted -Force

    #Download ASDK Downloader
    DownloadWithRetry -Uri "https://aka.ms/azurestackdevkitdownloader" -DownloadLocation "D:\AzureStackDownloader.exe"

    if (!($AsdkFileList))
    {
        $AsdkFileList = @("AzureStackDevelopmentKit.exe")
        1..10 | ForEach-Object {$AsdkFileList += "AzureStackDevelopmentKit-$_" + ".bin"}
    }

    $latestASDK = (findLatestASDK -asdkURIRoot "https://azurestack.azureedge.net/asdk" -asdkFileList $AsdkFileList)[0]


    #Download ASDK files (BINs and EXE)
    Write-Log @writeLogParams -Message "Finding available ASDK versions"

    $asdkDownloadPath = "d:\"
    $asdkExtractFolder = "Azure Stack Development Kit"

    $asdkFiles = ASDKDownloader -Version $latestASDK -Destination $asdkDownloadPath

    Write-Log @writeLogParams -Message "$asdkFiles"
        
    #Extracting Azure Stack Development kit files
                
    $f = Join-Path -Path $asdkDownloadPath -ChildPath $asdkFiles[0].Split("/")[-1]
    $d = Join-Path -Path $asdkDownloadPath -ChildPath $asdkExtractFolder

    Write-Log @writeLogParams -Message "Extracting Azure Stack Development kit files;"
    Write-Log @writeLogParams -Message "to $d"

    ExtractASDK -File $f -Destination $d

    $vhdxFullPath = Join-Path -Path $d -ChildPath "cloudbuilder.vhdx"
    $foldersToCopy = @('CloudDeployment', 'fwupdate', 'tools')

    if (Test-Path -Path $vhdxFullPath)
    {
        Write-Log @writeLogParams -Message "About to Start Copying ASDK files to C:\"
        Write-Log @writeLogParams -Message "Mounting cloudbuilder.vhdx"
        try {
            $driveLetter = Mount-DiskImage -ImagePath $vhdxFullPath -StorageType VHDX -Passthru | Get-DiskImage | Get-Disk | Get-Partition | Where-Object size -gt 500MB | Select-Object -ExpandProperty driveletter
            Write-Log @writeLogParams -Message "The drive is now mounted as $driveLetter`:"
        }
        catch {
            Write-Log @writeLogParams -Message "an error occured while mounting cloudbuilder.vhdx file"
            Write-Log @writeLogParams -Message $error[0].Exception
            throw "an error occured while mounting cloudbuilder.vhdxf file"
        }

        foreach ($folder in $foldersToCopy)
        {
            Write-Log @writeLogParams -Message "Copying folder $folder to $destPath"
            Copy-Item -Path (Join-Path -Path $($driveLetter + ':') -ChildPath $folder) -Destination C:\ -Recurse -Force
            Write-Log @writeLogParams -Message "$folder done..."
        }
        Write-Log @writeLogParams -Message "Dismounting cloudbuilder.vhdx"
        Dismount-DiskImage -ImagePath $vhdxFullPath       
    } 
        
     
    


    # Enable differencing roles from ASDKImage except .NET framework 3.5
    Enable-WindowsOptionalFeature -Online -All -NoRestart -FeatureName @("ActiveDirectory-PowerShell","DfsMgmt","DirectoryServices-AdministrativeCenter","DirectoryServices-DomainController","DirectoryServices-DomainController-Tools","DNS-Server-Full-Role","DNS-Server-Tools","DSC-Service","FailoverCluster-AutomationServer","FailoverCluster-CmdInterface","FSRM-Management","IIS-ASPNET45","IIS-HttpTracing","IIS-ISAPIExtensions","IIS-ISAPIFilter","IIS-NetFxExtensibility45","IIS-RequestMonitor","ManagementOdata","NetFx4Extended-ASPNET45","NFS-Administration","RSAT-ADDS-Tools-Feature","RSAT-AD-Tools-Feature","Server-Manager-RSAT-File-Services","UpdateServices-API","UpdateServices-RSAT","UpdateServices-UI","WAS-ConfigurationAPI","WAS-ProcessModel","WAS-WindowsActivationService","WCF-HTTP-Activation45","Microsoft-Hyper-V-Management-Clients")
}

#Download OneNodeRole.xml
DownloadWithRetry -Uri "$gitbranch/scripts/OneNodeRole.xml" -DownloadLocation "$defaultLocalPath\OneNodeRole.xml"
[xml]$rolesXML = Get-Content -Path "$defaultLocalPath\OneNodeRole.xml" -Raw
$WindowsFeature = $rolesXML.role.PublicInfo.WindowsFeature
$dismFeatures = (Get-WindowsOptionalFeature -Online).FeatureName
if ($null -ne $WindowsFeature.Feature.Name)
{
    $featuresToInstall = $dismFeatures | Where-Object { $_ -in $WindowsFeature.Feature.Name }
    if ($null -ne $featuresToInstall -and $featuresToInstall.Count -gt 0)
    {
        Write-Log @writeLogParams -Message "Following roles will be installed"
        Write-Log @writeLogParams -Message "$featuresToInstall"
        Enable-WindowsOptionalFeature -FeatureName $featuresToInstall -Online -All -NoRestart
    }
}

if ($null -ne $WindowsFeature.RemoveFeature.Name)
{
    $featuresToRemove = $dismFeatures | Where-Object { $_ -in $WindowsFeature.RemoveFeature.Name }
    if ($null -ne $featuresToRemove -and $featuresToRemove.Count -gt 0)
    {
        Write-Log @writeLogParams -Message "Following roles will be uninstalled"
        Write-Log @writeLogParams -Message "$featuresToRemove"
        Disable-WindowsOptionalFeature -FeatureName $featuresToRemove -Online -Remove -NoRestart
    }
}


# Hide Server Manager
$HKLM = "HKLM:\SOFTWARE\Microsoft\ServerManager"
New-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -PropertyType DWORD
Set-ItemProperty -Path $HKLM -Name "DoNotOpenServerManagerAtLogon" -Value 1 -Type DWord

# Hide Server Manager
$HKCU = "HKEY_CURRENT_USER\Software\Microsoft\ServerManager"
New-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -PropertyType DWORD
Set-ItemProperty -Path $HKCU -Name "CheckedUnattendLaunchSetting" -Value 0 -Type DWord

# Install Chrome
$Path = $env:TEMP; 
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer


# Create a PowerShell ISE Shortcut on the Desktop
$WshShell = New-Object -ComObject WScript.Shell
$allUsersDesktopPath = "$env:SystemDrive\Users\Public\Desktop"
New-Item -ItemType Directory -Force -Path $allUsersDesktopPath
$Shortcut = $WshShell.CreateShortcut("$allUsersDesktopPath\PowerShell ISE.lnk")
$Shortcut.TargetPath = "$env:windir\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe"
$Shortcut.Save()  


Rename-LocalUser -Name $username -NewName Administrator
Restart-Computer -Force