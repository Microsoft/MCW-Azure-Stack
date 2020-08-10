![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png)

<div class="MCWHeader1">
Azure Stack Operate
</div>

<div class="MCWHeader2">
Hands-on lab step-by-step
</div>

<div class="MCWHeader3">
July 2020
</div>

Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2020 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**


<!-- TOC -->autoauto- [Azure Stack Operate hands-on lab step-by-step](#azure-stack-operate-hands-on-lab-step-by-step)auto    - [Abstract and learning objectives](#abstract-and-learning-objectives)auto    - [Overview](#overview)auto    - [Help references](#help-references)auto    - [Requirements](#requirements)auto    - [Exercise 1: Create and publish an Azure Stack Hub Marketplace item](#exercise-1-create-and-publish-an-azure-stack-hub-marketplace-item)auto        - [Task 1: Set up tools and artifacts for publishing custom Azure Stack Hub Marketplace items](#task-1-set-up-tools-and-artifacts-for-publishing-custom-azure-stack-hub-marketplace-items)auto        - [Task 2: Publish a custom Azure Marketplace solution](#task-2-publish-a-custom-azure-marketplace-solution)auto    - [Exercise 2: Implement multi-tenancy](#exercise-2-implement-multi-tenancy)auto        - [Task 1: Create and configure a new Azure Active Directory tenant](#task-1-create-and-configure-a-new-azure-active-directory-tenant)auto        - [Task 2: Configure the existing Azure Stack Hub Azure Active Directory tenant](#task-2-configure-the-existing-azure-stack-hub-azure-active-directory-tenant)auto        - [Task 3: Configure the newly created Azure Active Directory tenant](#task-3-configure-the-newly-created-azure-active-directory-tenant)auto    - [Exercise 3: Implement delegated management of plans, offers, and subscriptions](#exercise-3-implement-delegated-management-of-plans-offers-and-subscriptions)auto        - [Task 1: Create delegated operator and user Azure Active Directory accounts (as the Azure Stack Hub operator)](#task-1-create-delegated-operator-and-user-azure-active-directory-accounts-as-the-azure-stack-hub-operator)auto        - [Task 2: Create a plan consisting of the Subscription service (as the Azure Stack Hub operator)](#task-2-create-a-plan-consisting-of-the-subscription-service-as-the-azure-stack-hub-operator)auto        - [Task 3: Create an offer based on the plan consisting of the Subscriptions service (as the Azure Stack Hub operator)](#task-3-create-an-offer-based-on-the-plan-consisting-of-the-subscriptions-service-as-the-azure-stack-hub-operator)auto        - [Task 4: Create new subscriptions containing the offer with the delegated providers as their subscriber (as the Azure Stack Hub operator)](#task-4-create-new-subscriptions-containing-the-offer-with-the-delegated-providers-as-their-subscriber-as-the-azure-stack-hub-operator)auto        - [Task 5: Create a plan to be delegated by delegated providers to users (as the Azure Stack Hub operator)](#task-5-create-a-plan-to-be-delegated-by-delegated-providers-to-users-as-the-azure-stack-hub-operator)auto        - [Task 6: Create an offer based on the plan containing Microsoft.Storage (as the Azure Stack Hub operator)](#task-6-create-an-offer-based-on-the-plan-containing-microsoftstorage-as-the-azure-stack-hub-operator)auto        - [Task 7: Delegate the offer to delegated providers (as the Azure Stack Hub operator)](#task-7-delegate-the-offer-to-delegated-providers-as-the-azure-stack-hub-operator)auto        - [Task 8: Create a delegated provider offer for Contoso users (as the Contoso delegated provider) based on offer from the Azure Stack Hub operator](#task-8-create-a-delegated-provider-offer-for-contoso-users-as-the-contoso-delegated-provider-based-on-offer-from-the-azure-stack-hub-operator)auto        - [Task 9: Create a delegated provider offer for Fabrikam users (as the Fabrikam delegated provider) based on offer from the Azure Stack Hub operator](#task-9-create-a-delegated-provider-offer-for-fabrikam-users-as-the-fabrikam-delegated-provider-based-on-offer-from-the-azure-stack-hub-operator)auto        - [Task 10: Sign up for the delegated provider's offer (as a Contoso user)](#task-10-sign-up-for-the-delegated-providers-offer-as-a-contoso-user)auto        - [Task 11: Sign up for the delegated provider's offer (as a Fabrikam user)](#task-11-sign-up-for-the-delegated-providers-offer-as-a-fabrikam-user)auto    - [Exercise 4: Configure Role Based Access Control (RBAC)](#exercise-4-configure-role-based-access-control-rbac)auto        - [Task 1: Create a custom role](#task-1-create-a-custom-role)auto        - [Task 2: Create Azure AD users and groups](#task-2-create-azure-ad-users-and-groups)auto        - [Task 3: Configure RBAC role assignments](#task-3-configure-rbac-role-assignments)auto    - [Exercise 5: Connect to and work with the Privileged Endpoint](#exercise-5-connect-to-and-work-with-the-privileged-endpoint)auto        - [Task 1: Create a log share](#task-1-create-a-log-share)auto        - [Task 2: Connect to the privileged endpoint via PowerShell Remoting](#task-2-connect-to-the-privileged-endpoint-via-powershell-remoting)auto        - [Task 3: Review capabilities of the privileged endpoint](#task-3-review-capabilities-of-the-privileged-endpoint)auto        - [Task 4: Manage Azure Stack Hub diagnostics log collection via the privileged endpoint.](#task-4-manage-azure-stack-hub-diagnostics-log-collection-via-the-privileged-endpoint)auto    - [Exercise 6: Implement Azure Stack Hub infrastructure backup](#exercise-6-implement-azure-stack-hub-infrastructure-backup)auto        - [Task 1: Create a backup user](#task-1-create-a-backup-user)auto        - [Task 2: Create a backup share](#task-2-create-a-backup-share)auto        - [Task 3: Generate an encryption certificate](#task-3-generate-an-encryption-certificate)auto        - [Task 4: Configure backup controller](#task-4-configure-backup-controller)auto    - [After the hands-on lab](#after-the-hands-on-lab)autoauto<!-- /TOC -->


# Azure Stack Operate hands-on lab step-by-step

## Abstract and learning objectives

In this hands-on lab, you will perform common Azure Stack Hub operational tasks by using the Azure Stack Hub Development Kit. You will start by creating and publishing a custom Azure Marketplace item. Next, you will implement multi-tenant topology by provisioning another Azure Active Directory tenant and adding it to the existing Azure Stack Hub environment. Once that is completed, you will set up delegation by using the delegated provider model and Azure Stack Hub Role-Based Access Control (RBAC). You will conclude this lab by carrying out common Azure Stack Hub operational tasks, including log collection (via Privileged Endpoint) and infrastructure backup (by using the Azure Stack Hub administrator portal).

## Overview

Contoso Finance is one of the largest banks in the United States with a significant amount of their revenue coming from their residential mortgage business. As part of Contoso's shift to a cloud first strategy they are planning to migrate their loan web applications to a hybrid cloud solution. 

As the result of a recent acquisition of a financial analytics company named Fabrikam, based in Houston, Texas, Contoso IT management team plans to integrate a number of Fabrikam's internally developed applications to process and analyze the customer data being used by the Contoso's customer facing mortgage application. Fabrikam has skilled development and infrastructure teams, with extensive Azure experience and its own Azure Active Directory tenant. Contoso is very interested in leveraging that experience and plans to offer the Fabrikam IT team sufficient level of autonomy when working on the integration tasks. That autonomy should include the ability of the Fabrikam IT team to offer to their users cloud resources required for application development, implementation, and maintenance. At the same time, Contoso wants to ensure proper governance and facilitate implementation of corporate standards via centralized control of the service catalog content and through automation. 

During the planning stages, Contoso realized they would not be able to retain their customer data in US based Azure regions due to corporate compliance policies and regulatory issues. They have selected Azure Stack Hub as the deployment method to take advantage of Azure technologies while still maintaining compliance.

To help design a solution using Azure technologies, Contoso has engaged a Microsoft Cloud Partner and Service Provider FusionTomo (FT). FT is a full-service hosting provider in North America certified to deliver Azure services with connectivity solutions and partnerships to provide ExpressRoute and other telecom services. They have datacenters located in Denver, London, Las Vegas, Dallas and Hong Kong SAR.

Contoso has expressed to FT the need to embrace Microsoft Azure technologies as well as technologies that will help their organization with a more agile continuous integration and continuous deployment model for application deployment. Contoso also underscored the need for cooperation with Fabrikam's integration teams, including the intent to delegate some of the infrastructure management tasks. 

With these goals in mind, Contoso has challenged FT to help implement the hosted environment which must also accommodate requirements regarding integration work to be carried out by Fabrikam. In addition, as internal workloads are transitioned to the hosting environment, Contoso internal audit team must retain its ability to track all of the infrastructure changes. For compliance purposes, the delegation model that will provide Contoso and Fabrikam staff with insight into the hosted environment must comply with the principle of least privilege. To satisfy Contoso governance requirements, FT must document standard operating procedures that will be carried out within the hosted infrastructure. 

## Help references
|    |            |
|----------|:-------------:|
| **Description** | **Links** |
| Azure Stack Hub overview  | <https://azure.microsoft.com/en-us/overview/azure-stack/> |
| Azure Stack Hub use cases | <https://azure.microsoft.com/en-us/overview/azure-stack/use-cases/> |
| Azure Stack Hub features | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-key-features> |
| Azure Stack Hub planning considerations | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-planning-considerations> |
| Azure Stack Hub documentation | <https://docs.microsoft.com/en-us/azure/azure-stack/> |
| Azure Stack Hub Operator documentation | <https://docs.microsoft.com/en-us/azure/azure-stack/> |
| Azure Stack Hub networking | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-network-overview/> |
| Deploy apps to Azure and Azure Stack Hub | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-solution-pipeline> |
| Azure Stack: An extension of Azure | <https://azure.microsoft.com/en-us/resources/azure-stack-an-extension-of-azure/> |
| PowerShell for Azure Stack Hub | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-powershell-install> |
| Azure Stack Hub marketplace | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-marketplace-azure-items> |


## Requirements

-   Complete all tasks described in **Before the HOL - Azure Stack Operate**.

## Exercise 1: Create and publish an Azure Stack Hub Marketplace item

Duration: 90 minutes

In this exercise, you will create and publish custom Azure Stack Hub Marketplace items by using the Marketplace Toolkit.

   > **Note**: Azure Marketplace Toolkit is part of the Azure Stack Hub Tools. 

### Task 1: Set up tools and artifacts for publishing custom Azure Stack Hub Marketplace items

1. From the AzS-Host1 Azure VM, start a browser and navigate to http://aka.ms/azurestackmarketplaceitem.

2. When prompted, download the archive file **Azure Stack Marketplace Item Generator and Sample.zip** to the **C:\\Downloads** folder (create the folder if needed).

3. Once the download completes, start File Explorer, select the **View** tab at the top, and select **File name extensions**.

    ![In the View ribbon of File Explorer, File name extensions checkbox is selected.](images-operate/image1.png "View ribbon of File Explorer")

4. In File Explorer, navigate to the **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample** folder, create a new folder named **ContosoWebAppTemplate** and copy the content of the **SampleVMTemplate** folder into it. 

5. In File Explorer, navigate to the **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate\\Icons** folder.

6. Right-click the **Wide.png** image and select **Open with** -> **Paint**.

7. In the Microsoft Paint window, select **Resize**.

    ![In the View ribbon of Microsoft Paint, the Resize icon is selected.](images-operate/image2.png "View ribbon of Microsoft Paint")

8. In the **Resize and Skew** window, clear the **Maintain aspect ratio** checkbox, select the **Pixels** option, set the following image properties and select **OK**:

    - Horizontal: **533**

    - Vertical: **324**

    ![In the Resize and Skew window, the image size is set to the required values.](images-operate/image3.png "Resize")

9.  Save the resulting image as ***C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate\\Icons\\Screenshot.png***.  When prompted whether to continue, select **OK** and close Microsoft Paint. 

    > **Note**: You are using sample images for the sake of simplicity. When creating and publishing custom Azure Stack Hub Marketplace solutions, you would create your own icons and screenshots that represent the characteristics of these solutions. Keep in mind that you must ensure that their sizes match those specified in the documentation available at https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md.

10. Delete the file **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate\\DeploymentTemplates\\azuredeploy-101-simple-windows-vm.json**.

11. Start Windows PowerShell ISE as administrator.

12. From the Administrator: Windows PowerShell ISE window, download into the **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate\\DeploymentTempates** folder a sample template that provisions an Azure Stack Hub web app using the following cmdlet. 

     ```
     Invoke-WebRequest `
  		-Uri https://raw.githubusercontent.com/microsoft/MCW-Azure-Stack/master/Hands-on%20lab/resources.operations/ContosoWebAppTempate.json `
		-OutFile 'C:\Downloads\Azure Stack Marketplace Item Generator and Sample\ContosoWebAppTemplate\DeploymentTemplates\ContosoWebAppTemplate.json'
     ```

13. In File Explorer, navigate to the **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate\\strings** folder.

14. Open the file **resources.resjson** in Notepad, modify its content so it matches the following, save, and close the file:

    ```
    {
      "displayName": "Contoso WebApp",
      "publisherDisplayName": "Contoso",
      "summary": "Deploy a webapp",
      "longSummary": "Deploy a Contoso webapp according to corporate standards",
      "description": "<p>Contoso Azure Stack Marketplace item configured according to corporate standards.</p>",
      "documentationLink": "Documentation"
    }
    ```

15. In File Explorer, navigate to the **C:\\Downloads\\Azure Stack Marketplace Item Generator and Sample\\ContosoWebAppTemplate** folder.

16. Open the file **manifest.json** in Notepad, modify its content so it matches the following, save, and close the file:

    ```
    { "$schema": "https://gallery.azure.com/schemas/2014-09-01/manifest.json#",
        "name": "ContosoWebApp",
        "publisher": "Contoso",
        "version": "1.0.0",
        "displayName": "ms-resource:displayName",
        "publisherDisplayName": "ms-resource:publisherDisplayName",
        "publisherLegalName": "ms-resource:publisherDisplayName",
        "summary": "ms-resource:summary",
        "longSummary": "ms-resource:longSummary",
        "description": "ms-resource:description",
        "longDescription": "ms-resource:description",
        "links": [
            { "displayName": "ms-resource:documentationLink", "uri": "http://go.microsoft.com/fwlink/?LinkId=532898" }
        ], 
        "artifacts": [
            {
                "name": "ContosoWebAppTemplate",
                "type": "Template",
                "path": "DeploymentTemplates\\ContosoWebAppTemplate.json",
                "isDefault": true
            }
        ],
        "icons": {
          "Small": "Icons\\Small.png",
          "Medium": "Icons\\Medium.png",
          "Large": "Icons\\Large.png",
          "Wide": "Icons\\Wide.png"
        },
        "categories":[
    	  "Custom",
    	  "ContosoWebAppTemplate"
        ],
        "uiDefinition": {
          "path": "UIDefinition.json"
        }
    }
    ```

17. Open the file **UIDefinition.json** in Notepad, review its content, and close the file without making any modifications:

    ```
    {
        "$schema": "https://gallery.azure.com/schemas/2015-02-12/UIDefinition.json#",
        "createDefinition": {
            "createBlade": {
                "name": "DeployFromTemplateBlade",
                "extension": "HubsExtension"
            }
        }
    }
    ```

    > **Note**: For more information regarding the format and content of the files used for publishing custom Azure Stack Marketplace items, refer to https://github.com/Azure/portaldocs/blob/master/gallery-sdk/generated/index-gallery.md.

### Task 2: Publish a custom Azure Marketplace solution

1. From the Administrator: Windows PowerShell ISE window, generate a Marketplace item package file (Contoso.ContosoWebAppTemplate.1.0.0.azpkg) by running the following:

     ```
     & 'C:\Downloads\Azure Stack Marketplace Item Generator and Sample\AzureGalleryPackageGenerator\AzureGalleryPackager.exe' package -m "C:\Downloads\Azure Stack Marketplace Item Generator and Sample\ContosoWebAppTemplate\manifest.json" -o "C:\Downloads"
     ```
2. Navigate to the Azure Stack Hub administrator portal at https://adminportal.local.azurestack.external/ using the desktop icon. 

3. When prompted, sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

4. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left.

5. On the New blade, select **Data + Storage** and then select **Storage account - blob, file, table, queue**.

    ![In the Azure Stack Hub administrator portal, Storage account - blob, file, table, queue is displayed.](images-operate/image4.png "Storage account")

6. On the Create storage account blade, specify the following settings then Select **Review + create** then **Create**. Wait until the storage account is provisioned.

    - Subscription: **Consumption Subscription**

    - Resource group: **(Create new) marketplace-pkgs-RG**.

    - Storage account name: **A unique name consisting of between 3 and 24 lower case letters or digits**.

    - Location: **local**

    - Performance: **Standard**

    - Account kind: **Storage (general purpose v1)**

    - Replication: **Locally-redundant storage (LRS)**

7. On the portal's left navigation, select **Resource groups**.

8. On the Resource Groups blade in the list of resource groups, select **marketplace-pkgs-RG**.

9. On the **marketplace-pkgs-RG** blade, select the entry representing the newly created storage account.

10. On the storage account blade, select **Blobs**.

11. On the Blob service blade, select **+ Container**.

12. In the dialog that appears, enter **packages** for the name and **Blob (anonymous read access for blobs only)** for the **Access type**.

13. In the list of containers, select **packages**.

14. On the packages blade, select **Upload**.

15. On the **Upload blob** blade that appears on the right, select the folder icon next to the **Select a file** text box. 

16. In the File Explorer window that opens, navigate to the location containing the package that you noted in the previous task, select the **Contoso.ContosoWebApp.1.0.0.azpkg** file and select **Open**.

    ![In the Azure Stack Hub administrator portal, the Upload blob pane shows the Contoso.ContosoWebApp.1.0.0.azpkg file to be uploaded.](images-operate/image5.png "Upload blob pane")

17. Back on the Upload blob blade, select **Upload**.

    > **Note**: Subsequent steps require Azure Stack PowerShell and tools installed. This was performed as part of **Azure Stack Hub Before the Hands-on Lab setup guide**).

18. From the Administrator: Windows PowerShell ISE window, sign in to the Azure Stack Hub as operator by running the following (make sure to replace the placeholder <tenant_name> with the name of your Azure Active Directory tenant).

    >**Note**: Azure Stack Hub still uses the *AzureRM* cmdlets and does not yet support the newer *AzureAZ* cmdlets.

    ```powershell
    Set-Location -Path '\AzureStack-Tools-master'

    Add-AzureRMEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" `
      -AzureKeyVaultDnsSuffix adminvault.local.azurestack.external `
      -AzureKeyVaultServiceEndpointResourceId https://adminvault.local.azurestack.external

    $AuthEndpoint = (Get-AzureRmEnvironment -Name "AzureStackAdmin").ActiveDirectoryAuthority.TrimEnd('/')
    $AADTenantName = "<tenant_name>.onmicrosoft.com"
    $TenantId = (Invoke-RestMethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

    Add-AzureRmAccount -EnvironmentName "AzureStackAdmin" -TenantId $TenantId
    ```
19. When prompted, sign in with your Azure Active Directory account that you provided when provisioning the Azure Stack Hub environment.

20. From the Administrator: Windows PowerShell ISE window, publish the package to Azure Stack Hub Marketplace by running the following (make sure to replace the placeholder <storageaccountname> with the name of the storage account you created earlier in this task):

    ```
    Add-AzsGalleryItem -GalleryItemUri `
      https://<storageaccountname>.blob.local.azurestack.external/packages/Contoso.ContosoWebApp.1.0.0.azpkg -Verbose
    ```

21. Ensure that the command completes successfully.

22. Switch back to the Azure Stack Hub administrator portal and select **+ Create a resource** on the left navigation.

    > **Note**: Alternatively, you can use the Azure Stack Hub User portal at <https://portal.local.azurestack.external/>. The newly added Marketplace item should be available in both.

23. On the New blade, select the **Custom** category. 

24. On the Custom blade, select **See all** and ensure that **Contoso WebApp** appears in the list of resource types to provision.

    > **Note**: It might take a few minutes for a newly added Marketplace item to appear.

    ![In the Azure Stack Hub administrator portal, Contoso WebApp custom Marketplace item is displayed.](images-operate/image6.png "Contoso WebApp custom Marketplace item")

25. On the Custom blade, select **Contoso WebApp**.

26. On the Contoso webapp blade, review the interface of the Contoso webapp blade to verify that it reflects the configuration you specified when creating the package.

27. On the Contoso webapp blade, select **Create**.

28. Step through the process of configuring the deployment but do not select **Create**.

29. Close all open windows.

    > **Note**: In general, in order to ensure that the new Azure Stack Hub Marketplace item is functional, you also need to satisfy all of the prerequisites for its deployment, such as OS images referenced by a VM template, are in place. 

## Exercise 2: Implement multi-tenancy

Duration: 30 minutes

In this exercise, you will implement Azure Stack Hub multi-tenancy.

### Task 1: Create and configure a new Azure Active Directory tenant

1. From the AzS-Host1 Azure VM, start a web browser, navigate to the Azure portal at <https://portal.azure.com>, and sign in by using an account with the Global Admin privileges to the Azure AD tenant associated with the Azure Stack Hub environment.

2. In the Azure portal, select **+ Create a resource**.

3. On the New blade, in the **Search the Marketplace** text box, type **Azure Active Directory** and, in the list of results, select **Azure Active Directory**.

4. On the Azure Active Directory blade, select **Create**. 

5. On the Create directory blade, specify the following settings and select **Create**:

    - Organization name: **Fabrikam**

    - Initial domain name: **Any valid, unique domain portion of the fully qualified DNS domain name in the onmicrosoft.com namespace**.

    - Country or region: **United States**

6. Wait until the new directory is created and then use the link **select here to manage your new directory** to navigate to the **Fabrikam** Azure Active Directory blade.

7. On the Fabrikam - Overview blade, select **Users** under **Manage** on the left.

8. On the Users - All users blade, select **+ New user**.

9. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    > **Note**: Take a note of the user names (including the domain suffix) and their autogenerated passwords. You will need them in the subsequent tasks of this lab.

    - User name: **fabrikamadmin1**

    - Name: **Fabrikam Admin1**

    - First name: **not set**

    - Last name: **not set**

    - Password: **Auto-generate password**

    - Initial password: **Show Password**

    - Roles: **Global administrator**

    - Block sign in: **No**

    - Usage location: **United States**

    - Job title : **not set**

    - Department : **not set**

10. Back on the Users - All users blade, select **+ New user**.

11. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    - User name: **fabrikamuser1**

    - Name: **Fabrikam User1**

    - First name: **not set**

    - Last name: **not set**

    - Password: **Auto-generate password**

    - Initial password: **Show Password**

    - Roles: **User**

    - Block sign in: **No**

    - Usage location: **United States**

    - Job title : **not set**

    - Department : **not set**

12. Select the **Directory + Subscription** icon (to the right of the Cloud Shell icon). 

13. In the Directory + Subscription pane, in the Switch directory section, select the entry representing the Azure Active Directory tenant associated with the Azure Stack Hub environment.

14. In the Azure portal, select the user name appearing in the upper right corner, select **Sign out**, and then close the web browser window.

### Task 2: Configure the existing Azure Stack Hub Azure Active Directory tenant

1. Start Windows PowerShell ISE as administrator.

    > **Note**: Subsequent steps require Azure Stack PowerShell and tools installed. This was performed as part of **Azure Stack Hub - Operations - Before the hands-on lab setup guide**.

2. From the Administrator: Windows PowerShell ISE window, set the current directory to the location of the Azure Stack Hub Tools and import required PowerShell modules by running the following:

    ```powershell
    Set-Location -Path '\AzureStack-Tools-master'
    Import-Module .\Connect\AzureStack.Connect.psm1
    Import-Module .\Identity\AzureStack.Identity.psm1
    ```

3. From the Administrator: Windows PowerShell ISE window, sign in to the Azure Stack Hub as operator by running the following (make sure to replace the placeholder <tenant_name> with the name of your Azure Active Directory tenant):

    ```powershell
    Add-AzureRMEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" `
      -AzureKeyVaultDnsSuffix adminvault.local.azurestack.external `
      -AzureKeyVaultServiceEndpointResourceId https://adminvault.local.azurestack.external

    $AuthEndpoint = (Get-AzureRmEnvironment -Name "AzureStackAdmin").ActiveDirectoryAuthority.TrimEnd('/')
    $AADTenantName = "<tenant_name>.onmicrosoft.com"
    $TenantId = (Invoke-RestMethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

    Add-AzureRmAccount -EnvironmentName "AzureStackAdmin" -TenantId $TenantId
    ```
4. When prompted, sign in with your Azure Active Directory account that you provided when provisioning the Azure Stack Hub environment.

5. From the Administrator: Windows PowerShell ISE window, specify that you will accept identities from the newly created Azure Active Directory tenant by running the following (replace the placeholder `<contoso>` with the DNS name of the existing Azure AD tenant and the placeholder `<fabrikam>` with the DNS name of the newly created Azure AD tenant):

     ```
     $adminARMEndpoint = "https://adminmanagement.local.azurestack.external"

     $azureStackDirectoryTenant = "<contoso>.onmicrosoft.com"
     $guestDirectoryTenantToBeOnboarded = "<fabrikam>.onmicrosoft.com"
     $ResourceGroupName = "system.local"
     $location = "local"
     $SubscriptionName = "Default Provider Subscription"

     Register-AzSGuestDirectoryTenant -AdminResourceManagerEndpoint $adminARMEndpoint `
      -DirectoryTenantName $azureStackDirectoryTenant `
      -GuestDirectoryTenantName $guestDirectoryTenantToBeOnboarded `
      -Location $location `
      -ResourceGroupName $ResourceGroupName `
      -SubscriptionName $SubscriptionName
     ```

6. When prompted, sign in with your Azure Active Directory account that you provided when provisioning the Azure Stack Hub environment.

7. Verify that the operation was successful and close the Administrator: Windows PowerShell ISE window.

### Task 3: Configure the newly created Azure Active Directory tenant

1. Start Windows PowerShell ISE as administrator.

2. From the Administrator: Windows PowerShell ISE window, set the current directory to the location of the Azure Stack Hub Tools and import required PowerShell modules by running the following:

    ```powershell
    Set-Location -Path '\AzureStack-Tools-master'
    Import-Module .\Connect\AzureStack.Connect.psm1
    Import-Module .\Identity\AzureStack.Identity.psm1
    ```

3. From the Administrator: Windows PowerShell ISE window, register Azure Stack Hub with the newly created Azure Active Directory tenant by running the following (replace the placeholder `<fabrikam>` with the DNS name of the newly created Azure AD tenant):

     ```
     $tenantARMEndpoint = "https://management.local.azurestack.external"
     $guestDirectoryTenantName = "<fabrikam>.onmicrosoft.com"

     Register-AzSWithMyDirectoryTenant `
      -TenantResourceManagerEndpoint $tenantARMEndpoint `
      -DirectoryTenantName $guestDirectoryTenantName `
      -Verbose
     ```

4. When prompted, sign in by using the **FabrikamAdmin1** account you created in the first task of this exercise. In the Update your password window, change the password to something you'll remember.

5. Verify that the operation was successful and close the Administrator: Windows PowerShell ISE window.

6. To verify that the multi-tenancy has been configured properly, start Internet Explorer with the InPrivate Browsing option, navigate to the Azure Stack Hub user portal at <https://portal.local.azurestack.external/> and, when prompted, authenticate by using the **FabrikamUser1** account you created in the first task of this exercise.In the Update your password window, change the password and make a note of it for this lab.

    > **Note**: Multi-tenancy provides the ability for users in the guest Azure Active Directory tenant to access the Azure Stack Hub user portal (and their respective subscriptions), but not the Azure Stack Hub administrator portal.

7. Close all open windows.

## Exercise 3: Implement delegated management of plans, offers, and subscriptions

Duration: 90 minutes

In this exercise, you will implement Azure Stack Hub delegation in a multi-tenant environment

   > **Note**: Implementing delegation in a single tenant environment follows the same procedure as the one described in this exercise. The only difference is that you delegate to identities (users and groups) which reside exclusively in the same Azure Active Directory tenant. 

### Task 1: Create delegated operator and user Azure Active Directory accounts (as the Azure Stack Hub operator)

1. From the AzS-Host1 Azure VM, start a web browser, navigate to the Azure portal at <https://portal.azure.com>, and sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

2. In the Azure portal, select **Azure Active Directory** under the left navigation on the left.

    ![In the Azure portal, the left navigation is displayed.](images-operate/AzureADSelect.png "Azure portal left navigation")

3. On the Azure Active Directory blade of the tenant associated with the Azure Stack Hub environment, select **Users** under **Manage** on the left. 

4. On the Users - All users blade, select **+ New user**.

5. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    > **Note**: Take note of the user names (including the domain suffix) and their autogenerated passwords. You will need them in the subsequent tasks of this lab.

    - User name: **contosoazsdp1**

    - Name: **Contoso AzSDP1**

    - First name: **not set**

    - Last name: **not set**

    - Password: **Auto-generate password**

    - Initial password: **Show Password**

    - Roles: **User**

    - Block sign in: **No**

    - Usage location: **United States**

    - Job title : **not set**

    - Department : **not set**

6. Back on the Users - All users blade, select **+ New user**.

7. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    - User name: **contosouser1**

    - Name: **Contoso User1**

    - First name: **not set**

    - Last name: **not set**

    - Password: **Auto-generate password**

    - Initial password: **Show Password**

    - Roles: **User**

    - Block sign in: **No**

    - Usage location: **United States**

    - Job title : **not set**

    - Department : **not set**

8. Leave the browser window open.

9. Start a web browser using in private/incognito mode, navigate to the Azure portal at <https://portal.azure.com>, and sign in with the **FabrikamAdmin1** Azure Active Directory credentials you created in the previous exercise. 

10. In the Azure portal, select **Azure Active Directory** in the left navigation.

11. On the Azure Active Directory blade of the Fabrikam Azure Active Directory tenant select **Users**.

12. On the Users - All users blade, select **+ New user**.

13. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    - User name: **fabrikamazsdp1**

    - Name: **Fabrikam AzSDP1**

    - First name: **not set**

    - Last name: **not set**

    - Password: **Auto-generate password**

    - Initial password: **Show Password**

    - Roles: **User**

    - Block sign in: **No**

    - Usage location: **United States**

    - Job title : **not set**

    - Department : **not set**

14. Leave the browser in private/incognito mode window open.

### Task 2: Create a plan consisting of the Subscription service (as the Azure Stack Hub operator)

1. Start a browser and navigate to the Azure Stack Hub administrator portal at https://adminportal.local.azurestack.external/.

2. When prompted, sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

3. In the Azure Stack Hub administrator portal, select **+ Create a resource**. 

4. On the New blade, select **Offers + Plans** and then select **Plan**.

5. On the Basics tab of the New plan blade, specify the following settings:

    - Display name: **DP-subscription-plan1**

    - Resource name: **dp-subscription-plan1**

    - Description: **Delegated provider plan containing Microsoft.Subscriptions**.

    - Resource group: **(Create new) dp-RG**

    ![In the Azure Stack Hub administrator portal, the Basics tab of the New plan blade is displayed.](images-operate/image7.png "Basics tab of the New plan blade")

6. Select the **Services** tab.

7. On the Services tab of the New plan blade, select the **Microsoft.Subscriptions** checkbox.

    ![In the Azure Stack Hub administrator portal, the Services tab of the New plan blade is displayed.](images-operate/image8.png "Services tab of the New plan blade")

8. Select the **Quotas** tab.

9. On the Quotas tab of the New plan blade, in the **Microsoft.Subscriptions** drop down list, select **delegatedProviderQuota**.

    ![In the Azure Stack Hub administrator portal, the Quotas tab of the New plan blade is displayed.](images-operate/image9.png "Quotas tab of the New plan blade")

    Select **Review + create** and then select **Create**. 

### Task 3: Create an offer based on the plan consisting of the Subscriptions service (as the Azure Stack Hub operator)

1. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left. 

2. On the New blade, select **Offers + Plans** and then select **Offer**.

3. On the Basics tab of the Create a new offer blade, specify the following settings:

    - Display name: **Subscription-for-dp-offer1**

    - Resource name: **subscription-for-dp-offer1**

    - Description: **Offer for delegated providers containing Microsoft.Subscriptions services**.

    - Resource group: **dp-RG**

    - Make this offer public?: **No**

    ![In the Azure Stack Hub administrator portal, the Basics tab of the New offer blade is displayed.](images-operate/image10.png "Basics tab of the New offer blade")

4. Select the **Base plans** tab.

5. On the **Base plans** tab of the Create a new offer blade, select the **DP-subscription-plan1** checkbox.

    ![In the Azure Stack Hub administrator portal, the Base plans tab of the New offer blade is displayed.](images-operate/image11.png "Base plans tab of the New offer blade")

6. Do not include Add-on plans, select **Review + create** then select **Create**. 

### Task 4: Create new subscriptions containing the offer with the delegated providers as their subscriber (as the Azure Stack Hub operator)

1. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left. 

2. On the New blade, select **Offers + Plans** and then select **Subscription**.

3. On the New user subscription blade, specify the following settings:

    - Display name: **Contoso-DP-subscription1**

    - User: UPN of the **Contoso AzSDP1** user you created earlier in this exercise.

    - Offer: **Subscription-for-dp-offer1**

    - Directory tenant: The Azure Active Directory tenant associated with the Azure Stack Hub environment.

    ![In the Azure Stack Hub administrator portal, the New user subscription blade for Contoso is displayed.](images-operate/image12.png "New user subscription blade")

4. Select **Create**. 

5. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left. 

6. On the New blade, select **Offers + Plans** and then select **Subscription**.

7. On the New user subscription blade, specify the following settings:

    - Display name: **Fabrikam-DP-subscription1**

    - User: UPN of the **Fabrikam AzSDP1** user you created earlier in this exercise.

    - Offer: **Subscription-for-dp-offer1**

    - Directory tenant: The Fabrikam Azure Active Directory tenant which you associated with the Azure Stack Hub environment in the previous exercise.

    ![In the Azure Stack Hub administrator portal, the New user subscription blade for Fabrikam is displayed.](images-operate/image13.png "New user subscription blade")

8. Select **Create**. 

### Task 5: Create a plan to be delegated by delegated providers to users (as the Azure Stack Hub operator)

1. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left. 

2. On the New blade, select **Offers + Plans** and then select **Plan**.

3. On the Basics tab of the New plan blade, specify the following settings:

    - Display name: **DP-services-plan1**

    - Resource name: **dp-services1-plan**

    - Description: **Delegated provider plan containing services to be delegated to users**.

    - Resource group: **dp-RG**

    ![In the Azure Stack Hub administrator portal, the Basics tab of the New plan blade is displayed.](images-operate/image14.png "Basics tab of the New plan blade")

4. Select the **Services** tab.

5. On the Services tab of the New plan blade, select the **Microsoft.Storage** checkbox.

    ![In the Azure Stack Hub administrator portal, the Services tab of the New plan blade is displayed.](images-operate/image15.png "Services tab of the New plan blade")

6. Select the **Quotas** tab.

7. On the Quotas blade, select **Create new** next to the **Microsoft Storage** drop-down list.

8. On the Create Storage quota blade that appears, specify the following settings:

    - Name: **dp-storage-quota1**

    - Capacity (GB): **200**

    - Number of storage accounts: **1**

    ![In the Azure Stack Hub administrator portal, the Quotas tab of the New plan blade and the Create Storage quotas blade are displayed.](images-operate/image16.png "Quotas tab of the New plan blade")

9. Select **OK**. This will automatically set the **Microsoft Storage** drop-down list entry to **dp-storage-quota1**.

10. Select **Review + create** then select **Create**. 

### Task 6: Create an offer based on the plan containing Microsoft.Storage (as the Azure Stack Hub operator)

1. In the Azure Stack Hub administrator portal, select **+ Create a resource** on the left. 

2. On the New blade, select **Offers + Plans** and then select **Offer**.

3. On the Basics tab of the Create new offer blade, specify the following settings:

    - Display name: **services-for-dp-offer1**

    - Resource name: **services-for-dp-offer1**

    - Description: **Offer for delegated providers containing Microsoft.Storage services**.

    - Resource group: **dp-RG**

    - Make this offer public?: **No**

    ![In the Azure Stack Hub administrator portal, the Basics tab of the Create a new offer blade is displayed.](images-operate/image17.png "Basics tab of the Create a new offer blade")

4. Select the **Base plans** tab.

5. On the Base plans tab of the Create a new offer blade, select the **DP-services-plan1** checkbox.

    ![In the Azure Stack Hub administrator portal, the Base plans tab of the Create a new offer blade is displayed.](images-operate/image18.png "Base plans tab of the Create a new offer blade")

6. Do not include Add-on plans, select **Review + create**, and then select **Create**. 

### Task 7: Delegate the offer to delegated providers (as the Azure Stack Hub operator)

1. In the Azure Stack Hub administrator portal, select **All services** on the left then select **Offers**. 

2. On the Offers blade, select **services-for-dp-offer1**.

3. On the services-for-dp-offer1 blade, select **Delegated providers** under **Settings** on the left.

4. Select **+ Add**.

5. On the Delegate offer blade, specify the following settings and select **Delegate**. 

    - Name: **Accept the default name.**

    - Pick delegated provider subscription: **Contoso-DP-subscription1**.

    ![In the Azure Stack Hub administrator portal, the Delegate offer for Contoso subscriptions blade is displayed.](images-operate/image19.png "Delegate offer")

6. Select **+ Add** again.

7. On the Delegate offer blade, specify the following settings and select **Delegate**.

    - Name: **Accept the default name.**

    - Pick the delegated provider subscription: **Fabrikam-DP-subscription1**.

    ![In the Azure Stack Hub administrator portal, the Delegate offer for Fabrikam subscriptions blade is displayed.](images-operate/image20.png "Delegate offer")

### Task 8: Create a delegated provider offer for Contoso users (as the Contoso delegated provider) based on offer from the Azure Stack Hub operator

   > **Note**: This will allow Contoso users to create subscriptions based on the offer from the delegated provider.

1. Start a web browser with the InPrivate Browsing option, navigate to the Azure Stack Hub user portal at <https://portal.local.azurestack.external/> and, when prompted, authenticate by using the **Contoso AzSDP1** account you created in the first task of this exercise. In the Update your password window, change the password to something you'll remember.

2. In the Azure Stack Hub user portal, select **All services** on the left then select **Offers**. Then select **+ Add**. 

3. On the Create a new offer blade, select **Delegated offer**.

4. On the Delegated offer blade, select the entry corresponding to the delegated offer based on **services-for-dp-offer1**.

5. On the Create a new offer blade, specify the following settings:

    - Display name: **The name matching the *Delegated offer* entry.**

    - Resource name: **The name matching the *Delegated offer* entry.**

    - Provider subscription: **Contoso-DP-subscription1**

    - Resource group: **(Create new) Contoso-dp1-RG**.

    ![In the Azure Stack Hub user portal, the Create a new offer for Contoso is displayed.](images-operate/image21.png "Create a new offer")

6. Select **Create**. 

7. Back on the **Offers** blade, select the newly created offer.

    > **Note**: You might need to select **Refresh**.

8. On the blade of the newly created offer, select **Change state** and, in the drop-down list, select **Public**.

    ![In the Azure Stack Hub user portal, the delegated-services-for-dp-offer1 blade with the Change state drop-down list and the Public entry selected is displayed.](images-operate/image22.png "delegated-services-for-dp-offer1 blade")

9. In the Azure Stack Hub user portal, select **All services** on the left. 

10. In the list of services, select **Subscriptions**.

11. On the Subscriptions blade, select **Contoso-DP-subscription1**.

12. On the Contoso-DP-subscription1 blade, select **Properties** under **Settings** on the left.

13. On the properties blade, copy the value of the PORTAL URL to clipboard. You will need it in the next task of this exercise. 

    > **Note**: Tenants need to subscribe to the offer from that URL.

14. Sign out from the Azure Stack Hub tenant portal and close the web browser window.

### Task 9: Create a delegated provider offer for Fabrikam users (as the Fabrikam delegated provider) based on offer from the Azure Stack Hub operator

   > **Note**: This will allow Fabrikam users to create subscriptions based on the offer from the delegated provider.

1. Start a web browser with the InPrivate Browsing option, navigate to the Azure Stack Hub user portal at <https://portal.local.azurestack.external/> and, when prompted, authenticate by using the **Fabrikam AzSDP1** account you created in the first task of this exercise. In the Update your password window, change the password to something you'll remember.

2. In the Azure Stack Hub user portal, select **All services** on the left then select **Offers**. 

3. On the Offers blade, select **+ Add**.

4. On the Create a new offer blade, select **Delegated offer**.

5. On the Delegated offer blade, select the entry corresponding to the delegated offer based on **services-for-dp-offer1**.

6. On the Create a new offer blade, specify the following settings:

    - Display name: The name matching the **Delegated offer** entry.

    - Resource name: The name matching the **Delegated offer** entry.

    - Provider subscription: **Fabrikam-DP-subscription1**

    - Resource group: The name of a new resource group **Fabrikam-dp1-RG**

    ![In the Azure Stack Hub user portal, the Create a new offer for Fabrikam is displayed.](images-operate/image23.png "Create a new offer")

7. Select **Create**. 

8. Back on the **Offers** blade, select the newly created offer.

    > **Note**: You might need to select **Refresh**.

9. On the blade of the newly created offer, select **Change state** and, in the drop-down list, select **Public**.

    ![In the Azure Stack Hub user portal, the delegated-services-for-dp-offer1 blade with the Change state drop-down list and the Public entry selected is displayed.](images-operate/image24.png "Change state drop-down list")

10. In the Azure Stack Hub user portal, select **All services**. 

11. In the list of services, select **Subscriptions**.

12. On the Subscriptions blade, select **Fabrikam-DP-subscription1**.

13. On the Fabrikam-DP-subscription1 blade, select **Properties**.

14. On the properties blade, copy the value of the PORTAL URL to clipboard. You will need it in the next task of this exercise, 

    > **Note**: Tenants need to subscribe to the offer from that URL.

15. Sign out from the Azure Stack Hub tenant portal and close the web browser window.

### Task 10: Sign up for the delegated provider's offer (as a Contoso user)

1. Start a web browser with the InPrivate Browsing option, navigate to the Contoso delegated provider portal URL you identified earlier in this exercise, and, when prompted, authenticate by using the **Contoso User1** account you created in the first task of this exercise. In the Update your password window, change the password to something you'll remember.

    > **Note**: Make sure **NOT** to use the Azure Stack Hub user portal URL in this case.

2. In the Azure Stack Hub user portal, select **Get a subscription** on the dashboard. 

3. On the Get a subscription blade, in the Display name text box, type **Contoso-user1-subscription1**.

4. Choose **Select an offer**.

5. On the Choose an offer blade, select the name of the Contoso delegated offer created earlier in this exercise and select **Create**.

6. In the message box **Your subscription has been created. You must refresh the portal to start using your subscription**, select **Refresh**. 

### Task 11: Sign up for the delegated provider's offer (as a Fabrikam user)

1.  Start a web browser with the InPrivate Browsing option, navigate to the Fabrikam delegated provider portal URL you identified earlier in this exercise, and, when prompted, authenticate by using the **Fabrikam User1** account you created in the first task of this exercise. In the Update your password window, change the password to something you'll remember.

    > **Note**: Make sure NOT to use the Azure Stack Hub user portal URL in this case.

2.  In the Azure Stack Hub user portal, select **Get a subscription** on the dashboard. 

3.  On the Get a subscription blade, in the Display name text box, type **Fabrikam-user1-subscription1**.

4.  Choose **Select an offer**.

5.  On the Choose an offer blade, select the name of the Contoso delegated offer created earlier in this exercise.

6.  Select **Create**.

7.  In the message box **Your subscription has been created. You must refresh the portal to start using your subscription**, select **Refresh**. 

## Exercise 4: Configure Role Based Access Control (RBAC)

Duration: 30 minutes

In this exercise, you will configure Role Based Access Control using a custom role.

### Task 1: Create a custom role

1.  From the AzS-Host1 Azure VM, start Windows PowerShell ISE as administrator.

2.  From the Administrator: Windows PowerShell ISE window, sign in to the Azure Stack Hub as operator by running the following (make sure to replace the placeholder <tenant_name> with the name of your Azure Active Directory tenant):

    ```powershell
    Set-Location -Path '\AzureStack-Tools-master'

    Add-AzureRMEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" `
      -AzureKeyVaultDnsSuffix adminvault.local.azurestack.external `
      -AzureKeyVaultServiceEndpointResourceId https://adminvault.local.azurestack.external

    $AuthEndpoint = (Get-AzureRmEnvironment -Name "AzureStackAdmin").ActiveDirectoryAuthority.TrimEnd('/')
    $AADTenantName = "<tenant_name>.onmicrosoft.com"
    $TenantId = (Invoke-RestMethod "$($AuthEndpoint)/$($AADTenantName)/.well-known/openid-configuration").issuer.TrimEnd('/').Split('/')[-1]

    Add-AzureRmAccount -EnvironmentName "AzureStackAdmin" -TenantId $TenantId

    ```
3.  When prompted, sign in with your Azure Active Directory account that you provided when provisioning the Azure Stack Hub environment.

4.  From the Administrator: Windows PowerShell ISE window, sign in to the Azure Stack Hub as operator by running the following:

    ```powershell
    $defaultProviderSubscriptionId = (Get-AzureRmSubscription -SubscriptionName 'Default Provider Subscription').Id
    Set-AzureRmContext -SubscriptionId $defaultProviderSubscriptionId
    $defaultProviderSubscriptionId 
    ```

5.  Copy the value of the Default Provider Subscription ID displayed in the Administrator: Windows PowerShell ISE window into Clipboard.

6.  Start File Explorer, create a file **C:\Downloads\CustomReaderRoleDefinition.json** (create the folder **C:\Downloads** if needed), add the following content to it, replace the placeholder `<default_provider_subscription_id>` with the value you copied into Clipboard, and save the file: 

     ```
     {
         "Name":"Activity Log Reader (custom)",
         "IsCustom":true,
         "Description":"Grants permissions to read Activity Log",
         "Actions": [
                 "Microsoft.Insights/eventtypes/*"
         ],
         "NotActions":[
         ],
         "AssignableScopes":[
                 "/subscriptions/<default_provider_subscription_id>"
         ]
     }
     ```

7.  From the Administrator: Windows PowerShell ISE window, create a custom role definition by running:

     ```
     New-AzureRmRoleDefinition -InputFile "C:\Downloads\CustomReaderRoleDefinition.json"
     ```

### Task 2: Create Azure AD users and groups

1.  From the AzS-Host1 Azure VM, start a web browser using in private/incognito mode, navigate to the Azure portal at <https://portal.azure.com>, and sign in with the **FabrikamAdmin1** Azure Active Directory credentials you created earlier in this lab. 

2.  In the Azure portal, select **Azure Active Directory**.

3.  On the Azure Active Directory blade of the Fabrikam Azure Active Directory tenant, select **Users**.

4.  On the Users - All users blade, select **+ New user**.

5.  On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    > **Note**: Take a note of the user names (including the domain suffix) and their autogenerated passwords. You will need them in the subsequent tasks of this lab.

    -  User name: **fabrikamazsreader1**

    -  Name: **Fabrikam AzSReader1**

    -  First name: not set

    -  Last name: not set

    -  Password: **Auto-generate password**

    -  Initial password: **Show Password**

    -  Roles: **User**

    -  Block sign in: **No**

    -  Usage location: **United States**

    -  Job title : not set

    -  Department : not set

6.  Sign out as FabrikamAdmin1 from the Azure portal and close the window of the web browser using in private/incognito mode.

7.  From the AzS-Host1 Azure VM, start a web browser, navigate to the Azure portal at <https://portal.azure.com>, and sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

8.  In the Azure portal, select **Azure Active Directory**.

9.  On the Azure Active Directory blade of the tenant associated with the Azure Stack Hub environment, select **Users**.

10. On the Users - All users blade, select **+ New user**.

11. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    > **Note**: Take a note of the user names (including the domain suffix) and their autogenerated passwords. You will need them in the subsequent tasks of this exercise.

    -  User name: **contosoazsreader1**

    -  Name: **Contoso AzSReader1**

    -  First name: not set

    -  Last name: not set

    -  Password: **Auto-generate password**

    -  Initial password: **Show Password**

    -  Roles: **User**

    -  Block sign in: **No**

    -  Usage location: **United States**

    -  Job title : not set

    -  Department : not set

12. Back on the Users - All users blade, select **+ New user**.

13. On the **New user** blade, ensure that the **Create user** option is selected, specify the following settings, note the values of the full user name (including the domain suffix) and the randomly generated password, and select **Create**:

    -  User name: **contosoazslogreader1**

    -  Name: **Contoso AzSLogReader1**

    -  First name: not set

    -  Last name: not set

    -  Password: **Auto-generate password**

    -  Initial password: **Show Password**

    -  Roles: **User**

    -  Block sign in: **No**

    -  Usage location: **United States**

    -  Job title : not set

    -  Department : not set

14. Back on the Users - All users blade, select **+ New guest user**.

15. On the **New user** blade, ensure that the **Invite user** option is selected, specify the following settings, and select **Invite**:

    -  Name: **Fabrikam AzSReader1**

    -  User name: **The UPN of the Fabrikam Operator1 user you created in the previous exercise**.

    -  First name: not set

    -  Last name: not set

    -  Personal message : **Welcome to the Contoso Azure Stack Hub Azure Active Directory tenant**.

    -  Groups: not set

    -  Roles: not set

    -  Block sign in: **No**

    -  Usage location: **United States**

    -  Job title : not set

    -  Department : not set

16. Start a web browser using in private/incognito mode and browse to the following URL (where `<existing_tenant>` represents the DNS name of the original Azure Active Directory tenant associated with your Azure Stack Hub subscription).

     ```
     https://portal.azure.com/#@<existing_tenant>.onmicrosoft.com
     ```

17. When prompted, sign in by using the credentials of the **Fabrikam AzSReader1** account.

18. When prompted, grant the target Azure AD tenant requested permissions by selecting **Accept**. In the Update your password window, change the password to something you'll remember.

19. Sign out as Fabrikam AzSReader1 from the Azure portal and close the window of the web browser using in private/incognito mode.

20. Navigate back to the Azure Active Directory blade of the tenant associated with the Azure Stack Hub environment and select **Groups**.

21. On the Groups - All groups blade, select **+ New group**.

22. On the **New Group** blade, specify the following settings, and select **Create**:

    -  Group type: **Security**

    -  Group name: **ContosoAzSReaders**

    -  Group description: **Contoso Azure Stack Hub Readers**

    -  Membership type: **Assigned**

    -  Owners: not set

    -  Members: **Contoso AzSReader1** and **Fabrikam AzSReader1**.

    ![In the Azure portal, the New Group and Add members blades are displayed.](images-operate/image27.png "New Group and Add members blades")

23. On the Groups - All groups blade, select **+ New group**.

24. On the **New Group** blade, specify the following settings, and select **Create**:

    -  Group type: **Security**

    -  Group name: **ContosoAzSReaders**

    -  Group description: **Contoso Azure Stack Hub Readers**

    -  Membership type: **Assigned**

    -  Owners: not set

    -  Members: **Contoso AzSReader1** and **Fabrikam AzSReader1**

    ![In the Azure portal, the New Group and Add members blades are displayed.](images-operate/image27.png "New Group and Add members blades")

25. Back on the Groups - All groups blade, select **+ New group**.

26. On the **New Group** blade, specify the following settings, and select **Create**:

    -  Group type: **Security**

    -  Group name: **ContosoAzSLogReaders**

    -  Group description: **Contoso Azure Stack Hub Log Readers**

    -  Membership type: **Assigned**

    -  Owners: not set

    -  Members: **Contoso AzSLogReader1**

    ![In the Azure portal, the New Group and Add members blades are displayed.](images-operate/image28.png "New Group and Add members blades")

### Task 3: Configure RBAC role assignments

1.  Start Internet Explorer and navigate to the Azure Stack Hub administrator portal at <https://adminportal.local.azurestack.external>.

2.  When prompted, sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

3.  In the Azure Stack Hub administrator portal, select **All services** and then, in the list of services, select **Subscriptions**.

4.  On the Subscriptions blade, select **Default Provider Subscription**. 

5.  On the Default Provider Subscription blade, select **Access control (IAM)** and then select **+ Add**.

    ![In the Azure Stack Hub administrator portal, the Default Provider Subscription - Access control (IAM) is displayed.](images-operate/image25.png "Default Provider Subscription")

6.  In the **Add permissions** pane, specify the following settings and then select **Save**:

    -  Role: **Activity Log Reader (custom)**

    -  Select: **ContosoAzSLogReaders**

    ![In the Azure Stack Hub administrator portal, the Default Provider Subscription - Access Control (IAM)  Add permissions blade with a custom role selected is displayed.](images-operate/image29.png "Add permissions blade")

7.  Back on the Default Provider Subscription - Access control (IAM) blade and then select **+ Add**.

8.  In the **Add permissions** pane, specify the following settings and then select **Save**:

    -  Role: **Reader**

    -  Select: **ContosoAzSReaders**

    ![In the Azure Stack Hub administrator portal, the Default Provider Subscription - Access Control (IAM)  Add permissions blade with a built-in role selected is displayed.](images-operate/image30.png "Add permissions blade")

## Exercise 5: Connect to and work with the Privileged Endpoint

Duration: 60 minutes

In this exercise, you establish a PowerShell Remoting session to the privileged endpoint.

### Task 1: Create a log share

   > **Note**: The share will be used to store diagnostics logs collected via the privileged endpoint.

1.  From the AzS-Host1 Azure VM, start File Explorer.

2.  In File Explorer, verify that the folder C:\Logs exists (if not, create it). 

3.  Right-click **Logs** and, in the right-click menu, select **Properties**.

4.  In the Logs Properties window, select the **Sharing** tab and then select **Advanced Sharing**.

5.  In the Advanced Sharing dialog box, select **Share** this folder and then select **Permissions**.

6.  In the Permissions for Logs window, ensure that the Everyone entry is selected and then select **Remove**.

7.  Select **Add**, in the Select Users, Computers, Service Accounts, or Groups dialog box, type **CloudAdmins** and select **OK**.

8.  Ensure that the **CloudAdmins** entry is selected and select the **Full Control** checkbox in the Allow column.

    ![In File Explorer, the share permissions of the Logs share are displayed.](images-operate/image31.png "File Explorer")

9.  Select **OK**.

10. Back in the Advanced Sharing dialog box, select **OK**.

11. Back in the Logs Properties window, select **Close**.

### Task 2: Connect to the privileged endpoint via PowerShell Remoting

1.  From the AzS-Host1 Azure VM, start Windows PowerShell ISE as administrator.

2.  From the Administrator: Windows PowerShell ISE window, store in a variable the Azure Stack Hub admin credentials that you will use to access Privileged Endpoint by running the following:

     ```
     $adminUserName = 'azurestack\CloudAdmin'
     $adminPassword = 'demo@pass123' | ConvertTo-SecureString -Force -AsPlainText
     $adminCredentials = New-Object PSCredential($adminUserName,$adminPassword)
     ```

3.  From the Administrator: Windows PowerShell ISE window, run the following to establish a PowerShell Remoting session to the privileged endpoint:

     ```
     Enter-PSSession -ComputerName 'AzS-ERCS01' -ConfigurationName PrivilegedEndpoint -Credential $adminCredentials
     ```

4.  Verify that the PowerShell Remoting session has been successfully established. The console pane in the Windows PowerShell ISE window should be displaying the prompt starting with the name of the infrastructure VM hosting the privileged endpoint enclosed in square brackets (`[AzS-ERCS01]`).

### Task 3: Review capabilities of the privileged endpoint

1.  From the PowerShell Remoting session in the Administrator: Windows PowerShell ISE window, in the console pane, identify all available PowerShell functions and cmdlets by running the following:

     ```
     Get-Command
     ```

2.  From the PowerShell Remoting session, identify current Cloud Admin user accounts by running the following:

     ```
     Get-CloudAdminUserList
     ```

    > **Note**: The list should include only two accounts - AzureStackAdmin and CloudAdmin.

### Task 4: Manage Azure Stack Hub diagnostics log collection via the privileged endpoint.

1.  From the PowerShell Remoting session in the Administrator: Windows PowerShell ISE window, in the console pane, collect Azure Stack Hub storage logs by running the following:

     ```
     Get-AzureStackLog -OutputSharePath '\\AzS-Host1\Logs' -OutputShareCredential $using:adminCredentials -FilterByRole Storage
     ```

    > **Note**: On Azure Stack Hub Development Kit systems, it is possible to run Get-AzureStackLog directly from the ASDK host. 

    > You have the option of filtering by role as well as specify the time window for which logs should be collected. For details, refer to https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-diagnostics.

2.  Wait until the cmdlet completes and, in File Explorer, review the content of the C:\Logs folder.

    > **Note**: Disregard any error messages during the log collection.

3.  From the PowerShell Remoting session, run the following to exit the session:

     ```
     Exit-PSSession
     ```

## Exercise 6: Implement Azure Stack Hub infrastructure backup

Duration: 30 minutes

### Task 1: Create a backup user

1.  From the AzS-Host1 Azure VM, select **Start**, in the Start menu, expand the Windows Administrative Tools folder, and select **Active Directory Administrative Center**.

2.  In Active Directory Administrative Center, select **azurestack (local)** and, in the main window pane, select the **Users** container.

3.  In the Tasks pane, in the Users section, select **New** and then select **User**.

    ![In Active Directory Administrative Center, the User entry in the New menu of the Users container is selected.](images-operate/image32.png "AD Admin Center")

4.  In the Create User window, specify the following settings and select **OK**:

    -  Full name: **AzS-BackupOperator**

    -  User UPN logon: **AzS-BackupOperator@azurestack.local**

    -  User SamAccountName logon: **azurestack\AzS-BackupOperator**

    -  Password: **demo@pass123**

    -  Confirm password: **demo@pass123**

    -  Password options: **Password never expires**

### Task 2: Create a backup share

   > **Note**: In production scenarios (with Azure Stack Hub integrated systems) you would configure a backup share on a highly available file server. When using Azure Stack Hub Development Kit, you can use for this purpose the ASDK host.

1.  On the AzS-Host1 Azure VM, start File Explorer. 

2.  In File Explorer, create a new folder C:\Backup.

3.  Right-click **Backup** and, in the menu, select **Properties**.

4.  In the Backup Properties window, select the **Sharing** tab and then select **Advanced Sharing**.

5.  In the Advanced Sharing dialog box, select **Share this folder** and then select **Permissions**.

6.  In the Permissions for Backup window, ensure that the **Everyone** entry is selected and then select **Remove**.

7.  Select **Add**, in the Select Users, Computers, Service Accounts, or Groups dialog box, type **AzS-BackupOperator** and select **OK**.

8.  Ensure that the AzS-BackupOperator entry is selected and select the **Full Control** checkbox in the Allow column.

9.  Select **Add**, in the Select Users, Computers, Service Accounts, or Groups dialog box, select **Locations**. 

10. In the Locations dialog box, select the entry representing the local computer (AzS-Host1) and select **OK**.

11. In the Enter the object names to select text box, type **Administrators** and select **OK**.

12. Ensure that the Administrators entry is selected and select the **Full Control** checkbox in the Allow column.

13. Select **OK**.

    ![In File Explorer, the share permissions of the Backup share are displayed.](images-operate/image33.png "File Explorer")

14. Back in the Advanced Sharing dialog box, select **OK**.

15. Back in the Backup Properties window, select the **Security** tab. 

16. Select **Edit**.

17. In the Permissions for Backup dialog box, in the list of entries in the Groups or user names pane, select **AzS-BackupOperator**, in the Permissions for AzS-BackupOperator pane, select **Full Control** in the Allow column and then select **OK**.

18. Back in the Backup Properties window, select **Close**.


### Task 3: Generate an encryption certificate

1.  On the AzS-Host1 Azure VM, start Windows PowerShell ISE as administrator.

2.  From the Administrator: Windows PowerShell ISE window, create a self-signed encryption certificate and store its public key in the C:\Certs directory by running the following:

     ```
     $cert = New-SelfSignedCertificate `
 	    -DnsName "AzSBackup.azurestack.local" `
 	    -CertStoreLocation "cert:\LocalMachine\My"

     New-Item -Path "C:\" -Name "Certs" -ItemType "Directory" 
     Export-Certificate `
 	    -Cert $cert `
 	    -FilePath c:\Certs\AzSIBackupCert.cer
     ```

### Task 4: Configure backup controller

1.  Start Internet Explorer and navigate to the Azure Stack Hub administrator portal at https://adminportal.local.azurestack.external/.

2.  When prompted, sign in with the Azure Active Directory credentials you provided when provisioning the Azure Stack Hub environment.

3.  In the Azure Stack Hub administrator portal, select **All services**. 

4.  In the ADMINISTRATION section, select **Infrastructure backup**.

5.  On the Infrastructure backup blade, select **Configure**.

6.  On the Backup controller settings blade, specify the following settings and select **OK**:

    -  Backup storage location: **\\AzS-Host1.azurestack.local\Backup**

    -  Username: **AzS-BackupOperator@azurestack.local**

    -  Password: **demo@pass123**

    -  Confirm password: **demo@pass123**

    -  Backup frequency in hours: **12**

    -  Retention period in days: **7**

    -  Certificate .cer file: **Select the folder icon and upload the public key of the certificate (C:\Certs\AzSIBackupCert.cer) you generated in the previous task**.

    ![In the Azure Stack Hub administrator portal, the Backup Controller settings blade is displayed.](images-operate/image34.png "Backup Controller settings blade")

7.  Back on the Infrastructure backup blade, select **Disable automatic backup**.

## After the hands-on lab 

Duration: 10 minutes

In this final task you will clean up the Azure Resources that you have create for the hands-on lab. This task is optional.

1.  If provisioned using the Azure Stack Hub Development Kit in an Azure VM, delete the resource group your Azure Stack Hub Host VM is running in.

2.  If running on your own Development Kit, delete all the resource groups from the Azure Stack Hub portal that you created during the execution of this lab.

You should follow all steps provided *after* attending the Hands-on lab.
