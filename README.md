# Azure Stack

Contoso Finance is one of the largest banks in the United States with a significant amount of their revenue coming from their residential mortgage business. As part of Contoso's shift to a cloud first strategy they planning to migrate their loan web applications to a hybrid cloud solution. During the planning stages, Contoso realized they would not be able to retain their customer data in US based Azure regions due to corporate compliance policies and regulatory issues. They have selected Azure Stack as the deployment method to take advantage of Azure technologies while still maintaining compliance.

October 2019

## Target audience

- Infrastructure Engineer
- System Administrator
- Cloud Engineer

## Abstracts

### Workshop

In this workshop, you will learn how to design and manage a hybrid cloud architecture using a combination of the Azure public cloud and Azure Stack. This functional architecture will enable customers to leverage their investments in Azure as a "cloud platform," rather than Azure as a "place." You will learn to determine which systems are good candidates for the Azure public cloud and which are better suited on Azure Stack.

At the end of this workshop, you will be better able to recommend, design, and manage hybrid cloud systems that leverage one application and deployment model, Azure.

In addition, you will learn to understand when the Azure public cloud versus Azure Stack is appropriate based on customer requirements, describe possible integrations between Azure public cloud solutions and Azure Stack, understand the taxonomy of Azure Stack (tenants, regions, subscriptions, offers, plans, services and quotas), describe the resource providers that are available for use with Azure Stack, design and deploy hybrid connectivity between Azure public cloud and Azure Stack, as well as perform the most common Azure Stack management and maintenance operational tasks.

### Whiteboard design session

In this whiteboard design session, you will work with a group to design a hybrid cloud architecture using a combination of the Azure public cloud and Azure Stack. This functional architecture will enable customers to leverage their investments in Azure as a "cloud platform," rather than Azure as a "place."

At the end of the session, you will be able to determine which systems are good candidates for the Azure public cloud, and which are better suited on Azure Stack.

### Hands-on lab

The content consists of two hands on labs, with their respective prerequisites. 

The first hands-on lab involves starts with deploying the Azure Stack Development Kit, deploying the SQL Database and Azure App Service resource providers, as well as downloading several virtual machine images from the Azure Stack Marketplace. From there, you will implement a full taxonomy in Azure Stack consisting of a region, subscription, plan, offer, and quotas. After Azure Stack is configured, you will then deploy Azure SQL Database, Web and API apps and then deploy the Contoso application.

The second hands-on lab focuses on the Azure Stack operational tasks. In this case, you will also start with deploying the Azure Stack Development Kit, but the subsequent steps will differ. First, you will install the Azure Stack tools. You will subsequently rely on them to create and publish a custom Azure Marketplace item as well as to implement multi-tenant topology by provisioning another Azure Active Directory tenant and adding it to the existing Azure Stack environment. Once that is completed, you will set up delegation by using the delegated provider model and Azure Stack Role-Based Access Control (RBAC). You will conclude this lab by carrying out common Azure Stack maintenance tasks, including log collection (via Privileged Endpoint) and infrastructure backup (by using the Azure Stack Admin portal).

At the end of these hands-on labs, you will be better able to deploy and manage solutions running on Azure Stack.

## Azure services and related products
- Azure Stack
- Azure App Services
- Azure SQL Database
- Azure Virtual Machines
- Azure Functions

## Related references
- [MCW](https://microsoftcloudworkshop.com)

## Help & Support

We welcome feedback and comments from Microsoft SMEs & learning partners who deliver MCWs.  

***Having trouble?***
- First, verify you have followed all written lab instructions (including the Before the Hands-on lab document).
- Next, submit an issue with a detailed description of the problem.
- Do not submit pull requests. Our content authors will make all changes and submit pull requests for approval.    

If you are planning to present a workshop, *review and test the materials early*! We recommend at least two weeks prior.

### Please allow 5 - 10 business days for review and resolution of issues.
