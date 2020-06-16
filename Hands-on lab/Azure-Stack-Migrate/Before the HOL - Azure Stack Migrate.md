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

<!-- TOC -->

- [Azure Stack Migrate before the hands-on lab setup guide](#azure-stack-migrate-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Provision an Azure VM to host the Azure Stack Hub Development Kit](#task-1-provision-an-azure-vm-to-host-the-azure-stack-hub-development-kit)
    - [Task 2: Install Azure Stack Hub Development Kit](#task-2-install-azure-stack-hub-development-kit)
    - [Task 3: Download and run the Azure Stack Hub Configurator Script](#task-3-download-and-run-the-azure-stack-hub-configurator-script)
    - [Task 4: Perform post installation tasks](#task-4-perform-post-installation-tasks)

<!-- /TOC -->

# Azure Stack Migrate before the hands-on lab setup guide 

## Requirements

-   A Microsoft Azure subscription.

## Before the hands-on lab

Duration: 10-12 hours

To execute this lab, you will have two options: you can use your own Azure Stack Hub Development Kit that is already installed, or you will need to follow the instructions below to setup your own in Microsoft Azure using nested virtual machines.

For help with installation of the Azure Stack Hub Development Kit, review the following article: <https://azure.microsoft.com/en-us/overview/azure-stack/development-kit>.

### Task 1: Provision an Azure VM to host the Azure Stack Hub Development Kit

In this task, you will provision an Azure VM that will host the Azure Stack Development Kit deployment

1. Navigate to the following URL to launch the AzureStackOnAzureVM deployment template in the Azure Portal.

    ```
    http://aka.ms/AzureStackonAzureVM
    ```

2. When prompted, authenticate by using your Azure AD account or Microsoft Account with the Owner role in the Azure subscription that you intend to use in this lab.

3. Specify the following options on the template settings:

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

4.  Wait until the deployment completes and login to the **AzS-HOST1** virtual machine via Remote Desktop using the following credentials:

    - Username: **Administrator**

    - Password: **demo@pass123**


### Task 2: Install Azure Stack Hub Development Kit

In this task you will execute a script that will download and provision Azure Stack Hub Development Kit on the newly deployed Azure VM

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


### Task 3: Download and run the Azure Stack Hub Configurator Script

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
        -registerAzS -useAzureCredsForRegistration -azureRegSubId '[subscription-id]' -branch "AzureStack-VM-PoC"
    ```

    > **Note**: This step will take an additional 3 to 4 hours.

    > **Note**: If any of the jobs fail, wait for the entire script to complete and run the script again. 


### Task 4: Perform post installation tasks

1. Within the Remote Desktop session to **AzSHOST-1**, start Internet Explorer and browse to <https://portal.azure.com>.

2. When prompted, authenticate by using your Azure AD account or Microsoft Account with the Owner role in the Azure subscription that you are using in this lab.

3. In the Azure portal, start a PowerShell session within the Cloud Shell.

    > **Note:** If prompted, consent to configuring storage for Cloud Shell. 

4. From the Cloud Shell pane, run the following to identify the Azure AD DNS domain name:

    ```powershell
    $domainName = ((Get-AzureAdTenantDetail).VerifiedDomains)[0].Name
    ```

5. From the Cloud Shell pane, run the following to create a new user account in the Azure AD tenant associated with your Azure subscription:

    ```powershell
    $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
    $passwordProfile.Password = 'demo@pass123'
    $passwordProfile.ForceChangePasswordNextLogin = $false

    New-AzureADUser -AccountEnabled $true -DisplayName 'AzSHOperator' -PasswordProfile $passwordProfile -MailNickName 'AzSHOperator' -UserPrincipalName "AzSHOperator@$domainName"
    ```

6. Switch to the Azure Stack Hub Administrator portal at <https://adminportal.local.azurestack.external>.

7. When prompted, sign in with Azure AD user account you provided when installing Azure Stack Hub Development Kit.

8. In the Azure Stack Hub Administrator portal, navigate to the **All services** blade and then, in the **GENERAL** section, select **Subscriptions**.

9. On the **Subscriptions** blade, select **Default Provider Subscription**.

    ![Three subscriptions, including Default Provider Subscription, listed on the Subscriptions blade. ](images/Hands-onlabstep-by-step-AzureStackimages/media/image1.png "Subscriptions")

10. On the **Default Provider Subscription**, select **Access control (IAM)**.

11. Select **+ Add**, on the **Add permission** blade, assign the **Owner** role to the Azure AD user account you created earlier in this task and **Save**.

12. Return to the **Subscription** blade and repeat the previous two steps for the **Consumption Subscription** and **Metering Subscription**.

    > **Note:** Use the **AzSHOperator** user account when running the lab.

13. In the Azure Stack administrator portal, in the hub menu, select **All services**.

14. On the **All Services** blade, select **App Service**.

15. On the **App Service** blade, select **Roles**.

    ![App Service - Roles blade is displayed.](images/Hands-onlabstep-by-step-AzureStackimages/media/image8.png "App Service - Roles")

16. In the list of roles, in the **Web Worker** **Small** tier entry, right-click the ellipsis icon and, in the right-click menu, select **ScaleSet**.

17. On the **SmallWorkerTierScaleSet** blade, select **Scaling**.

18. On the **SmallWorkerTierScaleSet - Scaling** blade, set **Instance count** to 1 and select **Save**.

    ![SmallWorkerTierScaleSet - Scaling blade is displayed with Instance count set to 1.](images/Hands-onlabstep-by-step-AzureStackimages/media/image10.png "App Service - Roles")

    > **Note:** App Service on Azure Stack Hub will now add the additional VM, configure it, install all the required software, and mark it as ready when this process is complete. This process should take approximately 30 minutes. To verify it, review the **SmallWorkerTierScaleSet - Instances** blade.

    ![SmallWorkerTierScaleSet - Instances blade is displayed with the SmallWorkerTierScaleSet instance running.](images/Hands-onlabstep-by-step-AzureStackimages/media/image11.png "App Service - Roles")

    > **Note:** Many of the instructions ask you to copy/paste values from the Azure Stack Hub portal. The copy buttons do not work in IE. It is recommended to install Firefox or Chrome inside the Azure Stack Hub host. 

    ```
    https://www.mozilla.org/en-US/firefox/new/
    ```

    ```
    https://www.google.com/chrome
    ```

You should complete these instructions *before* attending the workshop. 

