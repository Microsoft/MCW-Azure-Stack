# Azure Stack setup

## Requirements

-   Microsoft Azure subscription 


## Before the hands-on lab

Duration: 6-7 hours

To execute this lab, you will have two options: you can use your own Azure Stack Development Kit that is already installed, or you will need to follow the instructions below to setup your own in Microsoft Azure using nested virtual machines.

For help with installation of the Azure Stack Development Kit, review the following article: <https://azure.microsoft.com/en-us/overview/azure-stack/development-kit>.

### Task 1: Create a virtual machine to execute the lab

1.  Launch a browser, and navigate to <https://github.com/opsgility/cw-azure-stack> and click the **Deploy to Azure** button.

2.  Specify a resource group name **AzureStack** and deploy the template.

**NOTE:** Please wait for the virtual machine to be provisioned prior to moving to the next step.

3.  After the VM is provisioned, **connect** to establish a new Remote Desktop Session.

4.  Depending on your Remote Desktop Protocol Client and browser configuration, you will either be prompted to open an RDP file, or you will need to download it and then open it separately to connect.

5.  Log in with the credentials specified during creation:

    -   User: **administrator**

    -   Password: **demo\@pass123**

6.  You will be presented with a Remote Desktop Connection warning because of a certificate trust issue. Click **Yes** to continue with the connection.

    ![Screenshot of the Remote Desktop Connection warning dialog box.](images/Setup/image3.png "Remote Desktop Connection dialog box")

7.  When logging on for the first time, you will see a prompt on the right asking about network discovery. Click **No**.

    ![Screenshot of the Network discovery prompt, with the No button selected.](images/Setup/image4.png "Network discovery prompt")

8.  Notice that Server Manager opens by default. On the left, click **Local Server**.

![Local Server is selected in the Server Manager menu.](images/Setup/image5.png "Server Manager menu")

9.  On the right side of the pane, click **On** by **IE Enhanced Security Configuration**.

    ![In the Essentials section, IE Enhanced Security Configuration is set to On.](images/Setup/image6.png "Essentials section")

10. Change to **Off** for Administrators and click **OK**.

    ![In the Internet Explorer Enhanced Security Configuration dialog box, Administrators is set to Off.](images/Setup/image7.png "Internet Explorer Enhanced Security Configuration dialog box")

11. Launch Internet Explorer, and right click at the top of the browser and check Menu bar. Then open Tools -\> Internet Options -\> Security -\> Custom Level. Change File download to **Enable**.

    ![Under Downloads, File download is set to Enable.](images/Setup/image8.png "Downloads")

### Task 2: Install the Azure Stack Developer Kit

1.  Launch an elevated PowerShell console and execute the following commands:
    ```
    cd C:\AzureStackOnAzureVM

    .\Install-ASDK.ps1
    ```

When prompted enter:

-   Password for administrator: **demo\@pass123**

-   Enter Azure AD User: Specify your Azure subscription user account

-   Select ASK Version **1803** and press **C** to continue

2.  It will take up to 6 hours to successfully install the Azure Stack developer kit.

3.  After the installation reboots the virtual machine, login to the AzSHost-1 virtual machine using RDP to monitor the installation progress. You will need to use the account:

    -   Username: **azurestack.local\\azurestackadmin**

    -   Password: **\[your Azure Stack password\]**

4.  Once connected open Server Manager. On the left, click **Local Server**.

### Task 3: Install PowerShell for Azure Stack

1.  Using your LABVM connect to your Azure Stack Host using RDP. You will need to use the account:

    -   Username: **azurestack.local\\azurestackadmin**

    -   Password: **\[your Azure Stack password\]**

2.  Open PowerShell ISE as an administrator. You will need to **right-click the link** on the start menu, click **More**, and **Run as administrator**.

    ![The Windows PowerShell ISE right-click sub-menus display.](images/Setup/image9.png "Windows PowerShell ISE sub-menus")

3.  Click **Yes** when prompted.

    ![User Account Control is set to Yes.](images/Setup/image10.png "User Account Control")

4.  On the PowerShell ISE window, open the script pane by clicking the **\>** mark next to the word **Script.**

    ![Screenshot of the PowerShell Administrators window with the Script down arrow called out.](images/Setup/image11.png "PowerShell Administrators window")

    5.  Execute the following command to trust the PSGallery repository:
    ```
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    ```

6.  Next, execute the following command to remove any previous versions of Azure PowerShell:

    ```
    Get-Module -ListAvailable | where-Object {$_.Name -like "Azure*"} | Uninstall-Module
    ```

    > Note: You may see several errors, you can ignore these.

7.  Remove any folders in the following folder that begin with Azure (if any).
    ```
    C:\Users\AzureStackAdmin\Documents\WindowsPowerShell\Modules
    ```

8.  Finally, execute the following command to install the Azure Stack PowerShell cmdlets:
    ```
    # Install the AzureRM.Bootstrapper module. Select Yes when prompted to install NuGet

    Install-Module -Name AzureRm.BootStrapper

    # Install and import the API Version Profile required by Azure Stack into the current PowerShell session.

    Use-AzureRmProfile -Profile 2017-03-09-profile -Force

    Install-Module -Name AzureStack -RequiredVersion 1.2.11
    ```

### Task 4: Download the Latest Azure Stack Tools

1.  Using the previous elevated PowerShell console execute the following commands to download and extract the Azure Stack tools from GitHub
    ```
    # Change directory to the root directory.

    cd \

    # Download the tools archive.

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip

    # Expand the downloaded files.

    expand-archive master.zip -DestinationPath .  -Force

    # Change to the tools directory.

    cd AzureStack-Tools-master
    ```
    
### Task 5: Register Azure Stack with Azure AD

In this task, execute all the commands from an elevated PowerShell console on the Azure Stack host.

1.  CD to the registration folder of the AzureStack-Tools-master folder
    ```
    CD C:\AzureStack-Tools-master\Registration
    ```

2.  Execute the following command to login:
    ```
    Add-AzureRmAccount -EnvironmentName AzureCloud
    ```

3.  Next, execute the following command to view the Azure subscriptions available:
    ```
    Get-AzureRmSubscription
    ```

4.  Next, execute the following command and specify the subscription ID you want to register Azure Stack to.
    ```
    Select-AzureRmSubscription -SubscriptionId [your subscription id here]
    ```

5.  Register the Azure Stack resource provider with your subscription by executing the following command:
    ```
    Register-AzureRmResourceProvider -ProviderNamespace Microsoft.AzureStack
    ```

6.  Next, execute the following commands to register your Azure Stack installation. When prompted, login with the **azurestack.local\\azurestackadmin** account.
    ```
    Import-Module .\RegisterWithAzure.psm1

    $AzureContext = Get-AzureRmContext

    $CloudAdminCred = Get-Credential

    Set-AzsRegistration `
        -PrivilegedEndpointCredential $CloudAdminCred `
        -PrivilegedEndpoint Azs-ERCS01 `
        -BillingModel Development

    ```

7.  Open the Azure portal and navigate to your resource groups. Notice a new resource group named **azurestack** was created. If you open this resource group, you will see the registration resource.

    ![Screenshot of the Resource group blade.](images/Setup/image12.png "Resource group blade")

8.  To verify the registration was successful on the Azure Stack Host, navigate to the admin portal at <http://adminportal.local.azurestack.external>. Sign in using your Azure AD credentials used during the Azure Stack Development Kit installation.

### Task 6: Download VM Images to Azure Stack Marketplace

In this task, you will download the following images and artifacts which are needed for the resource providers installed later:

-   SQL Server 2017 on Windows Server 2016 Image

-   SQL IaaS Extension

-   Windows Server 2016 -- Server Core

-   Windows Server 2016 Data Center

1.  From within the Azure Stack Admin portal, click **Marketplace management**.

    ![Marketplace management is selected in the Azure Stack Admin portal.](images/Setup/image13.png "Azure Stack Admin portal")

2.  You should see the following message: **You have no items downloaded to your Azure Stack marketplace yet. Click "Add from Azure" to add items.**

    ![In the Marketplace management section, an arrow points to the message.](images/Setup/image14.png "Marketplace management section")

3.  Click **+Add** from Azure and if you see the Marketplace Items, you have registered successfully.

    ![Under Marketplace management, the Add from Azure button is called out.](images/Setup/image15.png "Marketplace management section")

    ![Marketplace items display in the Marketplace management section.](images/Setup/image16.png "Add from Azure section")

4.  From the Marketplace management area of the Azure Stack Admin portal, select the **Developer edition of SQL Server 2017 on Windows Server 2016**.

    ![Screenshot of the Free SQL Server License: SQL Server 2017 Developer on Windows Server 2016 option.](images/Setup/image17.png "Free SQL Server License option")

5.  Click **Download**.

    ![The Free SQL Server License: SQL Server 2017 Developer on Windows Server 2016 page displays with the Download button selected.](images/Setup/image18.png "Free SQL Server License Download page")

6.  A notification will pop-up notifying you the product is being downloaded to Azure Stack.

    ![Screenshot of the Downloading product notification.](images/Setup/image19.png "Downloading notification")

7.  In the Add from Azure search bar, type SQL IaaS, and press enter. The SQL IaaS Extension will appear in the search results. Click its name.

    ![In the Add from Azure section, SQL IaaS is in the search field, and in the results, SQL IaaS Extension is selected.](images/Setup/image20.png "Add from Azure section")

8.  When the SQL IaaS Extension appears, click **Download**.

    ![The Download button is selected on the SQL IaaS Extension page.](images/Setup/image21.png "SQL IaaS Extension page")

9.  A notification will pop-up notifying you the product is being downloaded to Azure Stack.

    ![Screenshot of the Downloading product notification.](images/Setup/image22.png "Downloading product notification")

10. In the Add from Azure search bar, type **Windows Server**, and press **enter**.

-   Download **both** of the following images:

    -   Windows Server 2016 Datacenter

    -   Windows Server 2016 Datacenter - Server Core

8.  Once the products are downloaded, you will receive a notification.

    ![Screenshot of the Downloading product finished notification.](images/Setup/image23.png "Downloading product finished notification")

**Note:** These downloads will take some time depending upon your Azure Stack connectivity. Wait until they complete before proceeding to the next task.
