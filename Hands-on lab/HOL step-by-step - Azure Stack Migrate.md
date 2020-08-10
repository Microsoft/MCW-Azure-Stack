![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png)

<div class="MCWHeader1">
Azure Stack Migrate
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

<!-- TOC -->

- [Azure Stack Migrate hands-on lab step-by-step](#azure-stack-migrate-hands-on-lab-step-by-step)
    - [Abstract and learning objectives](#abstract-and-learning-objectives)
    - [Overview](#overview)
    - [Solution architecture](#solution-architecture)
    - [Help references](#help-references)
    - [Requirements](#requirements)
    - [Exercise 1: Create Azure Stack Hub Deployment Taxonomy for Tenants](#exercise-1-create-azure-stack-hub-deployment-taxonomy-for-tenants)
        - [Task 1: Create the Deployment Taxonomy](#task-1-create-the-deployment-taxonomy)
    - [Exercise 2: Deploy Contoso Financial Web Application](#exercise-2-deploy-contoso-financial-web-application)
        - [Task 1: Create the Web App](#task-1-create-the-web-app)
        - [Task 2: Provision an Azure Storage Account](#task-2-provision-an-azure-storage-account)
        - [Task 3: Deploy SQL DB on Azure Stack Hub](#task-3-deploy-sql-db-on-azure-stack-hub)
        - [Task 4: Update the configuration strings](#task-4-update-the-configuration-strings)
        - [Task 5: Publish the Contoso Financial Web Application](#task-5-publish-the-contoso-financial-web-application)
    - [Exercise 3: Deploy the customer offers Web API](#exercise-3-deploy-the-customer-offers-web-api)
        - [Task 1: Provision the offers Web API App](#task-1-provision-the-offers-web-api-app)
        - [Task 2: Deploy the Contoso.Apps.Financial.Offers project](#task-2-deploy-the-contosoappsfinancialoffers-project)
        - [Task 3: Update the Application Settings of the Web App with the API URL](#task-3-update-the-application-settings-of-the-web-app-with-the-api-url)
    - [Exercise 4: Automating backend processes with Azure functions](#exercise-4-automating-backend-processes-with-azure-functions)
        - [Task 1: Create an Azure function to generate PDF receipts](#task-1-create-an-azure-function-to-generate-pdf-receipts)
    - [Exercise 5: Deploy Contoso Finance Admin website](#exercise-5-deploy-contoso-finance-admin-website)
        - [Task 1: Provision the Contoso Finance Admin Web App](#task-1-provision-the-contoso-finance-admin-web-app)
        - [Task 2: Deploy the call center admin Web App from Visual Studio](#task-2-deploy-the-call-center-admin-web-app-from-visual-studio)
    - [After the hands-on lab](#after-the-hands-on-lab)

<!-- /TOC -->

# Azure Stack Migrate hands-on lab step-by-step

## Abstract and learning objectives

In this hands-on lab, you will deploy the Azure Stack Hub Development Kit and deploy the SQL Database and Azure App Service resource providers, as well as download several virtual machine images from the Azure Stack Hub Marketplace. From there, you will implement a full taxonomy in Azure Stack Hub consisting of a region, subscription, plan, offer, and quotas. After Azure Stack Hub is configured, you will then deploy Azure SQL Database, Web and API apps and then deploy the Contoso application.

At the end of this hands-on lab, you will be better able to deploy and manage solutions running on Azure Stack Hub.

## Overview

Contoso Finance is one of the largest banks in the United States with a significant amount of their revenue coming from their residential mortgage business. As part of Contoso's shift to a cloud first strategy, they are planning to migrate their loan web applications to a hybrid cloud solution. During the planning stages, Contoso realized they would not be able to retain their customer data in US based Azure regions due to corporate compliance policies and regulatory issues. They have selected Azure Stack Hub as the deployment method to take advantage of Azure technologies while still maintaining compliance.

## Solution architecture

![The Microsoft Azure Stack Hub is made up of Mortgage Applications and Mortgage Admin databases, Offerings API, Storage Queue Mortgage Applications, Mortgage Applications, and SQL Web App DB and Customer Data.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image2.png "Solution Architecture")

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

-   A Microsoft Azure subscription.

## Exercise 1: Create Azure Stack Hub Deployment Taxonomy for Tenants

In this exercise, you will create the subscriptions, offers, and plans that will be used by your Azure Stack Hub tenants. 

Duration: 30 minutes

![Screenshot of an Azure Stack Hub Deployment Taxonomy.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image69.png "Azure Stack Hub deployment")

### Task 1: Create the Deployment Taxonomy

1. Within the Remote Desktop session to **AzSHOST-1**, start a browser and navigate to the **Azure Stack Admin Portal** via the desktop icon.

2. When prompted, sign in with the **AzSHOperator** account you created when following the **Before the hands-on lab guide**.

3. Select **+ Create a resource** on the left. 

4. Select **Offers + Plans** followed by **Plan**.

    ![In the Marketplace blade, Offers and Plans is selected. In the Featured Apps blade, Plan is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image70.png "Featured Apps blade")

5. In the New Plan blade, enter the following configuration then select **Next: Services**.

    - Display name: **PROD-Plan-1**

    - Resource name: **prod-plan-1**

    - Resource group (Create new): **ContosoFinance**

    ![New plan blade, fields are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image71.png "New plan blade")

6. Next, check all of the **Services** except for **Microsoft.MySQLAdapter** and **Microsoft.Subscriptions** and select **Next: Quotas**.

    ![Services are listed in the Services blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image73.png "Services")

7. For Quotas, go through and choose the default quotas where available, with the exception of the **Microsoft.Web** entry. Next, select **Create New** next to the **Microsoft.Web** entry.

    ![The Quotas blade with the default quotas selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image75.png "Quotas blade")

8. On the **Create Quota** blade, specify the following information and select **OK**:

    - Name: **WebQuota**

    - App Service Plans: **10**

    ![The Create Quota tab displays the specified settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image77.png "Create Quota blade")

9. Select **Review + Create** and then confirm the creation by selecting **Create**. The Plan will deploy immediately. 

   ![The Quotas tab of the New plan blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image79.png "Quotas tab of the New plan blade")

10. Select **+ Create a resource** on the left then select **Offers + Plans** followed by **Offer**.

   ![In the Marketplace blade, Offers and Plans is selected. In the Featured Apps blade, Offer is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image81.png "Marketplace blade")

11. Update the New offer blade using the following inputs. Then, select **Next: Base plans**.

    - Display Name: **PROD-Offer-1**

    - Resource Name: **prod-offer-1**

    - Resource group: **ContosoFinance**

    - Make this offer public? **No**

   ![Fields in the New Offer blade are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image82.png "New Offer blade")

12. On the **Base plans** blade, check **PROD-Plan-1** and select **Review + create** and then **Create**.

   ![Screenshot of the Resource group blade. Under Name, a callout points to prod-offer-1.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image83.png "Resource group blade")

15. Open the new offer after it is created. Notice the portal shows a warning stating: "**This offer is private, and users cannot see it**." To fix this, select the **Change state** button.

   ![In the Offer blade, warning displays, and the Change state button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image85.png "Offer blade")

16. Select **Public**.

   ![Public is selected in the Change state menu.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image86.png "Change state menu")

17. The portal will immediately provide a notification about the update to the offer.

   ![Updated offer successfully message screenshot.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image87.png "Success")

18. Next, open a new browser tab, and navigate to Azure Stack Hub User portal and select **Get a subscription**.

    ```
    https://portal.local.azurestack.external
    ```

   ![Azure Stack Hub dashboard screenshot](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image88.png "Azure Stack Hub dashboard")

   > **Note**: This is the User portal Contoso Finance will use to provision and manage their Azure Stack Hub service.


19. Give it the name: **Production** and select the **PROD-Offer-1** and select **Create**.

   ![In the Get a subscription blade, the Display name is Production. In the Choose an offer blade, PROD-Offer-1 is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image90.png "Get a subscription blade")

20. You will need to Refresh the window to start using the new Subscription.

   ![Under the Subscription created message, the Refresh button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image91.png "Refresh")


## Exercise 2: Deploy Contoso Financial Web Application

Duration: 30 minutes

In this exercise, you will provision a website using the Azure Stack Hub portal. The Web App will leverage the SQL DB running in Azure Stack Hub. This is the front-end website that customers will see when browsing for a Mortgage or other financial services products.

### Task 1: Create the Web App

1. From within the Azure Stack Hub User portal, select **+ Create a resource -\> Web + Mobile -\> Web App**.

2. On the **Web App** blade, select the **Production** subscription then select **App Service plan/Location**.

    ![App Service plan/Location option screenshot.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image110.png "App service plan")

3. Create a new App Service plan called **ContosoFinanceWebPlan** with the **D1 Shared** pricing tier and select **OK**.

    ![Screenshot of the D1 Shared pricing tier option.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image111.png "D1 pricing")

4. On the **Web App** blade, specify the following configuration, and select **Create**:

    - App Name: **Specify a unique and valid name (until the green check mark appears)**.

    - Resource group: **(Create new) ContosoFinanceWeb**

    ![Create blade fields are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image112.png "Create blade")

### Task 2: Provision an Azure Storage Account

1. In the Azure Stack Hub User portal, select **+ Create  a resource -\> Data + Storage -\> Storage account - blob, file, table, queue**.

    ![In the New and Data and Storage blades, the previously defined options are selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image113.png "New and Data and Storage blades")

2. On the **Basics** tab of the **Create storage account** blade, specify the following configuration options. Then select **Review + create** followed by **Create**.

    - Subscription: **Production**

    - Resource group: **ContosoFinanceWeb**

    - Storage account name: **Unique value for the storage account (ensure the green check mark appears)**.

    - Location: **local**

    - Performance: **Standard**

    - Account kind: **Storage (general purpose v1)**

    - Replication: **Locally-redundant storage (LRS)**

    ![Create storage account blade fields are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image114.png "Create storage account blade")

3. After the storage account has completed provisioning, open the storage account by selecting **Go to resource**. 

4. On the **Storage** account blade, scroll down and select **Access keys** on the left under **Settings**. 

    ![Under Settings, Access keys is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image116.png "Access keys")

5. On the **Access keys** blade, select the copy button by **Key** to copy the **key1** key value. Paste the value into Notepad for later reference.

    ![The key1 copy button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image117.png "copy button")

6. On the **Access keys** blade, select the copy button by **Connection string** to copy the **key1** connection string value. Paste the value into Notepad for later reference.

    ![The Connection string copy button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image119.png "Connection string copy")

    > **Note**: If the copy to clipboard button does not work, you may need to highlight the key and copy by right-clicking. Some versions of Internet Explorer have issues with this functionality.


### Task 3: Deploy SQL DB on Azure Stack Hub 

1. In the Azure Stack Hub User portal, select **+ Create a Resource -\> Data + Storage -\> SQL Database**.

    ![In the Azure Stack Hub portal, in the New blade, Data and Storage is selected. In the Data and Storage blade, SQL Database is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image99.png "New blade")

2. Complete the **Create Database** blade with the following:

    - Database Name: **ContosoFinanceWebDB**

    - Max Size in MB: **250**

    - Subscription: **Production**

    - Resource group: **ContosoFinanceWeb**

    - Location: **local**

    ![Screenshot of the Create database blade with fields set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image100.png "Create database blade")

3. Next, select **SKU**.

    ![SKU option screenshot.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image101.png "SKU option")

4. Select the **MSSQL2017** SKU.

    ![In the Select a SKU blade, ContosoFinanceSQLProd is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image102.png "Select a SKU blade")

5. Select **Login**.

    ![Screenshot of the Login option.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image103.png "Login option")

6. Select **Create a new login**.

    ![Create a new login is selected in the Select a Login blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image104.png "Create a new login")

7. Complete the **New Login** blade using these inputs and select **OK**:

    - Database Login: **ContosoFinanceWebDB**

    - Password/Confirm Password: **Demo@pass123 - Note: Upper case D**

    ![Fields in the New Login blade are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image105.png "New Login blade")

8. Review the **Create Database** blade and select **Create**.

    ![Fields in the Create Database blade are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image106.png "Create Database blade")

9. Once the deployment completes, use the Azure Stack Hub User portal to locate the **ContosoFinanceWebDB** SQL Database in the **ContosoFinanceWeb** resource group. Select it to examine the details of the new SQL Database running in the Azure Stack Hub PaaS.

    ![In the Resource group blade, under Name, ContosoFinanceWebDB is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image107.png "Resource group blade")

10. On the **ContosoFinanceWebDB** page, copy the connection string to the clipboard and paste it into Notepad. 

    ![In the SQL Database blade, the connection string is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image108.png "SQL Database blade")

    > **Note**: If the clipboard copy does not work, you can use the following sample text for your environment. You will need to alter this text to match your configuration.

    ```
    Data Source=sqlhost.local.cloudapp.azurestack.external,1433;Initial Catalog=ContosoFinanceWebDB;User ID=ContosoFinanceWebDB;Password=Demo\@pass123
    ```

### Task 4: Update the configuration strings

1. Navigate to your web app and on the left pane of the Web App, select **Configuration** under **Settings**.

    ![Under Settings, Application settings is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image121.png "Application settings")

2. Select **+ New application setting**. Enter the following values in the dialog that appears and select **OK**:

    - App Setting Name: **AzureQueueConnectionString**

    - Value: **Enter the Connection String for the Storage Account that you created earlier in this exercise**.

    ![Fields in the App settings section are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image123.png "App settings")

3. Switch to Notepad. For the SQL Server Connection string copied from Azure Stack Hub, ensure that the password is set to `Demo@pass123` rather than a set of asterisks.

    ![The password is set in the SQL DB connection string](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/DBPS.png "Connection string password")

4. Back on the web app configuration page in the Azure Stack Hub User portal, locate the **Connection Strings** section (right below the **Application settings** section) and add a new **Connection String** with the following values then select **OK**. 

    - Name: **ContosoFinance**

    - Value: **Enter the Connection String for the SQL Database in Azure Stack Hub you created earlier in this exercise**.

    - Type: **SQLAzure**

    **Note:** You may receive an error message that says *value is a required property on all connection string*. This can be ignored. 

    ![The Connection strings fields display.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image124.png "Connection strings")

6. Select **Save** on the **Configuration** page and wait for that to complete. 

### Task 5: Publish the Contoso Financial Web Application

> **Note:** The current version of the Azure Stack Hub App Service Provider does not enable the deployment center feature yet. 

1. From within the web app blade, select **Deployment options (Classic)** under **Deployment** on the left.

    ![Deployment options is selected under Deployment.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image125.png "Deployment options")

2. Select **Choose Source**, then **External Repository**.

    ![In the Deployment option blade, Choose source is selected. In the Choose source blade, External Repository is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image126.png "Deployment options")

3. Specify the following  as the **Repository URL** and select **OK**.

    ```
    https://github.com/opsgility/contosofinanceweb
    ```

    ![In the Deployment option blade, Repository ULR is set. In the Choose source blade, External Repository is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image126b.png "Deployment options")

4. Display the **Deployment options (Classic)** blade, monitor the deployment and wait until the web app is deployed.

5. Select the **Overview** tab on the left, and then choose the URL. This should automatically open a new browser tab displaying the Contoso Finance web app.

    ![The URL is selected in the App Service blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image127.png "App Service blade")

    > **Note**: You may get an error about CORS. This can be ignored, as it will be configured later in the lab.

6. Validate the website by selecting the **Products** link on the menu. If the products return, the connection to the database is successful.

    ![The Products link is called out on the Contoso Finance webpage menu.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image128.png "Contoso Finance webpage")

## Exercise 3: Deploy the customer offers Web API

Duration: 30 minutes

In this exercise, you will provision an Azure API App using the Azure Stack Hub portal. This API application is part of the front-end Web Applications and makes recommendations to the user on products the company wishes to highlight. The API App will leverage the SQL Database deployed previously.

### Task 1: Provision the offers Web API App

1. Using the Azure Stack Hub User portal, select **+Create a resource -\> Web + Mobile -\> API App**.

    ![Screenshot of the API App button.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image129.png "API App")

2. On the new **API App** blade, **specify a unique name** for the App Name, select the **Production subscription**, and ensure the previously used Resource Group and App Service Plan are selected. Then select **Create**. 

3. Navigate to the blade of the newly provisioned API app, on the **App Service** blade, scroll down, and select **CORS** within the **API** section of the left pane.

    ![Under API, CORS is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image130.png "CORS")

4. In the **Allowed Origins** text box specify \* and select **Save**.

    ![In the App Service blade, Allowed Origins is set to asterisk, and Save is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image131.png "App Service blade")

5. Select **Configuration** on the left under **Settings**.

6. Scroll down, and locate the **Connection strings** section.

    ![Screenshot of the Connection strings section.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image133.png "Connection strings")

7. Add a new **Connection String** with the following values then select **OK**.

    - Name: **ContosoFinance (must match exactly -- case sensitive)**

    - Value: **Enter the Connection String for the SQL Database in Azure Stack Hub you provisioned in the previous exercise**.

    - Type: **SQLAzure**

    **Note:** You may receive an error message that says *value is a required property on all connection string*. This can be ignored. 

    ![the Connection strings fields are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image133b.png "Connection strings")

8.  Select **Save** on the Configuration page. 

### Task 2: Deploy the Contoso.Apps.Financial.Offers project

1. From within the API app blade, select **Deployment options (Classic)** under **Deployment** on the left.

    ![Under Deployment, Deployment options is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image125.png "Deployment options")

2. Select **Choose Source**, then **External Repository**.

    ![In the Deployment option blade, Choose Source is selected. In the Choose source blade, External Repository is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image126.png "Deployment options")

3. Specify the following as the **Repository URL** and select **OK**.

    ```
    https://github.com/opsgility/contosofinanceoffers
    ```

4. Display the **Deployment options (Classic)** blade, monitor the deployment, and wait until the API app is deployed.

5. Switch to the **Overview** blade and copy the URL for the API app to the clipboard.

    ![The URL is selected in the App Service blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image127b.png "App Service blade")

### Task 3: Update the Application Settings of the Web App with the API URL

1. Open the ContosoFinanceWeb application in the Azure Stack Hub User portal and select **Configuration** on the left under **Settings**.

    ![In the App Service blade, under settings, Application settings is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image134.png "App Service blade")

2. Scroll down and locate the **Application settings** section.

    ![Screenshot of the App settings section.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image135.png "App Service blade")

3. Add a new **Application Setting** with the following values and select **OK**. 

    - App Setting Name: **offersAPIUrl**

    - Value: Enter the **HTTPS** URL for the Offers API App with **/api/get** appended to the end.
    
    Example: <https://contosofinanceapi.appservice.local.azurestack.external/api/get>

    ![Under App settings, offersAPIUrl and its URL are selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image136.png "App settings")

    > **Note**: Ensure the API URL is using **SSL** (https://), or you will see a CORS errors when loading the webpage.

4. Select **Save** on the Configuration page.

5. Connect to the URL of the **contosofinanceweb** Web App.

    ![In the App Service blade, the URL link is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image137.png "App Service blade")

6. On the homepage, you should see the latest offers populated from the offers API.

    ![Screenshot of the Contoso Finance webpage.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image138.png "Contoso Finance webpage")

## Exercise 4: Automating backend processes with Azure functions 

Duration: 30 minutes

Contoso wants to automate the process of generating applications in PDF format by using Azure Functions. In this exercise, you will provision a Function App using the Azure Stack Hub portal. This Function App will watch the Azure Storage Queue for a message that the web application has submitted, process the application creating a PDF and storing it in Azure Blob Storage.

### Task 1: Create an Azure function to generate PDF receipts

1. From your Azure Stack Hub Host, navigate to the following repository and select **Clone**, then **Download ZIP**. After the file is downloaded, extract it to a new folder named **C:\\HoL**.

    ```
    https://github.com/opsgility/contosofinancefunction
    ```

    ![In the Azure Stack Hub Host, the Clone or download button is selected, and under Clone with HTTPS, the Download ZIP button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image139.png "Azure Stack Hub Host")

2. From the User portal, select **+ Create a resource -> Web + Mobile -> Function App**.

    ![Function App option screenshot](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image140.png "Function App option")

3. Specify the following settings on the **Create Function App** blade using the following inputs and select **Create**. 

    - App name: **Specify a unique name**.

    - Subscription: **Production**

    - Resource Group: **ContosoFinanceWeb**

    - Hosting Plan: **Consumption Plan**

    - Location: **local**

    - Runtime Stack: **.NET Core**

    - Storage Account: **(Use existing) contosofinance**

    **Note:** Select the **Production** subscription before the other values. 

4. Using the Azure Stack Hub portal, open the Function App you just created, select **Functions** on the left, then **New function**.

    ![The New function button is selected in the Function Apps blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image142.png "Function Apps blade")

5. Scroll and locate the **Queue trigger** box and select **C\#**.

    ![C\# is selected on the Queue trigger page.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image143.png "Queue trigger page")

6. Complete the **New function** blade using the following inputs and select **Create**.

    - Language: **C\#**

    - Name: **QueueTriggerGeneratePDF**

    - Queue name: **receiptgenerator (it must be this exact text)**

    ![Fields in the New Function blade are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image144.png "New Function blade")

7. Expand the **View files** area on the far right of the code window, and select **Upload**.

    ![The view files section can be displayed on the far right.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image145.png "View files")
    
    ![In the View files section, the Upload link is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image146.png "View files")

8. Upload the following files from your LABVM in the **C:\\HoL\\contosofinancefunction-master** folder:

    - CreatePdfReport.csx

    - Project.json

    - run.csx

    - StorageMethods.csx

    - ViewModels.csx

9. Select **run.csx** to refresh the code editor.

   ![Under View files, run.csx is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image147.png "View files")

10. Select the **name of your function app** followed by **Platform features**, followed by **Configuration**.

   ![The previously mentioned settings are selected in the Function Apps blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image148.png "Function Apps blade")

11. In the **Application settings** section, select **+ New application setting** to add a storage connection. This storage account will be used to write the PDFs to blob storage. Enter the following values then select **OK**. 

   - Name: **contosofinancestorage (It must be this name exactly)**

   - Value: **Paste the connection string for the storage account created earlier in the lab**.

12. Locate **Connection strings** section below **Application settings** in the Azure Stack Hub User portal, select **+ New connection string** and add a new connection string with the following values then select **OK**. 

   - Name: **ContosoFinance (must match exactly -- case sensitive)**

   - Value: **Enter the Connection String for the SQL Database in Azure Stack Hub you created earlier in this lab**.

   - Type: **SQLAzure**

     > **Note:** You may receive an error message that says *value is a required property on all connection string*. This can be ignored.

13. Select **Save** on the **Configuration** page.

   ![The Save button is selected in the Function Apps blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image150.png "Function Apps blade")

## Exercise 5: Deploy Contoso Finance Admin website

Duration: 30 minutes

In this exercise, you will provision the admin website to be used by employees to review applications submitted.

### Task 1: Provision the Contoso Finance Admin Web App

1. In the Azure Stack Hub User portal, select **+ Create new resource -> Web + Mobile -> Web App**.

2. Select the **Production** subscription. Specify a unique name for the Web App URL, ensure the **same App Service Plan** as well as the **ContosoFinanceWeb** resource group you have used throughout the lab are selected then select **Create**.

    ![Fields in the Create blade are set to the previously defined settings.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image152.png "Create blade")

3. Navigate to the **App Service** blade for the Admin app recently provisioned.

    ![The Contosofinanceadmin option screenshot.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image153.png "App Service blade")

4. On the **App Service** blade, select **Configuration** under **Settings** on the left.

5. Scroll down and locate the **Connection strings** section.

    ![Screenshot of the App Services blade.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image155.png "App Services blade")

6. Locate **Connection Strings** below App settings in the Azure Stack Hub User portal add a new **Connection String** with the following values then select **OK**.

    - Name: **ContosoFinance**

    - Value: **Enter the Connection String for the SQL Database in Azure Stack Hub you created earlier in this lab**.

    - Type: **SQLAzure**

    **Note:** You may receive an error message that says *value is a required property on all connection string*. This can be ignored.

7. Select **Save** on the **Configuration** page. 

### Task 2: Deploy the call center admin Web App from Visual Studio

1. From within the web app blade, select **Deployment options (Classic)** under **Deployments** on the left.

    ![Under Deployment, Deployment options is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image125.png "Deployment options")

2. Select **Choose Source**, and then **External Repository**.

    ![In the Deployment option blade, Choose source is selected. In the Choose a source blade, External Repository is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image126.png "Deployment options")

3. Paste the following as the **Repository URL** and select **OK**.

    ```
    https://github.com/opsgility/contosofinanceadmin
    ```

4. Select the Deployment options button and monitor until the application is deployed.

5. On the **Overview** tab, select the URL of the web app. This should automatically open another browser window tab displaying the web app.

6. Since the application is fully deployed, you will want to see it work end to end. Open the URL for the contosofinanceweb Web App if you haven't already. The application will load in the browser.

    ![Screenshot of the Contosofinanceweb Web App URL.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image157.png "Contosofinanceweb Web App URL")

    ![Web App webpage screenshot.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image158.png "Web App")

7. Notice how the API application loaded the Today's Offers area. Select through to one of the products and add it to your cart.

    ![Screenshot of the Today\'s Offers webpage area.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image159.png "Today's Offers")

8. Select **Apply**.

    ![Under Product Name, the Apply button is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image160.png "Product Name")

9. Complete the Application and select **Continue** followed by **Complete Application** on the confirmation screen.

   ![Screenshot of the Contoso Finance application.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image161.png "Contoso Finance application")

   ![Screenshot of the Complete Application button.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image162.png "Complete Application")

10. Now, to act as an employee, open the Admin application to see the submitted applications. Select **Details** on one of the applications.

   ![The URL link is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image163.png "URL link")

   ![Screenshot of the Contoso webpage Contoso Finance Admin section.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image164.png "Contoso webpage")

11. Notice the details of the application. This data is stored in SQL DB running in PaaS on Azure Stack Hub. Select **Download application to view a sample PDF**.

   ![Under Application Details, the Download application link is selected.](images-migrate/Hands-onlabstep-by-step-AzureStackimages/media/image165.png "Application Details")

## After the hands-on lab 

Duration: 10 minutes

In this final task you will clean up the Azure Resources that you have create for the hands-on lab. This task is optional.

1.  If provisioned using the Azure Stack Hub Development Kit in an Azure VM, delete the resource group your Azure Stack Hub Host VM is running in.

2.  If running on your own Development Kit, delete all the resource groups from the Azure Stack Hub portal that you created during the execution of this lab.

You should follow all steps provided *after* attending the Hands-on lab.


