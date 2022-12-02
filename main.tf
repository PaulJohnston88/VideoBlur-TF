resource "azurerm_resource_group" "vbrg1" {
  location = "westeurope"
  name     = "PJPFE-APT-VB-004"
}
resource "azurerm_kubernetes_cluster" "res-4" {
  dns_prefix          = "${var.ProjectID}-aks-cluster"
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}-aks-clus"
  resource_group_name = azurerm_resource_group.vbrg1.name
  azure_active_directory_role_based_access_control {
    admin_group_object_ids = var.admin_group_object_ids
    azure_rbac_enabled     = true
    managed                = true
    tenant_id              = var.tenant_id
  }
  default_node_pool {
    name           = "pjsyspool76"
    vm_size        = "Standard_B2s"
    vnet_subnet_id = azurerm_subnet.res-21.id
    node_count     = "1"
  }
  identity {
    type = "SystemAssigned"
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
  depends_on = [
    azurerm_subnet.res-21,
  ]
}
resource "azurerm_kubernetes_cluster_node_pool" "res-5" {
  enable_auto_scaling   = true
  kubernetes_cluster_id = azurerm_kubernetes_cluster.res-4.id
  node_count            = 2
  max_count             = 4
  name                  = "jobpool1"
  node_taints           = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
  vm_size               = "Standard_D2s_v3"
  vnet_subnet_id        = azurerm_subnet.res-21.id
  depends_on = [
    azurerm_kubernetes_cluster.res-4,
    azurerm_subnet.res-21,
  ]
}
resource "azurerm_kubernetes_cluster_node_pool" "res-6" {
  kubernetes_cluster_id = azurerm_kubernetes_cluster.res-4.id
  mode                  = "System"
  name                  = var.AKSSystemPoolName
  vm_size               = "Standard_B2s"
  node_count            = "1"
  vnet_subnet_id        = azurerm_subnet.res-21.id
  depends_on = [
    azurerm_kubernetes_cluster.res-4,
    azurerm_subnet.res-21,
  ]
}
resource "azurerm_eventgrid_system_topic" "res-7" {
  location               = azurerm_resource_group.aksrg1.location
  name                   = "${var.ProjectID}eventgridtopic"
  resource_group_name    = azurerm_resource_group.vbrg1.name
  source_arm_resource_id = azurerm_storage_account.res-40.id
  topic_type             = "Microsoft.Storage.StorageAccounts"
  depends_on = [
    azurerm_storage_account.res-40,
  ]
}
resource "azurerm_eventgrid_system_topic_event_subscription" "res-8" {
  name                          = "inputContainer"
  resource_group_name           = azurerm_resource_group.vbrg1.name
  service_bus_queue_endpoint_id = azurerm_servicebus_queue.res-25.id
  system_topic                  = "${var.ProjectID}eventgridtopic"
  subject_filter {
    subject_begins_with = "/blobServices/default/containers/input/"
  }
  included_event_types = [ "Microsoft.Storage.BlobCreated" ]
  depends_on = [
    azurerm_eventgrid_system_topic.res-7,
    azurerm_servicebus_queue.res-25,
  ]
}
resource "azurerm_eventgrid_system_topic_event_subscription" "res-9" {
  name                          = "outputContainer"
  resource_group_name           = azurerm_resource_group.vbrg1.name
  service_bus_queue_endpoint_id = azurerm_servicebus_queue.res-28.id
  system_topic                  = "${var.ProjectID}eventgridtopic"
  included_event_types = [ "Microsoft.Storage.BlobCreated" ]
  subject_filter {
    subject_begins_with = "/blobServices/default/containers/output/"
  }
  depends_on = [
    azurerm_eventgrid_system_topic.res-7,
    azurerm_servicebus_queue.res-28,
  ]
}
resource "azurerm_application_insights" "res-10" {
  application_type    = "other"
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}appinsights"
  resource_group_name = azurerm_resource_group.vbrg1.name
  sampling_percentage = 0
  workspace_id        = var.log_analytics_workspace_id
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_application_insights" "res-11" {
  application_type    = "web"
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}functions"
  resource_group_name = azurerm_resource_group.vbrg1.name
  sampling_percentage = 0
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
/* resource "azurerm_communication_service" "commsvc1" {
  name                = "${var.ProjectID}commservices"
  resource_group_name = azurerm_resource_group.vbrg1.name
  data_location       = "United States"
} */

//get pjcsa.cloud DNS Zone ID
/* data "azurerm_dns_zone" "DNSZone1" {
  provider = azurerm.Connectivity
  name                = "${var.DNSZoneName}"
  resource_group_name = "${var.DNSZoneResourceGroup}"
} */

/* resource "azapi_resource" "commsvc1" {
  type = "Microsoft.Communication/communicationServices@2022-07-01-preview"
  name = "${var.ProjectID}commservices"
  location = "Global"
  parent_id = azurerm_resource_group.vbrg1.id
  body = jsonencode({
    properties = {
      dataLocation = "United States"
      linkedDomains = [ "var.DNSZoneID"]
    }
  })
}

resource "azapi_resource" "emailcommsvc1" {
  type      = "Microsoft.Communication/emailServices@2022-07-01-preview"
  name      = "${var.ProjectID}emailcommservices"
  location  = "Global"
  parent_id = azurerm_resource_group.vbrg1.id
  body = jsonencode({
    properties = {
      dataLocation = "United States"
    }
  })
}

resource "azapi_resource" "emaildomain1" {
  type      = "Microsoft.Communication/emailServices/domains@2022-07-01-preview"
  name      = "pjcsa.cloud"
  location  = "global"
  parent_id = azapi_resource.emailcommsvc1.id
  body = jsonencode({
    properties = {
      domainManagement       = "CustomerManaged"
      userEngagementTracking = "Disabled"
      validSenderUsernames   = {}
    }
  })
} */

data "azurerm_kubernetes_cluster" "akscluster" {
  name                = azurerm_kubernetes_cluster.res-4.name
  resource_group_name = azurerm_kubernetes_cluster.res-4.resource_group_name
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "res-12" {
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}keyvault"
  resource_group_name = azurerm_resource_group.vbrg1.name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azurerm_kubernetes_cluster.akscluster.identity[0].principal_id
    secret_permissions = [
      "Backup",
      "Delete",
      "Get",
      "List",
      "Purge",
      "Recover",
      "Restore",
      "Set"
    ]
  }
  access_policy {
    tenant_id = var.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    secret_permissions = [
      "Get",
      "Delete",
      "Purge",
      "List",
      "Set"
    ]
  }
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_key_vault_secret" "res-13" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "AzureSignalRConnectionString"
  value        = azurerm_signalr_service.res-30.primary_connection_string
  depends_on = [
    azurerm_key_vault.res-12,
  ]
}

//find primary connection string of commsvc1
/* data "azapi_resource" "Commsvc1ConnectionString" {
  name = azapi_resource.commsvc1.name
  parent_id = azurerm_resource_group.vbrg1.id
  type = "Microsoft.Communication/communicationServices@2022-07-01-preview"

response_export_values = [ "properties.primary_connection_string" ]

}

resource "azurerm_key_vault_secret" "res-14" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "CommsServiceConnectionString"
  value        = data.azapi_resource.Commsvc1ConnectionString.response_export_values[0]
  #azurerm_communication_service.commsvc1.primary_connection_string
  depends_on = [
    azurerm_key_vault.res-12,
  ]
} */
resource "azurerm_key_vault_secret" "res-15" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "EmailQueueRuleConnectionString"
  value        = azurerm_servicebus_queue_authorization_rule.res-29.primary_connection_string
  depends_on = [
    azurerm_key_vault.res-12,
  ]
}
resource "azurerm_key_vault_secret" "res-16" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "InsightsConnectionString"
  value        = azurerm_application_insights.res-10.instrumentation_key
  depends_on = [
    azurerm_key_vault.res-12,
  ]
}
resource "azurerm_key_vault_secret" "res-17" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "KedaConnectionString"
  value        = azurerm_servicebus_queue_authorization_rule.res-26.primary_connection_string

  depends_on = [
    azurerm_key_vault.res-12,
  ]
}
resource "azurerm_key_vault_secret" "res-18" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "StorageConnectionString"
  value        = azurerm_storage_account.res-40.primary_connection_string
  depends_on = [
    azurerm_key_vault.res-12,
  ]
}
resource "azurerm_key_vault_secret" "res-19" {
  key_vault_id = azurerm_key_vault.res-12.id
  name         = "WorkerConnectionString"
  value        = azurerm_servicebus_queue_authorization_rule.res-27.primary_connection_string
  depends_on = [
    azurerm_key_vault.res-12,
  ]
}
resource "azurerm_virtual_network" "res-20" {
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.vbrg1.location
  name                = "JPRG-${var.ProjectID}-SPOKE"
  resource_group_name = azurerm_resource_group.vbrg1.name
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_subnet" "res-21" {
  address_prefixes     = ["10.1.0.0/22"]
  name                 = "AKS-Subnet"
  resource_group_name  = azurerm_resource_group.vbrg1.name
  virtual_network_name = azurerm_virtual_network.res-20.name
  depends_on = [
    azurerm_virtual_network.res-20,
  ]
}
resource "azurerm_servicebus_namespace" "res-22" {
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}servicebus"
  resource_group_name = azurerm_resource_group.vbrg1.name
  sku                 = "Basic"
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_servicebus_namespace_network_rule_set" "res-23" {
  namespace_id = azurerm_servicebus_namespace.res-22.id
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-23,
  ]
}
resource "azurerm_servicebus_namespace_authorization_rule" "res-24" {
  listen       = true
  manage       = true
  name         = "RootManageSharedAccessKey1"
  namespace_id = azurerm_servicebus_namespace.res-22.id
  send         = true
  depends_on = [
    azurerm_servicebus_namespace.res-22,
    azurerm_servicebus_namespace_network_rule_set.res-23,
  ]
  lifecycle {
    ignore_changes = [
      listen,
      manage,
      send,
    ]
  }
}
resource "azurerm_servicebus_queue" "res-25" {
  name         = "input-queue"
  namespace_id = azurerm_servicebus_namespace.res-22.id
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-23,
  ]
}
resource "azurerm_servicebus_queue_authorization_rule" "res-26" {
  listen   = true
  manage   = true
  name     = "keda-monitor"
  queue_id = azurerm_servicebus_queue.res-25.id
  send     = true
  depends_on = [
    azurerm_servicebus_queue.res-25,
  ]
}
resource "azurerm_servicebus_queue_authorization_rule" "res-27" {
  listen   = true
  name     = "worker-consumer"
  queue_id = azurerm_servicebus_queue.res-25.id
  depends_on = [
    azurerm_servicebus_queue.res-25,
  ]
}
resource "azurerm_servicebus_queue" "res-28" {
  name         = "output-queue"
  namespace_id = azurerm_servicebus_namespace.res-22.id
  depends_on = [
    azurerm_servicebus_namespace_network_rule_set.res-23,
  ]
}
resource "azurerm_servicebus_queue_authorization_rule" "res-29" {
  listen   = true
  name     = "email-consumer"
  queue_id = azurerm_servicebus_queue.res-28.id
  depends_on = [
    azurerm_servicebus_queue.res-28,
  ]
}
resource "azurerm_signalr_service" "res-30" {
  connectivity_logs_enabled = true
  location                  = azurerm_resource_group.vbrg1.location
  name                      = "${var.ProjectID}signalr"
  resource_group_name       = azurerm_resource_group.vbrg1.name
  service_mode              = "Serverless"
  sku {
    capacity = 1
    name     = "Free_F1"
  }
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_storage_account" "res-31" {
  account_kind             = "Storage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.vbrg1.location
  min_tls_version          = "TLS1_0"
  name                     = "${var.ProjectID}functionsstorage"
  resource_group_name      = azurerm_resource_group.vbrg1.name
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_storage_container" "res-33" {
  name                 = "azure-webjobs-hosts"
  storage_account_name = azurerm_storage_account.res-31.name
}
resource "azurerm_storage_container" "res-34" {
  name                 = "azure-webjobs-secrets"
  storage_account_name = azurerm_storage_account.res-31.name
}
resource "azurerm_storage_container" "res-35" {
  name                 = "scm-releases"
  storage_account_name = azurerm_storage_account.res-31.name
}
resource "azurerm_storage_share" "res-37" {
  name                 = "${var.ProjectID}functionsstorage"
  quota                = 5120
  storage_account_name = azurerm_storage_account.res-31.name
}
resource "azurerm_storage_account" "res-40" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = azurerm_resource_group.vbrg1.location
  min_tls_version          = "TLS1_0"
  name                     = "${var.ProjectID}storage"
  resource_group_name      = azurerm_resource_group.vbrg1.name
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_storage_container" "res-42" {
  name                 = "input"
  storage_account_name = azurerm_storage_account.res-40.name
}
resource "azurerm_storage_container" "res-43" {
  name                 = "output"
  storage_account_name = azurerm_storage_account.res-40.name
}

resource "azurerm_service_plan" "res-47" {
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}functions"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.vbrg1.name
  sku_name            = "Y1"
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_linux_function_app" "res-48" {
  app_settings = {
    AzureSignalRConnectionString = azurerm_signalr_service.res-30.primary_connection_string
    /* CommsServiceConnectionString = data.azapi_resource.Commsvc1ConnectionString.response_export_values[0] */
    #azurerm_communication_service.commsvc1.primary_connection_string
    CommsServiceSender           = "DoNotReply@pjcsa.cloud"
    DestinationEmail             = var.DestinationEmail
    ServiceBusConnectionString   = azurerm_servicebus_queue_authorization_rule.res-29.primary_connection_string
  }
  builtin_logging_enabled    = false
  client_certificate_mode    = "Required"
  https_only                 = true
  location                   = azurerm_resource_group.vbrg1.location
  name                       = "${var.ProjectID}functions"
  resource_group_name        = azurerm_resource_group.vbrg1.name
  service_plan_id            = azurerm_service_plan.res-47.id
  storage_account_access_key = azurerm_storage_account.res-31.primary_access_key
  storage_account_name       = azurerm_storage_account.res-31.name
  identity {
    type = "SystemAssigned"
  }
  site_config {
    application_insights_connection_string = azurerm_application_insights.res-11.connection_string
    application_insights_key               = azurerm_application_insights.res-11.instrumentation_key
    ftps_state                             = "AllAllowed"
    application_stack {
      dotnet_version = "6.0"
    }
    cors {
      allowed_origins = ["https://gentle-pond-08a390003.2.azurestaticapps.net", "https://localhost:7044"]
    }
  }
  depends_on = [
    azurerm_application_insights.res-11,
    azurerm_storage_account.res-31,
    azurerm_service_plan.res-47,
  ]
}

//create domain txt dns verification record
resource "azurerm_dns_txt_record" "pjcsaDNSZoneTXT" {
  provider = azurerm.Connectivity
  name                = "asuid.${var.ProjectID}functions"
  resource_group_name = "${var.DNSZoneResourceGroup}"
  ttl                 = 3600
  zone_name           = "pjcsa.cloud"
  record {
    value = azurerm_linux_function_app.res-48.custom_domain_verification_id
  }
  depends_on = [
  ]
}

//create cname record for azure app service
resource "azurerm_dns_cname_record" "pjcsaDNSZoneCNAME" {
  provider = azurerm.Connectivity
  name                = "${var.ProjectID}functions"
  resource_group_name = "apt-vb-dns-001"
  ttl                 = 3600
  zone_name           = "pjcsa.cloud"
  record              = "pjcsa.cloud"
  depends_on = [
  ]
}

resource "azurerm_app_service_custom_hostname_binding" "res-52" {
  app_service_name    = azurerm_service_plan.res-47.name
  hostname            = "${var.ProjectID}functions.pjcsa.cloud"
  resource_group_name = azurerm_resource_group.vbrg1.name
  depends_on = [
    azurerm_service_plan.res-47,
    azurerm_linux_function_app.res-48,
    azurerm_dns_txt_record.pjcsaDNSZoneTXT,
  ]
  lifecycle {
    ignore_changes = [
      hostname,
    ]
  }
}
resource "azurerm_static_site" "res-53" {
  location            = azurerm_resource_group.vbrg1.location
  name                = "${var.ProjectID}-notification-client"
  resource_group_name = azurerm_resource_group.vbrg1.name
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_monitor_smart_detector_alert_rule" "res-54" {
  description         = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
  detector_type       = "FailureAnomaliesDetector"
  frequency           = "PT1M"
  name                = "Failure Anomalies - ${var.ProjectID}appinsights"
  resource_group_name = azurerm_resource_group.vbrg1.name
  scope_resource_ids  = [azurerm_application_insights.res-10.id]
  severity            = "Sev3"
  action_group {
    ids = [azurerm_monitor_action_group.res-56.id]
  }
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_monitor_smart_detector_alert_rule" "res-55" {
  description         = "Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls."
  detector_type       = "FailureAnomaliesDetector"
  frequency           = "PT1M"
  name                = "Failure Anomalies - ${var.ProjectID}functions"
  resource_group_name = azurerm_resource_group.vbrg1.name
  scope_resource_ids  = [azurerm_application_insights.res-11.id]
  severity            = "Sev3"
  action_group {
    ids = [azurerm_monitor_action_group.res-56.id]
  }
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}
resource "azurerm_monitor_action_group" "res-56" {
  name                = "Application Insights Smart Detection"
  resource_group_name = azurerm_resource_group.vbrg1.name
  short_name          = "SmartDetect"
  arm_role_receiver {
    name                    = "Monitoring Contributor"
    role_id                 = "749f88d5-cbae-40b8-bcfc-e573ddc772fa"
    use_common_alert_schema = true
  }
  arm_role_receiver {
    name                    = "Monitoring Reader"
    role_id                 = "43d0d8ad-25c7-4714-9337-8ba259a9fe05"
    use_common_alert_schema = true
  }
  depends_on = [
    azurerm_resource_group.vbrg1,
  ]
}