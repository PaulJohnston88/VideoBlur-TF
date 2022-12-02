resource "azurerm_resource_group" "aksrg1" {
  location = "westeurope"
  name     = "${var.ProjectID}-MC_PJPFE-APT-VB-004_vblz4-aks-cluster_westeurope"
  tags = {
    aks-managed-cluster-name = "vblz4-aks-cluster"
    aks-managed-cluster-rg   = "PJPFE-APT-VB-004"
  }
}
resource "azurerm_linux_virtual_machine_scale_set" "res-1" {
  admin_username         = "azureuser"
  extensions_time_budget = "PT16M"
  location               = azurerm_resource_group.aksrg1.location
  name                   = "aks-jobpool1-19959757-vmss"
  overprovision          = false
  resource_group_name    = azurerm_resource_group.aksrg1.name
  single_placement_group = false
  sku                    = "Standard_D2s_v3"
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = {
    aks-managed-createOperationID       = "8bd95bb2-dd3d-4077-bac8-e6733399de83"
    aks-managed-creationSource          = "vmssclient-aks-jobpool1-19959757-vmss"
    aks-managed-kubeletIdentityClientID = "7305fb35-0f0f-4b0f-a4e4-566f1d5dc5c6"
    aks-managed-orchestrator            = "Kubernetes:1.24.6"
    aks-managed-poolName                = "jobpool1"
    aks-managed-resourceNameSuffix      = "21785618"
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRycy8A+gzfvdlYBb15OpispBa8PEnWvZcbVHo/SQVsIa6utzq1loWOFfVhAxx1KrSkC44rm1o4LyBAIhxURoFPVU4hGYQdvkeWjJm/owm1m+0v1Y6YA3Km0UGSQvuesJo1QCOBkR453ScECqUIgERt/C0kUo0yaO3AX6ohNU7dXJF0PQ9alRZTv6ClLPl02cjiUZWkiy3mc2cZg/gY+cU8jky7Y0tsR9MJ6ygYZ3V+vCGu2wfDHwC7XJn8XClH3pys0BBmV8Pm03Sk/KBJjcXOEiJFO39fGOb9MV+MyVPNKggSmgsoEa6iUknFt8G0gWdYXrmbdFsXASaRBzqOHUl1vJGcuWTc9bOLjF3BHxclbk3vcPMUt00cSF/lQiE2aAOfz8ehVg8EQdwgyeXbJ5G8B3AbMVEGWE6CrK/096vHLOs4e4Ho8p4VI1dMhMSlU3mIhRvaL4smKl3fR8r2vgDUmAnCKAHrH2m7Jz76d5xwfjyavuIV99Q8jWbSQTGjhyFLEvpY38bCV5Dr4aiTNpEihFDjQk0ApGL5NkwaTKfQqsJqOvIeS2DJPcRR8vTIkRy4GoOSnp+7Gl1GxseVB501E8BPhhnoiVe2b1jNVG6xer5YlymwwD/ZHcGFwIsS8VKz9jxqf//uuNi3PMYJwplMIUl9MAu1+iPdRWeznJcpw==\n"
    username   = "azureuser"
  }
  identity {
    identity_ids = [azurerm_user_assigned_identity.res-13.id, azurerm_user_assigned_identity.res-14.id, azurerm_user_assigned_identity.res-15.id]
    type         = "UserAssigned"
  }
  network_interface {
    enable_accelerated_networking = true
    name                          = "aks-jobpool1-19959757-vmss"
    network_security_group_id     = azurerm_network_security_group.res-19.id
    primary                       = true
    ip_configuration {
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.res-17.id, azurerm_lb_backend_address_pool.res-18.id]
      name                                   = "ipconfig1"
      primary                                = true
      subnet_id                              = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig2"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig3"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig4"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig5"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig6"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig7"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig8"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig9"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig10"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig11"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig12"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig13"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig14"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig15"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig16"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig17"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig18"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig19"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig20"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig21"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig22"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig23"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig24"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig25"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig26"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig27"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig28"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig29"
      subnet_id = azurerm_subnet.res-21.id
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  depends_on = [
    azurerm_user_assigned_identity.res-13,
    azurerm_user_assigned_identity.res-14,
    azurerm_user_assigned_identity.res-15,
    azurerm_lb_backend_address_pool.res-17,
    azurerm_lb_backend_address_pool.res-18,
    azurerm_network_security_group.res-19,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-2" {
  auto_upgrade_minor_version   = false
  name                         = "AKSLinuxExtension"
  provision_after_extensions   = [azurerm_virtual_machine_scale_set_extension.res-4.name]
  publisher                    = "Microsoft.AKS"
  type                         = "Compute.AKS.Linux.AKSNode"
  type_handler_version         = "1.30"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-1.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-1,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-3" {
  name                         = "aks-jobpool1-19959757-vmss-AKSLinuxBilling"
  publisher                    = "Microsoft.AKS"
  type                         = "Compute.AKS.Linux.Billing"
  type_handler_version         = "1.0"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-1.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-1,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-4" {
  name                         = "vmssCSE"
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-1.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-1,
  ]
}
resource "azurerm_linux_virtual_machine_scale_set" "res-5" {
  admin_username         = "azureuser"
  extensions_time_budget = "PT16M"
  instances              = 1
  location               = azurerm_resource_group.aksrg1.location
  name                   = "aks-systempool1-19959757-vmss"
  overprovision          = false
  resource_group_name    = azurerm_resource_group.aksrg1.name
  single_placement_group = false
  sku                    = "Standard_B2s"
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  tags = {
    aks-managed-createOperationID       = "8bd95bb2-dd3d-4077-bac8-e6733399de83"
    aks-managed-creationSource          = "vmssclient-aks-systempool1-19959757-vmss"
    aks-managed-kubeletIdentityClientID = "7305fb35-0f0f-4b0f-a4e4-566f1d5dc5c6"
    aks-managed-orchestrator            = "Kubernetes:1.24.6"
    aks-managed-poolName                = "systempool1"
    aks-managed-resourceNameSuffix      = "21785618"
  }
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDRycy8A+gzfvdlYBb15OpispBa8PEnWvZcbVHo/SQVsIa6utzq1loWOFfVhAxx1KrSkC44rm1o4LyBAIhxURoFPVU4hGYQdvkeWjJm/owm1m+0v1Y6YA3Km0UGSQvuesJo1QCOBkR453ScECqUIgERt/C0kUo0yaO3AX6ohNU7dXJF0PQ9alRZTv6ClLPl02cjiUZWkiy3mc2cZg/gY+cU8jky7Y0tsR9MJ6ygYZ3V+vCGu2wfDHwC7XJn8XClH3pys0BBmV8Pm03Sk/KBJjcXOEiJFO39fGOb9MV+MyVPNKggSmgsoEa6iUknFt8G0gWdYXrmbdFsXASaRBzqOHUl1vJGcuWTc9bOLjF3BHxclbk3vcPMUt00cSF/lQiE2aAOfz8ehVg8EQdwgyeXbJ5G8B3AbMVEGWE6CrK/096vHLOs4e4Ho8p4VI1dMhMSlU3mIhRvaL4smKl3fR8r2vgDUmAnCKAHrH2m7Jz76d5xwfjyavuIV99Q8jWbSQTGjhyFLEvpY38bCV5Dr4aiTNpEihFDjQk0ApGL5NkwaTKfQqsJqOvIeS2DJPcRR8vTIkRy4GoOSnp+7Gl1GxseVB501E8BPhhnoiVe2b1jNVG6xer5YlymwwD/ZHcGFwIsS8VKz9jxqf//uuNi3PMYJwplMIUl9MAu1+iPdRWeznJcpw==\n"
    username   = "azureuser"
  }
  identity {
    identity_ids = [azurerm_user_assigned_identity.res-13.id, azurerm_user_assigned_identity.res-14.id, azurerm_user_assigned_identity.res-15.id]
    type         = "UserAssigned"
  }
  network_interface {
    name                      = "aks-systempool1-19959757-vmss"
    network_security_group_id = azurerm_network_security_group.res-19.id
    primary                   = true
    ip_configuration {
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.res-17.id, azurerm_lb_backend_address_pool.res-18.id]
      name                                   = "ipconfig1"
      primary                                = true
      subnet_id                              = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig2"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig3"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig4"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig5"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig6"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig7"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig8"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig9"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig10"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig11"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig12"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig13"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig14"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig15"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig16"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig17"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig18"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig19"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig20"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig21"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig22"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig23"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig24"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig25"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig26"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig27"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig28"
      subnet_id = azurerm_subnet.res-21.id
    }
    ip_configuration {
      name      = "ipconfig29"
      subnet_id = azurerm_subnet.res-21.id
    }
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  depends_on = [
    azurerm_user_assigned_identity.res-13,
    azurerm_user_assigned_identity.res-14,
    azurerm_user_assigned_identity.res-15,
    azurerm_lb_backend_address_pool.res-17,
    azurerm_lb_backend_address_pool.res-18,
    azurerm_network_security_group.res-19,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-6" {
  auto_upgrade_minor_version   = false
  name                         = "AKSLinuxExtension"
  provision_after_extensions   = [azurerm_virtual_machine_scale_set_extension.res-8.name]
  publisher                    = "Microsoft.AKS"
  type                         = "Compute.AKS.Linux.AKSNode"
  type_handler_version         = "1.30"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-5.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-5,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-7" {
  name                         = "aks-systempool1-19959757-vmss-AKSLinuxBilling"
  publisher                    = "Microsoft.AKS"
  type                         = "Compute.AKS.Linux.Billing"
  type_handler_version         = "1.0"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-5.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-5,
  ]
}
resource "azurerm_virtual_machine_scale_set_extension" "res-8" {
  name                         = "vmssCSE"
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.res-5.id
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.res-5,
  ]
}
resource "azurerm_user_assigned_identity" "res-13" {
  location            = azurerm_resource_group.aksrg1.location
  name                = "azurekeyvaultsecretsprovider-vblz4-aks-cluster"
  resource_group_name = azurerm_resource_group.aksrg1.name
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
resource "azurerm_user_assigned_identity" "res-14" {
  location            = azurerm_resource_group.aksrg1.location
  name                = "omsagent-vblz4-aks-cluster"
  resource_group_name = azurerm_resource_group.aksrg1.name
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
resource "azurerm_user_assigned_identity" "res-15" {
  location            = azurerm_resource_group.aksrg1.location
  name                = "vblz4-aks-cluster-agentpool"
  resource_group_name = azurerm_resource_group.aksrg1.name
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
resource "azurerm_lb" "res-16" {
  location            = azurerm_resource_group.aksrg1.location
  name                = "kubernetes"
  resource_group_name = azurerm_resource_group.aksrg1.name
  sku                 = "Standard"
  tags = {
    aks-managed-cluster-name = "${var.ProjectID}-aks-cluster"
    aks-managed-cluster-rg   = "PJPFE-APT-VB-004"
  }
  frontend_ip_configuration {
    name                 = azurerm_public_ip.res-20.name
    public_ip_address_id = azurerm_public_ip.res-20.id
  }
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-17" {
  loadbalancer_id = azurerm_lb.res-16.id
  name            = "aksOutboundBackendPool"
  depends_on = [
    azurerm_lb.res-16,
  ]
}
resource "azurerm_lb_backend_address_pool" "res-18" {
  loadbalancer_id = azurerm_lb.res-16.id
  name            = "kubernetes"
  depends_on = [
    azurerm_lb.res-16,
  ]
}
resource "azurerm_network_security_group" "res-19" {
  location            = azurerm_resource_group.aksrg1.location
  name                = "aks-agentpool-21785618-nsg"
  resource_group_name = azurerm_resource_group.aksrg1.name
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
resource "azurerm_public_ip" "res-20" {
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  location                = azurerm_resource_group.aksrg1.location
  name                    = "fb661ee3-528a-4f0a-9ddc-f243cd624ea0"
  resource_group_name     = azurerm_resource_group.aksrg1.name
  sku                     = "Standard"
  tags = {
    aks-managed-cluster-name = "vblz4-aks-cluster"
    aks-managed-cluster-rg   = "PJPFE-APT-VB-004"
    aks-managed-type         = "aks-slb-managed-outbound-ip"
  }
  zones = ["1", "2", "3"]
  depends_on = [
    azurerm_resource_group.aksrg1,
  ]
}
