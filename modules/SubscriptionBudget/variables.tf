variable "location" {
  type          = string
  description   = "Location of the Resource Group containing ActionGroups used for budget notifications."
  default       = "West US 2"

}
variable "budget_name" {
  type          = string
  description   = "Name of the Budget. It should be unique within the subscription."
  default       = "Neudesic-MCrawford-Sandbox-Subscription-Budget"
}

variable "amount" {
  type          = number
  description   = "The total amount of cost or usage to track with the budget."
  default       = 50
}

variable "time_grain" {
  type          = string
  description   = "The time covered by a budget. Tracking of the amount will be reset based on the time grain."
  default       = "Monthly"

  validation {
    condition     = contains(["Monthly", "Quarterly", "Annually"], var.time_grain)
    error_message = "Valid values for var: timeGrain are (Monthly, Quarterly, Annually)."
  }
}

variable "start_date" {
  type          = string
  description   = "The start date must be first of the month in YYYY-MM-DD format. Future start date should not be more than three months. Past start date should be selected within the timegrain preiod."
  default       = "2022-09-01T00:00:00Z"
}

variable "end_date" {
  type          = string
  description   = "The end date for the budget in YYYY-MM-DD format. If not provided, we default this to 10 years from the start date."
  default       = "2032-08-30T00:00:00Z"
}

// Note: This should be 5, but due to a bug in current Terraform, can only do 4 here
variable "actual_thresholds" {
  type          = list(string)
  description   = "An array of values to be associated with normal and urgent notifications, when actual costs exceed these values. This should be a list of 4 integers, representing percent of the budget, each between 0 and 1000."
  default       = ["25", "50", "75", "100"]
}

// Note: This should be 5, but due to a bug in current Terraform, can only do 1 here, and value can't match any value in the actual_threshholds list
variable "forecasted_thresholds" {
  type          = list(string)
  description   = "An array of values to be associated with normal and urgent notifications, when forecasted costs exceed these values. This should be a list of 1 integer, representing percent of the budget, each between 0 and 1000."
  default       = ["67"]
}

variable "contact_emails" {
  type          = list(string)
  description   = "An array of email addresses to be contacted when a notification is to be sent."
  default       = ["michael.crawford@neudesic.com"]
}
