#
# Script to create a Subscription Budget
#

# Deploy Resources
New-AzSubscriptionDeployment -Name "SubscriptionBudgetDeployment" `
                             -Location "West US 2" `
                             -TemplateFile subscription-budget.bicep `
                             -TemplateParameterFile subscription-budget.parameters.json

# Confirm Resources
Get-AzSubscriptionDeployment -Name "SubscriptionBudgetDeployment"
