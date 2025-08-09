data "azurerm_lb" "lb" {
  name                = "n01725290-lb"
  resource_group_name = module.resource_group.resource_group_name
  depends_on          = [module.lb]
}

resource "azurerm_monitor_action_group" "ag" {
  name                = "n01725290-ag"
  resource_group_name = module.resource_group.resource_group_name
  short_name          = "n0172ag"

  webhook_receiver {
    name                    = "noop-webhook"
    service_uri             = "https://example.com/alert"
    use_common_alert_schema = true
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "lb_availability" {
  name                = "n01725290-lb-availability-alert"
  resource_group_name = module.resource_group.resource_group_name
  scopes              = [data.azurerm_lb.lb.id]
  description         = "Alert if LB VIP availability drops below 90%"

  frequency   = "PT1M"
  window_size = "PT5M"
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.Network/loadBalancers"
    metric_name      = "VipAvailability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.ag.id
  }

  tags = local.tags
}

