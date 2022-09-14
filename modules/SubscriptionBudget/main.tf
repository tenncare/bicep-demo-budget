provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

resource "azurerm_consumption_budget_subscription" "budget" {
  name            = var.budget_name
  subscription_id = data.azurerm_subscription.current.id

  amount     = var.amount
  time_grain = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  notification {
    enabled   = true
    threshold = var.actual_thresholds[0]
    operator  = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = var.contact_emails
  }

  notification {
    enabled   = true
    threshold = var.actual_thresholds[1]
    operator  = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = var.contact_emails
  }

  notification {
    enabled   = true
    threshold = var.actual_thresholds[2]
    operator  = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = var.contact_emails
  }
  notification {
    enabled   = true
    threshold = var.actual_thresholds[3]
    operator  = "GreaterThan"
    threshold_type = "Actual"

    contact_emails = var.contact_emails
  }
  /*
  notification {
    enabled   = true
    threshold = var.actual_thresholds[4]
    operator  = "GreaterThan"
    threshold_type = "Actual"
  }
  */
  notification {
    enabled   = true
    threshold = var.forecasted_thresholds[0]
    operator  = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_emails
  }
  /*
  notification {
    enabled   = true
    threshold = var.forecasted_thresholds[1]
    operator  = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_emails
  }

  notification {
    enabled   = true
    threshold = var.forecasted_thresholds[2]
    operator  = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_emails
  }

  notification {
    enabled   = true
    threshold = var.forecasted_thresholds[3]
    operator  = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_emails
  }

  notification {
    enabled   = true
    threshold = var.forecasted_thresholds[4]
    operator  = "GreaterThan"
    threshold_type = "Forecasted"

    contact_emails = var.contact_emails
  }
  */
}
