**Terraform Code to deploy 3-tier- Application on Azure** 

- What is three-tier architecture?

  Three-tier architecture is a well-established software application architecture that organizes applications into three logical and physical computing tiers: the presentation tier, or user interface; the application tier, where data is processed; and the data tier, where the data associated with the application is stored and managed.

# Terraform Sample for Azure PaaS (WebApp & MS SQL)

One of challenges for provisioning PaaS services is deploying applications since `terraform` does not provide native way of deploying apps (e.g, Web App and setup MS SQL). This sample terraform shows how to deploy and configure webapps and MS SQL using `terraform`.



## Provision services

This terraform sample creates following Azure services

- MS SQL (SQL Server & Database) for data layer
- Web App with App Service plan for backend layer
- Application Gateway for fronend layer



## Config app

- Setup SQL Firewall (Enable Accessing Azure Services) and client PC
- Setup MSSQL using [sqlcmd](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15)
- Store `sql connections string` in Web App _app_settings_ 

## Test app

```
curl https://hostname.azurewebsites.net/api/events

curl -X POST https://hostname.azurewebsites.net/api/events -H "Content-Type: application/json" -d '{"message": "test"}'

curl https://hostname.azurewebsites.net/api/events
```
