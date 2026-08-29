# Action Group to handle notification channels
resource "azurerm_monitor_action_group" "budget_alert_group" {
  name                = "${var.prefix}-budget-alerts"
  resource_group_name = azurerm_resource_group.rg.name
  short_name          = "CostAlerts"

  dynamic "email_receiver" {
    for_each = var.alert_email_addresses
    content {
      name                    = "Email-${email_receiver.key}"
      email_address           = email_receiver.value
      use_common_alert_schema = true
    }
  }
}

# Consumption Budget scoped to the Resource Group
resource "azurerm_consumption_budget_resource_group" "rg_budget" {
  name              = "${var.prefix}-monthly-budget"
  resource_group_id = azurerm_resource_group.rg.id

  amount     = var.budget_amount
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  # Warning Alert: Actual spend crosses 75% (~$90)
  notification {
    enabled        = true
    threshold      = 75.0
    operator       = "GreaterThan"
    threshold_type = "Actual"

    contact_groups = [
      azurerm_monitor_action_group.budget_alert_group.id
    ]
    contact_emails = var.alert_email_addresses
  }

  # Critical Alert: Actual spend crosses 90% (~$108)
  notification {
    enabled        = true
    threshold      = 90.0
    operator       = "GreaterThan"
    threshold_type = "Actual"

    contact_groups = [
      azurerm_monitor_action_group.budget_alert_group.id
    ]
    contact_emails = var.alert_email_addresses
  }

  # Proactive Alert: Forecasted spend will exceed 100% (~$120) by month-end
  notification {
    enabled        = true
    threshold      = 100.0
    operator       = "GreaterThan"
    threshold_type = "Forecasted"

    contact_groups = [
      azurerm_monitor_action_group.budget_alert_group.id
    ]
    contact_emails = var.alert_email_addresses
  }

  lifecycle {
    ignore_changes = [
      time_period[0].start_date
    ]
  }
}
