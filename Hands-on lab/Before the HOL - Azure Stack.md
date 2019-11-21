![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png)

<div class="MCWHeader1">
Azure Stack
</div>

<div class="MCWHeader2">
Before the hands-on lab setup guide
</div>

<div class="MCWHeader3">
October 2019
</div>


Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2019 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**

<!-- TOC -->

- [Choose your lab](#choose-your-lab)
- [Azure Stack before the hands-on lab setup guide](#azure-stack-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Create a virtual machine to execute the lab](#task-1-create-a-virtual-machine-to-execute-the-lab)
    - [Task 2: Download and Run the Azure Stack Configurator Script](#task-2-download-and-run-the-azure-stack-configurator-script)
- [Azure Stack Operations before the hands-on lab setup guide](#azure-stack-operations-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements-1)
  - [Before the hands-on lab](#before-the-hands-on-lab-1)
    - [Task 1: Provision Azure Stack Development Kit](#task-1-provision-azure-stack-development-kit)
    - [Task 2: Prepare the Azure Stack operator station](#task-2-prepare-the-azure-stack-operator-station)
  - [Task 3: Register the Azure Stack Development Kit with Azure](#task-3-register-the-azure-stack-development-kit-with-azure)

<!-- /TOC -->

# Choose your lab

This content consists of two hands-on lab paths, **Azure Stack** and **Azure Stack Operations**. You should only complete the setup for the lab you wish to complete. You may use the table of contents to navigate to the appropriate instructions. The descriptions below are provided to help you decide which lab you would like to complete. 

The first hands-on lab involves starts with deploying the Azure Stack Development Kit, deploying the SQL Database and Azure App Service resource providers, as well as downloading several virtual machine images from the Azure Stack Marketplace. From there, you will implement a full taxonomy in Azure Stack consisting of a region, subscription, plan, offer, and quotas. After Azure Stack is configured, you will then deploy Azure SQL Database, Web and API apps and then deploy the Contoso application.

The second hands-on lab focuses on the Azure Stack operational tasks. In this case, you will also start with deploying the Azure Stack Development Kit, but the subsequent steps will differ. First, you will install the Azure Stack tools. You will subsequently rely on them to create and publish a custom Azure Marketplace item as well as to implement multi-tenant topology by provisioning another Azure Active Directory tenant and adding it to the existing Azure Stack environment. Once that is completed, you will set up delegation by using the delegated provider model and Azure Stack Role-Based Access Control (RBAC). You will conclude this lab by carrying out common Azure Stack maintenance tasks, including log collection (via Privileged Endpoint) and infrastructure backup (by using the Azure Stack Admin portal).

# Azure Stack before the hands-on lab setup guide 

## Requirements

-   A Microsoft Azure subscription.

## Before the hands-on lab

Duration: 8-10 hours

To execute this lab, you will have two options: you can use your own Azure Stack Development Kit that is already installed, or you will need to follow the instructions below to setup your own in Microsoft Azure using nested virtual machines.

For help with installation of the Azure Stack Development Kit, review the following article: <https://azure.microsoft.com/en-us/overview/azure-stack/development-kit>.

### Task 1: Create a virtual machine to execute the lab

1. Navigate to the following URL to launch the AzureStackOnAzureVM deployment template in the Azure Portal.

    ```
    http://aka.ms/AzureStackonAzureVM
    ```

2. Specify the following options on the template settings:

    - Admin Password: **demo@pass123**
    - Public DNS Name: **Specify a unique value**.
    - Auto Install ASDK: **true**
    - Azure AD Tenant: **Your Azure AD tenant**.
    - Azure AD Global Admin: **Your Azure AD Global admin account**.
    - Azure AD Global Admin Password: **Your Azure AD Global admin password**.

    Select **Purchase** when you are ready to deploy the VM.

    > **Note:** This step may take up to 6 hours to deploy. 

3.  After several hours, you may login to the **AzSHost-1** virtual machine using RDP to monitor the installation progress. You will need to use the account:

    -   Username: **azurestack.local\\azurestackadmin**

    -   Password: **demo@pass123**


### Task 2: Download and Run the Azure Stack Configurator Script

In this task you will execute a script that will configure Azure Stack with many of the standard Resource Providers such as SQL, App Service, and MySQL.

1. From within the **AzSHost-1** virtual machine launch an elevated PowerShell console.

2. The script requires the Windows 2016 Evaluation ISO for the Azure Stack Images. Download the ISO with the following command:

    ```PowerShell
    Start-BitsTransfer -Source https://cloudworkshop.blob.core.windows.net/azure-stack/iso/win2016eval.iso -Destination D:\win2016eval.iso
    ```

3. Download the ConfigASDK Script:

    ```PowerShell
    # Create directory on the root drive.
    New-Item -ItemType Directory -Force -Path "C:\ConfigASDK"
    Set-Location "C:\ConfigASDK"

    # Download the ConfigASDK Script.
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-Webrequest http://bit.ly/AzSPoC -UseBasicParsing -OutFile ConfigASDK.ps1
    ```

4. Execute the script to configure the Azure SDK (ensure you replace the [placeholder values]). 
 
    > **Note**: This step will take an additional 3 to 4 hours.

    
    ```PowerShell
    New-Item -ItemType Directory -Force -Path "D:\ASDKINSTALL"
    
    .\ConfigASDK.ps1 -azureDirectoryTenantName "[tenant].onmicrosoft.com" -authenticationType AzureAD `
    -downloadPath "D:\ASDKINSTALL" -ISOPath "D:\win2016eval.iso" -azureStackAdminPwd 'demo@pass123' `
    -VMpwd 'demo@pass123' -azureAdUsername "[youruser]@[tenant].onmicrosoft.com" -azureAdPwd '[your user password]' `
    -registerASDK -useAzureCredsForRegistration -azureRegSubId "[Your Azure Subscription ID]"
    ```


    > **Note**: If any of the jobs fail, wait for the entire script to complete and run the script again. 


5. Many of the instructions ask you to copy/paste values from the Azure Stack portal. The copy buttons do not work in IE. It is recommended to install Firefox or Chrome inside the VM. 

    ```
    https://www.mozilla.org/en-US/firefox/new/
    ```

    ```
    https://www.google.com/chrome
    ```

You should complete these instructions *before* attending the workshop. 

# Azure Stack Operations before the hands-on lab setup guide 

## Requirements

-   Administrative access to an Azure Stack Development Kit deployment in an Azure VM.
-   An Azure subscription.
-   An Azure Active Directory account with the Owner role in the Azure Subscription and the Global Administrator role in the corresponding Azure Active Directory tenant.

## Before the hands-on lab

Duration: 7 hours

### Task 1: Provision Azure Stack Development Kit

1.  Navigate to the following URL to launch the AzureStackOnAzureVM deployment template in the Azure Portal.

    ```
    http://aka.ms/AzureStackonAzureVM
    ```
2.  When prompted, authenticate with an Azure Active Directory account with the owner role in the subscription where you intend to provision the Azure Stack Development Kit Azure VM named **AzSHOST-1** and with the Global Administrator role in the Azure Active Directory tenant associated with that subscription.

3.  On the Custom deployment blade, specify the following settings (accept the default values of all others) and select **Purchase**:

    - Resource group: **Any existing or a new resource group**.

    - Admin Password: **demo@pass123**

    - Public DNS Name: **Any unique, valid DNS name**.

    - Auto Download ASDK: **true**

    - Auto Install ASDK: **true**

    - Azure AD Tenant: **Your Azure AD tenant**.

    - Azure AD Global Admin: **Your Azure AD Global admin account**.

    - Azure AD Global Admin Password: **Your Azure AD Global admin password**.

    > **Note:** This step might take about 6 hours to complete.

### Task 2: Prepare the Azure Stack operator station

1.  In the Azure portal, navigate to the blade of **AzS-HOST1** virtual machine.

2.  From the **AzS-HOST1** blade, connect via RDP to **AzS-HOST1** Windows host. When prompted, authenticate by using the following credentials:

    -   Username: **AzureStack\AzureStackAdmin**

    -   Password: **demo@pass123**

3.  select **Start** and, in the Start menu, select **Control Panel**.

4.  In the Control Panel window, select **View by**, in the drop-down menu, select **Small icons**, and select **User Accounts**.

5.  Select **Change User Account Control settings**. 

6.  When prompted, in the **User Account Control** dialog box, select **Yes**. 

7.  In the **User Account Control Settings**, move the slider down to the **Never notify** position, select **OK**, and, when prompted again, in the **User Account Control** dialog box, select **Yes**. 

8.  Start Internet Explorer and install another web browser (Chrome or Firefox). 

9.  From Internet Explorer, browse to https://code.visualstudio.com/, and from the Visual Studio Code page, install the latest stable version of Visual Studio Code. 

    > **Note:** Except VScode, most of the next steps should be already configured on your VM - please check that the tools are there and you are able to configure them. VSCode is optional - you can perform all of the activities in the labs using just PowerShell, but you may want to explore the VSCode user interface, because it enhances interacting with Azure Stack using PowerShell and ARM templates.

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

15. From the Administrator: Windows PowerShell ISE window, install and import the API Version Profile required by Azure Stack into the current PowerShell session by running the following:

    ```powershell
    Use-AzureRmProfile -Profile 2019-03-01-hybrid -Force
    ```
  
16. From the Administrator: Windows PowerShell ISE window, install and import the API Version Profile required by Azure Stack into the current PowerShell session by running the following:

    ```powershell
    Use-AzureRmProfile -Profile 2019-03-01-hybrid -Force
    Install-Module -Name AzureStack -RequiredVersion 1.7.2
    ```

17. From the Administrator: Windows PowerShell ISE window, download the Azure Stack Tools by running the following:

    ```powershell
    Set-Location -Path '\'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
    Invoke-WebRequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip
    Expand-Archive master.zip -DestinationPath . -Force
    Set-Location -Path '\AzureStack-Tools-master'
    ```

18. From the Administrator: Windows PowerShell ISE window, register the Azure Stack PowerShell environment that targets your Azure Stack instance by running the following:

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

    > **Note:** Type "Get-AzureRMSubscription" and note list of subscriptions (Default Provider Subscription, Metering Subscription, and Consumption Subscription) and the corresponding tenant ID. You are now connected to your Azure Stack instance and can run commands such as **Get-AzsLocation**, **Get-AzsSubscription**, or **Get-AzsUserSubscription**.

    > Ignore the warning stating, **Preview version of the module Azs.Subscriptions loaded. Future release of this module may have breaking changes**.

## Task 3: Register the Azure Stack Development Kit with Azure

1.  From the Administrator: Windows PowerShell ISE window, specify the Azure Active Directory account you will use to register Azure Stack with the Azure Stack resource provider in Azure by running the following:

    ```powershell
    Add-AzureRmAccount -EnvironmentName AzureCloud
    ```

2.  When prompted, your Azure Active Directory account that you provided when provisioning the Azure Stack environment.

3.  If you have multiple subscriptions, run the following command to select the one you want to use (make sure to replace the placeholder `<subscription_ID>` with the id of the target subscription):

    ```powershell
    Set-AzureRmContext - SubscriptionId '<subscription_ID'"
    ```

4.  From the Administrator: Windows PowerShell ISE window, register the Azure Stack resource provider by running the following:

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

7.  From the `[AzS-ERC01]: PS>` prompt within the Administrator: Windows PowerShell ISE window, display the local Azure Stack stamp information by running the following:

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

