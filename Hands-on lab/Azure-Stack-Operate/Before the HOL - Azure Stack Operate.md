![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png)
 
<div class="MCWHeader1">
Azure Stack Operate
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

<!-- TOC -->

- [Azure Stack Operate before the hands-on lab setup guide](#azure-stack-operate-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Provision an Azure VM to Host the Azure Stack Hub Development Kit](#task-1-provision-an-azure-vm-to-host-the-azure-stack-hub-development-kit)
    - [Task 2: Install Azure Stack Hub Development Kit (Operations)](#task-2-install-azure-stack-hub-development-kit-operations)
    - [Task 3: Prepare the Azure Stack Hub Operator Station](#task-3-prepare-the-azure-stack-hub-operator-station)
  - [Task 4: Register the Azure Stack Hub Development Kit with Azure](#task-4-register-the-azure-stack-hub-development-kit-with-azure)

<!-- /TOC -->

# Azure Stack Operate before the hands-on lab setup guide 

## Requirements

-   Administrative access to an Azure Stack Hub Development Kit deployment in an Azure VM.
-   An Azure subscription.
-   An Azure Active Directory account with the Owner role in the Azure Subscription and the Global Administrator role in the corresponding Azure Active Directory tenant.

## Before the hands-on lab

Duration: 7 hours

### Task 1: Provision an Azure VM to Host the Azure Stack Hub Development Kit

In this task, you will provision an Azure VM that will host the Azure Stack Development Kit deployment.

1. Navigate to the following URL to launch the AzureStackOnAzureVM deployment template in the Azure Portal:

    ```
    http://aka.ms/AzureStackonAzureVM
    ```

2. Specify the following options on the template settings:

    - Subscription: The name of the target Azure subscription where you want to deploy the Azure VM serving as the ASDK host.

    - Resource group: A new resource group named **azurestack-RG**.

    - Location: The name of the Azure region where you want to deploy the Azure VM serving as the ASDK host.

    - Virtual Machine Name: **AzS-HOST1**

    - Virtual Machine Size: **Standard_E20s-v3**

    - Data Disk Size in GB: **256**

    - Data Disk Count: **4**

    - Virtual Network Name: **AzureStack-VNET**

    - Admin Password: **demo@pass123**

    - Address Prefix: **10.0.0.0/24**

    - Subnet Name: **default**

    - Subnet Prefix: **10.0.0.0/24**

    - Public Ip Address Type: **Dynamic**

    - Public Dns Name: Any valid, globally unique name.

    - Auto Shutdown Status: **Disabled**

    - Auto Shutdown Time: The default value.

    - Auto Shutdown Notification Status: **Disabled**

    - Auto Download ASDK: **false**

    - Auto Install ASDK: **false**

    - Azure AD Tenant: The DNS name of your Azure AD tenant.

    - Azure AD Global Admin: The name of an Azure AD user with the Global Admin role.

    - Azure AD Global Admin Password: The password of the Azure AD user with the Global Admin role.

    - ASDK Configurator Object: The default value.

    - Enable RDSH: **false**

    - Branch: **master**

    - Site Location: **[resourceGroup().location]**

    Enable the checkbox **I agree to the terms and conditions stated above** and select **Purchase** when you are ready to deploy the VM.

    > **Note:** This deployment may take about 15 minutes to complete.

3.  Wait until the deployment completes and login to the **AzS-HOST1** virtual machine via Remote Desktop using the following credentials:

    - Username: **Administrator**

    - Password: **demo@pass123**


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

12. Start Windows PowerShell ISE as administrator.

13. From the Administrator: Windows PowerShell ISE window, ensure that PSGallery is configured as trusted repository by running the following:

    ```powershell
    Import-Module -Name PowerShellGet -ErrorAction Stop
    Import-Module -Name PackageManagement -ErrorAction Stop
    Register-PSRepository -Default
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    ```

14. From the Administrator: Windows PowerShell ISE window, install the AzureRM.BootStrapper module by running the following:

    ```powershell
    Install-Module -Name AzureRM.BootStrapper
    ```

15. From the Administrator: Windows PowerShell ISE window, install and import the API Version Profile required by Azure Stack Hub into the current PowerShell session by running the following:

    ```powershell
    Use-AzureRmProfile -Profile 2019-03-01-hybrid -Force
    ```
  
16. From the Administrator: Windows PowerShell ISE window, install and import the API Version Profile required by Azure Stack Hub into the current PowerShell session by running the following:

    ```powershell
    Use-AzureRmProfile -Profile 2019-03-01-hybrid -Force
    Install-Module -Name AzureStack -RequiredVersion 1.7.2
    ```

17. From the Administrator: Windows PowerShell ISE window, download the Azure Stack Hub Tools by running the following:

    ```powershell
    Set-Location -Path '\'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
    Invoke-WebRequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip
    Expand-Archive master.zip -DestinationPath . -Force
    Set-Location -Path '\AzureStack-Tools-master'
    ```

18. From the Administrator: Windows PowerShell ISE window, register the Azure Stack Hub PowerShell environment that targets your Azure Stack Hub instance by running the following:

    ```powershell
    Add-AzureRMEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" `
      -AzureKeyVaultDnsSuffix adminvault.local.azurestack.external `
      -AzureKeyVaultServiceEndpointResourceId https://adminvault.local.azurestack.external
    ```

19. From the Administrator: Windows PowerShell ISE window, set your Azure Active Directory tenant by running the following (make sure to replace the placeholder `<tenant_name>` with the name of your Azure Active Directory tenant):

    ```powershell
    $AuthEndpoint = (Get-AzureRmEnvironment -Name "AzureStackAdmin").ActiveDirectoryAuthority.TrimEnd('/')
    $AADTenantName = "<tenant_name>.onmicrosoft.com"
    $TenantId = (invoke-restmethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]
    ```

20. From the Administrator: Windows PowerShell ISE window, create the **AzureStackAdmin** environment by running the following:

    ```powershell
    Add-AzureRmAccount -EnvironmentName "AzureStackAdmin" -TenantId $TenantId
    ```  

21. When prompted, sign in with your Azure Active Directory account.

    > **Note:** Type "Get-AzureRMSubscription" and note list of subscriptions (Default Provider Subscription, Metering Subscription, and Consumption Subscription) and the corresponding tenant ID. You are now connected to your Azure Stack Hub instance and can run commands such as **Get-AzsLocation**, **Get-AzsSubscription**, or **Get-AzsUserSubscription**.

    > Ignore the warning stating, **Preview version of the module Azs.Subscriptions loaded. Future release of this module may have breaking changes**.


## Task 4: Register the Azure Stack Hub Development Kit with Azure

1.  From the Administrator: Windows PowerShell ISE window, specify the Azure Active Directory account you will use to register Azure Stack Hub with the Azure Stack Hub resource provider in Azure by running the following:

    ```powershell
    Add-AzureRmAccount -EnvironmentName AzureCloud
    ```

2.  When prompted, your Azure Active Directory account that you provided when provisioning the Azure Stack Hub environment.

3.  If you have multiple subscriptions, run the following command to select the one you want to use (make sure to replace the placeholder `<subscription_ID>` with the id of the target subscription):

    ```powershell
    Set-AzureRmContext - SubscriptionId '<subscription_ID'"
    ```

4.  From the Administrator: Windows PowerShell ISE window, register the Azure Stack Hub resource provider by running the following:

    ```powershell
    Register-AzureRmResourceProvider -ProviderNamespace Microsoft.AzureStack
    ```

5.  From the Administrator: Windows PowerShell ISE window, configure the registration by running the following:

    ```powershell
    Set-Location -Path '\AzureStack-Tools-master'
    # Import the registration module that was downloaded with the GitHub tools
    Import-Module -Name '.\Registration\RegisterWithAzure.psm1'

    ```

6.  From the Administrator: Windows PowerShell ISE window, connect to the privileged endpoint of your ASDK installation by running the following:

    ```powershell
    $adminUserName = 'azurestack\CloudAdmin'
    $adminPassword = 'demo@pass123' | ConvertTo-SecureString -Force -AsPlainText
    $adminCredentials = New-Object PSCredential($adminUserName,$adminPassword)

    Enter-PSSession -ComputerName AzS-ERCS01 -ConfigurationName PrivilegedEndpoint -Credential $adminCredentials
    ```

7.  From the `[AzS-ERC01]: PS>` prompt within the Administrator: Windows PowerShell ISE window, display the local Azure Stack Hub stamp information by running the following:

    ```powershell
    Get-AzureStackStampInformation 
    ```

8.  In the output of the command you ran in the previous step, identify the CloudId parameter, copy it to Clipboard, and exit the PowerShell Remoting session by running the following:

    ```powershell
    Exit-PSSession
    ```

9.  From the Administrator: Windows PowerShell ISE window, configure the registration by running the following (make sure to replace the placeholder `<cloud_ID>` with the value of the CloudId parameter you identified in the previous step):

    ```powershell
    $RegistrationName = "<cloud_ID>"
    $AzureContext = Get-AzureRmContext

    Set-AzsRegistration `
	-PrivilegedEndpointCredential $adminCredentials `
	-PrivilegedEndpoint AzS-ERCS01 `
	-BillingModel Development `
	-RegistrationName $RegistrationName `
	-UsageReportingEnabled:$true
    ```

10. Review the output of the command you ran in the previous task and verify that the registration was successful.

You should complete these instructions *before* attending the workshop. 

