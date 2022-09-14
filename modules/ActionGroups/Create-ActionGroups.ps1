#
# Script to create a Resource Group for Budget related Action Groups, then create the Action Groups
#

# Deploy Resources
New-AzResourceGroup -Name "Budgets" `
                    -Location "West US 2"

New-AzResourceGroupDeployment -Name "ActionGroupsDeployment" `
                              -ResourceGroupName "Budgets" `
                              -TemplateFile action-groups.bicep `
                              -TemplateParameterFile action-groups.parameters.json

# Confirm Resources
Get-AzResourceGroupDeployment -Name "ActionGroupsDeployment" `
                              -ResourceGroupName "Budgets" `
