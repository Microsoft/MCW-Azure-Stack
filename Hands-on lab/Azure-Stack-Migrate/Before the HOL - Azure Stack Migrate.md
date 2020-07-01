![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png)
 
<div class="MCWHeader1">
Azure Stack Migrate
</div>

<div class="MCWHeader2">
Before the hands-on lab setup guide
</div>

<div class="MCWHeader3">
July 2020
</div>


Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2020 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**


# Azure Stack Operate before the hands-on lab setup guide 

## Requirements

-   Administrative access to an Azure Stack Hub Development Kit deployment in an Azure VM.
-   An Azure subscription.
-   An Azure Active Directory account with the Owner role in the Azure Subscription and the Global Administrator role in the corresponding Azure Active Directory tenant.

## Before the hands-on lab

Duration: 7 hours

### Task 1: Provision an Azure VM to Host the Azure Stack Hub Development Kit

In this task, you will provision an Azure VM that will host the Azure Stack Development Kit deployment.

Execute the following PowerShell code. When prompted for Azure credentials, you will need to authenticate with an Azure Account that has Global Administrator access on the Azure AD Tenant as well as Owner rights on the Azure subscription. 

There will be a second prompt for the local administrator account. Specify demo@pass123 when prompted. 

> Note: Ensure the Azure Subscription has enough cores available on the quota to deploy a VM sized: Standard E20s v3.

```PowerShell 
Connect-AzAccount

$region = 'East US 2'
$rg = '<Resource Group Name>'
$saName = "asdk" + (Get-Random)
New-AzResourceGroup -Name $rg -Location $region
$sa = New-AzStorageAccount -Location $region -ResourceGroupName $rg -SkuName Standard_LRS -Name $saName

$sourceUri = "https://azshdkeus2.blob.core.windows.net/vhd/cloudbuilder.vhd"
New-AzStorageContainer -Name vhd -Context $sa.context
Start-AzStorageBlobCopy -AbsoluteUri $sourceUri -DestContainer "vhd" -DestContext $sa.context -DestBlob "cloudbuilder.vhd" -ConcurrentTaskCount 100
do {
    Start-Sleep -Seconds 60
    $result = Get-AzStorageAccount -Name $sa.StorageAccountName -ResourceGroupName $rg | Get-AzStorageBlob -Container "vhd" | Get-AzStorageBlobCopyState
    $remaining = [Math]::Round(($result.TotalBytes - $result.BytesCopied) / 1gb,2)
    Write-Verbose -Message "Waiting copy to finish remaining $remaining GB" -Verbose 
} until ($result.Status -eq "success") 

$templateParameterObject = @{
    dataDiskCount = 6
    osDiskVhdUri = $sa.PrimaryEndpoints.Blob + "vhd/cloudbuilder.vhd"
}
New-AzResourceGroupDeployment -ResourceGroupName $rg -Name AzureStackonAzureVM -TemplateUri "https://raw.githubusercontent.com/opsgility/cw-azure-stack/master/azure-deploy.json" -TemplateParameterObject $templateParameterObject

```


### Task 2: Install Azure Stack Hub Development Kit (Operations)

In this task you will execute a script that will download and provision Azure Stack Hub Development Kit on the newly deployed Azure VM.

1. Within the Remote Desktop session to **AzSHOST-1**, right-click Start and then select Command Prompt (Admin).

2. Within the Remote Desktop session to **AzSHOST-1**, start Windows PowerShell as administrator.

3. From the Administrator: Windows PowerShell window, set values of the variables that will be used by the installation script by running the following (ensure you replace the placeholder values, where `[azure-admin-upn]` and `[azure-admin-password]` designate the user name and password of the account with the Owner role in the Azure subscription you are using in this lab and the Global Administrator role in the Azure AD tenant associated with that subscription):

    ```powershell
    Set-Location -Path 'C:\AzureStackOnAzureVM'

    $localAdminPass = ConvertTo-SecureString 'demo@pass123' -AsPlainText -Force
    $azpass = ConvertTo-SecureString '[azure-admin-password]' -AsPlainText -Force
    $azcred = New-Object System.Management.Automation.PSCredential ('[azure-admin-upn]', $azpass)
    ```

4. From the Administrator: Windows PowerShell window, invoke the installation of Azure Stack Hub Development Kit by running the following (ensure you replace the placeholder values, where `[tenant]` is the name of the Azure AD tenant associated with the Azure subscription you are using in this lab):

    ```powershell
    .\Install-ASDK.ps1 -DownloadASDK -DeploymentType AAD -LocalAdminPass $localAdminPass -AADTenant [tenant].onmicrosoft.com -version '1907-20' -InfraAzureDirectoryTenantAdminCredential $azcred
    ```

    > **Note:** After about 75 minutes, the Azure VM will automatically restart.

5. Once the Azure VM restarts and the Remote Desktop session is terminated, sign-in back to **AzSHOST-1** via Remote Desktop using the following credentials:

    - Username: **AzureStack\\AzureStackAdmin**

    - Password: **demo@pass123**

    > **Note:** The installation might take between 6-8 hours. Monitor the PowerShell session where the script is running to determine when it completes.


### Task 3: Prepare the Azure Stack Hub Operator Station

1.  In the Azure portal, navigate to the blade of **AzS-HOST1** virtual machine.

2.  From the **AzS-HOST1** blade, connect via RDP to **AzS-HOST1** Windows host. When prompted, authenticate by using the following credentials:

    -   Username: **AzureStack\AzureStackAdmin**

    -   Password: **demo@pass123**

3.  Select **Start** and, in the Start menu, select **Control Panel**.

4.  In the Control Panel window, select **View by**, in the drop-down menu, select **Small icons**, and select **User Accounts**.

5.  Select **Change User Account Control settings**. 

6.  When prompted, in the **User Account Control** dialog box, select **Yes**. 

7.  In the **User Account Control Settings**, move the slider down to the **Never notify** position, select **OK**, and, when prompted again, in the **User Account Control** dialog box, select **Yes**. 

8.  Start Internet Explorer and install another web browser (Chrome or Firefox). 

9.  From Internet Explorer, browse to https://code.visualstudio.com/, and from the Visual Studio Code page, install the latest stable version of Visual Studio Code. 

    > **Note:** Except VSCode, most of the next steps should be already configured on your VM - please check that the tools are there and you are able to configure them. VSCode is optional - you can perform all of the activities in the labs using just PowerShell, but you may want to explore the VSCode user interface, because it enhances interacting with Azure Stack Hub using PowerShell and ARM templates.

10. Right-click **Start** and, in the right-hand menu, select **Command Prompt (Admin)**.

11. From the **Administrator: Command Prompt**, install appropriate VSCode extensions by running the following:

    ```
    code --install-extension msazurermtools.azurerm-vscode-tools
    code --install-extension ms-vscode.powershell
    code --install-extension ms-azuretools.vscode-azurestorage
    ```


### Task 4: Download and run the Azure Stack Hub Configurator Script

In this task you will execute a script that will configure install and configure Azure Stack Hub with PowerShell modules and tools as well as SQL, App Service, and MySQL Resource Providers.

1. From within the **AzSHost-1** virtual machine launch a Windows PowerShell console as Administrator.

2. From the Administrator: Windows PowerShell window, create a folder named **C:\\AzSPoc** and set it as the current directory by running the following:

    ```powershell
    New-Item -ItemType Directory -Force -Path 'C:\AzSPoC'
    Set-Location 'C:\AzSPoC'
    ```

3. From the Administrator: Windows PowerShell window, download the Azure Stack Hub Configuration script by running:

    ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-Webrequest https://raw.githubusercontent.com/mattmcspirit/azurestack/AzureStack-VM-PoC/deployment/AzSPoC.ps1 -UseBasicParsing -OutFile AzSPoC.ps1
    ```

4. From the Administrator: Windows PowerShell window, download the Windows 2019 Evaluation ISO for the Azure Stack Hub VMs by running the following:

    ```powershell
    $ProgressPreference = "SilentlyContinue"
    wget https://software-download.microsoft.com/download/pr/17763.253.190108-0006.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso -UseBasicParsing -OutFile D:\WS2019EVALISO.iso
    ```

5. From the Administrator: Windows PowerShell window, download the Windows 2016 Evaluation ISO for the Azure Stack Hub VMs by running the following:

    ```powershell
    wget http://download.microsoft.com/download/1/4/9/149D5452-9B29-4274-B6B3-5361DBDA30BC/14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.ISO -UseBasicParsing -OutFile D:\WS2016EVALISO.iso
    ```

6. From the Administrator: Windows PowerShell window, create a folder named **D:\\ASDKfiles** by running the following:

    ```powershell
    New-Item -ItemType Directory -Force -Path 'D:\ASDKfiles'
    ```

7. From the Administrator: Windows PowerShell window, execute the script to configure the Azure SDK (ensure you replace the placeholder values, where `[azure-admin-upn]` and `[azure-admin-password]` designate the user name and password of the account with the Owner role in the Azure subscription you are using in this lab and the Global Administrator role in the Azure AD tenant associated with that subscription, `[tenant]` is the name of the Azure AD tenant associated with the Azure subscription you are using in this lab, and `[subscription-id]` is the identifier of that subscription):

    ```powershell
    .\AzSPoC.ps1 -azureDirectoryTenantName '[tenant].onmicrosoft.com' -authenticationType AzureAD `
        -downloadPath "D:\ASDKfiles" -ISOPath "D:\WS2016EVALISO.iso" -ISOPath2019 "D:\WS2019EVALISO.iso" -asdkHostPwd 'demo@pass123' `
        -VMpwd 'demo@pass123' -azureAdUsername '[azure-admin-upn]' -azureAdPwd '[azure-admin-password]' `
        -registerAzS -useAzureCredsForRegistration -azureRegSubId '[subscription-id]' -branch "master"
    ```

    > **Note**: This step will take an additional 4 to 5 hours.

    > **Note**: If any of the jobs fail, wait for the entire script to complete and run the script again. 

You should complete these instructions *before* attending the workshop. 

