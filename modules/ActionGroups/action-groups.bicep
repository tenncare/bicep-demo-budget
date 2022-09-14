@description('Unique name (within the Resource Group) for the Normal Action group.')
param normalActionGroupName string = 'Normal-ActionGroup'

@description('Short name (maximum 12 characters) for the Normal Action group.')
param normalActionGroupShortName string = 'Normal'

@description('Array of email receivers (maximum 4 addresses) for the Normal Action group.')
param normalActionGroupEmailReceivers array = [
  {
    name: 'Michael Crawford'
    emailAddress: 'michael.crawford@neudesic.com'
  }
  {
    name: 'Michael Crawford (MJC Consulting)'
    emailAddress: 'mcrawford@mjcconsulting.com'
  }
]

@description('Unique name (within the Resource Group) for the Urgent Action group.')
param urgentActionGroupName string = 'Urgent-ActionGroup'

@description('Short name (maximum 12 characters) for the Urgent Action group.')
param urgentActionGroupShortName string

@description('Array of email receivers (maximum 4 addresses) for the Urgent Action group.')
param urgentActionGroupEmailReceivers array = [
  {
    name: 'Michael Crawford'
    emailAddress: 'michael.crawford@neudesic.com'
  }
  {
    name: 'Michael Crawford (MJC Consulting)'
    emailAddress: 'mcrawford@mjcconsulting.com'
  }
]

@description('Array of SMS receivers (maximum 4 addresses) for the Urgent Action group.')
param urgentActionGroupSMSReceivers array = [
  {
    name: 'Michael Crawford'
    countryCode: '1'
    phoneNumber: '4156525483'
  }
]

resource normalActionGroupName_resource 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: normalActionGroupName
  location: 'Global'
  properties: {
    groupShortName: normalActionGroupShortName
    enabled: true
    emailReceivers: [for item in normalActionGroupEmailReceivers: {
      name: item.name
      emailAddress: item.emailAddress
      useCommonAlertSchema: true
    }]
  }
}

resource urgentActionGroupName_resource 'Microsoft.Insights/actionGroups@2021-09-01' = {
  name: urgentActionGroupName
  location: 'Global'
  properties: {
    groupShortName: urgentActionGroupShortName
    enabled: true
    emailReceivers: [for item in urgentActionGroupEmailReceivers: {
      name: item.name
      emailAddress: item.emailAddress
      useCommonAlertSchema: true
    }]
    smsReceivers: [for item in urgentActionGroupSMSReceivers: {
      name: item.name
      countryCode: item.countryCode
      phoneNumber: item.phoneNumber
    }]
  }
}

output normalActionGroupId string = normalActionGroupName_resource.id
output urgentActionGroupId string = urgentActionGroupName_resource.id
