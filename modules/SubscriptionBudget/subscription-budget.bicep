targetScope = 'subscription'

@description('Name of the Budget. It should be unique within the subscription.')
param budgetName string = 'SubscriptionBudget'

@description('The total amount of cost or usage to track with the budget')
param amount int = 50

@description('The time covered by a budget. Tracking of the amount will be reset based on the time grain.')
@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
param timeGrain string = 'Monthly'

@description('The start date must be first of the month in YYYY-MM-DD format. Future start date should not be more than three months. Past start date should be selected within the timegrain preiod.')
param startDate string = utcNow('yyyy-MM-dd')

@description('The end date for the budget in YYYY-MM-DD format. If not provided, we default this to 10 years from the start date.')
param endDate string = '${split(dateTimeAdd(startDate, 'P10Y'), 'T')[0]}'

@description('An array of values to be associated with normal and urgent notifications, when actual costs exceed these values. This should be a list of 5 integers, representing percent of the budget, each between 0 and 1000.')
param actualThresholds array = [
  '25'
  '50'
  '75'
  '100'
  '150'
]

@description('An array of values to be associated with normal and urgent notifications, when forecasted costs exceed these values. This should be a list of 5 integers, representing percent of the budget, each between 0 and 1000.')
param forecastedThresholds array = [
  '25'
  '50'
  '75'
  '100'
  '150'
]

@description('An array of email addresses to be contacted when a notification is to be sent.')
param contactEmails array = [
  'michael.crawford@neudesic.com'
]

resource subscriptionBudget 'Microsoft.Consumption/budgets@2019-10-01' = {
  name: budgetName
  properties: {
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }
    timeGrain: timeGrain
    amount: amount
    category: 'Cost'
    notifications: {
      actualNotification0: {
        enabled: true
        operator: 'GreaterThan'
        threshold: actualThresholds[0]
        thresholdType: 'Actual'
        contactEmails: contactEmails
      }
      actualNotification1: {
        enabled: true
        operator: 'GreaterThan'
        threshold: actualThresholds[1]
        thresholdType: 'Actual'
        contactEmails: contactEmails
      }
      actualNotification2: {
        enabled: true
        operator: 'GreaterThan'
        threshold: actualThresholds[2]
        thresholdType: 'Actual'
        contactEmails: contactEmails
      }
      actualNotification3: {
        enabled: true
        operator: 'GreaterThan'
        threshold: actualThresholds[3]
        thresholdType: 'Actual'
        contactEmails: contactEmails
      }
      actualNotification4: {
        enabled: true
        operator: 'GreaterThan'
        threshold: actualThresholds[4]
        thresholdType: 'Actual'
        contactEmails: contactEmails
      }
      forecastedNotification0: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThresholds[0]
        thresholdType: 'Forecasted'
        contactEmails: contactEmails
      }
      forecastedNotification1: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThresholds[1]
        thresholdType: 'Forecasted'
        contactEmails: contactEmails
      }
      forecastedNotification2: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThresholds[2]
        thresholdType: 'Forecasted'
        contactEmails: contactEmails
      }
      forecastedNotification3: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThresholds[3]
        thresholdType: 'Forecasted'
        contactEmails: contactEmails
      }
      forecastedNotification4: {
        enabled: true
        operator: 'GreaterThan'
        threshold: forecastedThresholds[4]
        thresholdType: 'Forecasted'
        contactEmails: contactEmails
      }
    }
  }
}
