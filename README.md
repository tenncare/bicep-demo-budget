# Bicep Demo Budget
A demo of creating a budget for a subscription using bicep

## Procedures

### Get Billing Account Info

1. Get Billing Account Name

    ```PowerShell
    $BillingAccountName = (Get-AzBillingAccount).Name[0]
    ```

1. Get Billing Profile Name

    ```PowerShell
    $BillingProfileName = (Get-AzBillingProfile -BillingAccountName $BillingAccountName).Name
    ```

1. Get Billing Invoice Section Name

    ```PowerShell
    $InvoiceSectionName = (Get-AzInvoiceSection -BillingAccountName $BillingAccountName `
                                                -BillingProfileName $BillingProfileName).Name
    ```

1. Construct Billing Scope for new Subscription

    ```PowerShell
    $BillingScope = "/providers/Microsoft.Billing/billingAccounts/$BillingAccountName/billingProfiles/$BillingProfileName/invoiceSections/$InvoiceSectionName"
    ```

1. Create New Subscription for Production

    ```PowerShell
    $Company = "Neudesic"
    $User = "MCrawford"
    New-AzSubscriptionAlias -AliasName "$Company-$User-Production" `
                            -SubscriptionName "$Company-$User-Production" `
                            -BillingScope $BillingScope `
                            -Workload "Production"
    ```

1. Create New Subscription for Development
    This didn't work - with Bad Request, not enough details to know what's wrong here, so skipping this step.

    ```PowerShell
    $Company = "Neudesic"
    $User = "MCrawford"
    New-AzSubscriptionAlias -AliasName "$Company-$User-Development" `
                            -SubscriptionName "$Company-$User-Development" `
                            -BillingScope $BillingScope `
                            -Workload "NonProduction"
    ```

1. Show Subscriptions associated with Account

    ```PowerShell
    Get-AzSubscription
    ```

    Output

    ```text
    Name                                    Id                                   TenantId                             State
    ----                                    --                                   --------                             -----
    Visual Studio Professional Subscription d59b1f4a-xxxx-xxxx-xxxx-xxxxxxxxxxxx 687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx Enabled
    Neudesic-MCrawford-Sandbox              43969857-xxxx-xxxx-xxxx-xxxxxxxxxxxx 687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx Enabled
    Neudesic-MCrawford-Production           9562d775-xxxx-xxxx-xxxx-xxxxxxxxxxxx 687f51c3-xxxx-xxxx-xxxx-xxxxxxxxxxxx Enabled
    ```

1. Show Current Subscription

    ```PowerShell
    (Get-AzContext).Name.split()[0]
    ```

1. Set Current Subscription

    In this example, we set the context to the Subscription named "Neudesic-MCrawford-Sandbox"

    ```PowerShell
    $Company = "Neudesic"
    $User = "MCrawford"
    $Tenant = (Get-AzTenant | Where-Object {$_.Name -eq $Company}).Id
    $Subscription = (Get-AzSubscription -SubscriptionName "$Company-$User-Sandbox" `
                                        -TenantId $Tenant).Id
    Set-AzContext -Subscription $Subscription
    ```


## Links
- [Azure Bicep multiple scopes in template](https://stackoverflow.com/questions/69696317/azure-bicep-multiple-scopes-in-template)
