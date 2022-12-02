variable "admin_group_object_ids" {
  type    = list(string)
  default = ["a49f2126-016d-46e8-9808-d77e041bb1e2"]
}

variable "tenant_id" {
  type    = string
  default = "5702f542-8ed2-4422-a818-5a1f3515837a"
}

variable "DestinationEmail" {
  type    = string
  default = "paul.johnston@microsoft.com"
}

variable "log_analytics_workspace_id" {
  type    = string
  default = "/subscriptions/2587c9bd-2181-43d1-8bfa-20216d4a13e0/resourceGroups/APT-VB-RG-LAW-001/providers/Microsoft.OperationalInsights/workspaces/APT-VB-LAW-001"
}

variable "ProjectID" {
  type    = string
  default = "kkdrp"
}

variable "AKSSystemPoolName" {
  type    = string
  default = "pjsyspool22"
}
variable "CustomHostname" {
  type    = string
  default = "web001"
}

variable "ConnectivitySubscriptionID" {
  type    = string
  default = "35277960-2541-4e84-bf1d-528415f89969"
}

variable "DNSZoneName" {
  type = string
  default = "pjcsa.cloud"
}

variable "DNSZoneID" {
  type = string
  default = "/subscriptions/35277960-2541-4e84-bf1d-528415f89969/resourceGroups/apt-vb-dns-001/providers/Microsoft.Network/dnszones/pjcsa.cloud"
}

variable "DNSZoneResourceGroup" {
  type = string
  default = "apt-vb-dns-001"
}