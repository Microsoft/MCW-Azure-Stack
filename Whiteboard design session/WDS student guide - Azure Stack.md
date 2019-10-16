![](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/master/Media/ms-cloud-workshop.png "Microsoft Cloud Workshops")

<div class="MCWHeader1">
Azure Stack
</div>

<div class="MCWHeader2">
 Whiteboard design session student guide
</div>

<div class="MCWHeader3">
June 2019
</div>

Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2019 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**

<!-- TOC -->

- [Azure Stack whiteboard design session student guide](#azure-stack-whiteboard-design-session-student-guide)
  - [Abstract and learning objectives](#abstract-and-learning-objectives)
  - [Step 1: Review the customer case study](#step-1-review-the-customer-case-study)
    - [Customer situation](#customer-situation)
    - [Customer needs](#customer-needs)
    - [Customer objections](#customer-objections)
    - [Infographic for common scenarios](#infographic-for-common-scenarios)
  - [Step 2: Design a proof of concept solution](#step-2-design-a-proof-of-concept-solution)
  - [Step 3: Present the solution](#step-3-present-the-solution)
  - [Wrap-up](#wrap-up)
  - [Additional references](#additional-references)

<!-- /TOC -->

#  Azure Stack whiteboard design session student guide

## Abstract and learning objectives 

In this whiteboard design session, you will work with a group to design a hybrid cloud architecture using a combination of the Azure public cloud and Azure Stack. This functional architecture will enable customers to leverage their investments in Azure as a "cloud platform," rather than Azure as a "place."

At the end of the session, you will be able to determine which systems are good candidates for the Azure public cloud, and which are better suited on Azure Stack.

## Step 1: Review the customer case study 

**Outcome**

Analyze your customer's needs.

Timeframe: 15 minutes

Directions: With all participants in the session, the facilitator/SME presents an overview of the customer case study along with technical tips.

1.  Meet your table participants and trainer.

2.  Read all of the directions for steps 1-3 in the student guide.

3.  As a table team, review the following customer case study.

### Customer situation

Contoso Finance is one of the largest banks in the United States with a significant amount of their revenue coming from their residential mortgage business. Their mortgage business is headquartered in Dallas, Texas. During a meeting with the newly appointed CTO Doreen Newton, the IT team learned that Contoso is shifting to a cloud first strategy after seeing firsthand the advantages of the cloud from Doreen's previous role leading her prior company through a digital transformation. Her message, "I have seen how applications and infrastructures are deployed and run using Microsoft Azure with both PaaS and IaaS services. These capabilities can transform Contoso with more agility and long-term cost effectiveness." resonated with other members of the IT organization.

Contoso's current systems run in their Dallas based datacenter hosted in VMWare based virtual machines. One of the primary applications they are interested in modernizing to take advantage of the cloud is their consumer facing mortgage application. This application is responsible for new applications and consumer access to their current mortgage information. The mortgage app is hosted in a public facing website on Microsoft Internet Information Server (IIS) with a backend database using SQL Server 2012. The application has several modules that run as Windows Services. These modules are responsible for running credit checks and generating PDFs for transactions. The application uses Microsoft Message Queue (MSMQ) for interacting between modules. The application also allows customers to download several publicly accessible PDF files that are brochures for their products.

During the planning stages, Contoso realized they would not be able to retain their customer data in US based Azure regions due to corporate compliance policies and regulatory issues. "This was a cause for great concern, as this means Contoso may not be able to move to cloud-based services as fast as we initially envisioned" says Max Rubin VP of Network Engineering. Doreen Newton took on the challenge to investigate alternatives to allow Contoso to proceed with getting the benefits of the cloud while not breaking rules for corporate compliance.

As a result, Contoso has engaged a Microsoft Cloud Partner and Service Provider FusionTomo (FT), to help them design a solution using Azure technologies. FT is a full-service hosting provider in North America certified to deliver Azure services with connectivity solutions and partnerships to provide ExpressRoute and other telecom services. They have datacenters located in Denver, London, Las Vegas, Dallas and Hong Kong SAR.

Contoso has expressed to FT the need to embrace Microsoft Azure technologies as well as technologies that will help their organization with a more agile continuous integration and continuous deployment model for application deployment.

With the goals in mind, Contoso has challenged FT to help use their mortgage application as the first application to be used with Microsoft Azure.

![The Contoso Dallas Data Center diagram shows the flow between Contoso Mortgage customers and Contoso's web servers, application servers, and SQL servers.](images/Whiteboarddesignsessiontrainerguide-AzureStackimages/media/image2.jpg)

### Customer needs 

Contoso is looking for FT to provide the following for their expansion into North America:

1.  Design a hybrid-cloud architecture that is native Azure end-to-end without the need for hosting the application in a Contoso owned datacenter.

2.  The design should ensure that customer data is not stored in the Azure Cloud while also allowing future applications to be easily deployed in Azure with access to custom data regardless of where they are deployed.

3.  Deploy the application in a secure manner as to allow for the frontend applications to access the backend customer data.

4.  Establish direct connectivity from the new regional headquarters in Dallas to the deployments. This will allow communication with existing systems and reporting until the rest of Contoso's services are moved to Azure in the future.

5.  Allow for a consistent application deployment model using Azure ARM templates and CI/CD.

6.  Detail the taxonomy that will be leveraged for the hybrid-cloud including the Resource Providers (RP) This includes tenants, regions, subscriptions, offers, plans, services and quota.

### Customer objections 

1.  The Mortgage SQL DB cannot be hosted in the public cloud.

2.  Contoso staff is already stretched thin, so minimizing patching of systems and day-to-day management is very important.

3.  The developer team acknowledges that the existing application architecture is designed for running on Windows Virtual Machines, but PaaS is the future they envision. How can they move this application forward?

4.  One of the key reasons Contoso wants to go to the cloud is to take advantage of tools and services for automated deployments and application development. Will Azure Stack make it to where we must use two skillsets?

### Infographic for common scenarios

![In the Infographic for Common scenarios, Microsoft Azure (public) is connected to the Microsoft Azure Stoack (private / hosted) through Developers and IT.](images/Whiteboarddesignsessiontrainerguide-AzureStackimages/media/image3.png)

## Step 2: Design a proof of concept solution

**Outcome**

Design a solution and prepare to present the solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 60 minutes

**Business needs**

Directions:  With all participants at your table, answer the following questions and list the answers on a flip chart:

1.  Who should you present this solution to? Who is your target customer audience? Who are the decision makers?

2.  What customer business needs do you need to address with your solution?

**Design**

Directions: With all participants at your table, respond to the following questions on a flip chart:

Design a hybrid-cloud architecture using Azure services that will make up the implementation for Contoso.

1.  Identify the overall application design you would propose for modernizing their existing application into Azure.

2.  List the services and components that will be deployed to Azure public cloud. For each, provide their basic function in the system. Determine which Azure Region will be best suited for the deployment.

3.  List the services and components that will be deployed to Azure Stack Cloud. For each, provide their basic function in the system.

Identify how applications such as the Mortgage App and other infrastructure workloads could be deployed in a consistent manner between Azure Public and Azure Stack.

Plan and Document Azure Stack taxonomy for this deployment.

1.  Document each of the following areas of the taxonomy with details on how it will be setup:

    -   Cloud Operator

    -   Region

    -   Tenant

    -   Subscriptions

    -   Plans and quotas

    -   Offers

    -   Services / Resource Providers

2.  Diagram your taxonomy.

Create a network design.

1.  Design network connectivity between the Contoso Regional HQ in Dallas to Azure and Azure Stack that will allow future applications to be deployed in the public cloud or Azure Stack but still provide connectivity to customer or On-Premises data.

**Prepare**

Directions: With all participants at your table:

1.  Identify any customer needs that are not addressed with the proposed solution.

2.  Identify the benefits of your solution.

3.  Determine how you will respond to the customer's objections.

Prepare a 15-minute chalk-talk style presentation to the customer.

## Step 3: Present the solution

**Outcome**

Present a solution to the target customer audience in a 15-minute chalk-talk format.

Timeframe: 30 minutes

**Presentation**

Directions:

1.  Pair with another table.

2.  One table is the Microsoft team and the other table is the customer.

3.  The Microsoft team presents their proposed solution to the customer.

4.  The customer makes one of the objections from the list of objections.

5.  The Microsoft team responds to the objection.

6.  The customer team gives feedback to the Microsoft team.

7.  Tables switch roles and repeat Steps 2-6.

##  Wrap-up 

Timeframe: 15 minutes

Directions: Tables reconvene with the larger group to hear the facilitator/SME share the preferred solution for the case study.

##  Additional references
|    |            |
|----------|:-------------:|
| **Description** | **Links** |
| Azure Stack overview  | <https://azure.microsoft.com/en-us/overview/azure-stack/> |
| Azure Stack use cases | <https://azure.microsoft.com/en-us/overview/azure-stack/use-cases/> |
| Azure Stack features | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-key-features> |
| Azure Stack planning considerations | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-planning-considerations> |
| Azure Stack documentation | <https://docs.microsoft.com/en-us/azure/azure-stack/> |
| Azure Stack Operator documentation | <https://docs.microsoft.com/en-us/azure/azure-stack/> |
| Azure Stack networking | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-network-overview/> |
| Azure Stack to Azure Global VPN | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-connect-vpn> |
| Register Azure Stack with your subscription | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-register> |
| Deploy the Azure App Service resource provider | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-app-service-deploy> |
| Deploy the Azure Stack SQL resource provider | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-sql-resource-provider-deploy#deploy-the-resource-provider> |
| Deploy apps to Azure and Azure Stack | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-solution-pipeline> |
| White paper | <https://azure.microsoft.com/en-us/resources/azure-stack-an-extension-of-azure/> |
| PowerShell for Azure Stack | <https://docs.microsoft.com/en-us/azure/azure-stack/user/azure-stack-powershell-install> |
| Azure Stack marketplace | <https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-marketplace-azure-items> |
