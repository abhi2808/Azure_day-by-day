terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
    features {
    }
}

variable "perfix" {
    default = "practice"
}


resource "azurerm_resource_group" "example"{
    name = "${var.perfix}-rg"
    location = "Central India"
}

resource "azurerm_virtual_network" "main"{
    name="${var.perfix}-vnet"
    address_space = ["10.0.0.0/16"]
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "internal" {
    name="${var.perfix}-subnet"
    resource_group_name = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.main.name
    address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "main" {
    name="${var.perfix}-pip"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    allocation_method = "Static"
    sku = "Standard"
}

resource "azurerm_network_interface" "main" {
    name="${var.perfix}-nic"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name

  ip_configuration{
    name="testconfig"
    subnet_id = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_virtual_machine" "main" {
    name="${var.perfix}-vm"
    location = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    network_interface_ids = [azurerm_network_interface.main.id]
    vm_size = "Standard_DS1_v2"

    storage_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku="22_04-lts"
        version="latest"
    }

    storage_os_disk{
        name="myosdisk1"
        caching="ReadWrite"
        create_option="FromImage"
        managed_disk_type = "Standard_LRS"
    }
    os_profile{
        computer_name = "hostname"
        admin_username = "testadmin"
        admin_password = "testpassword"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path = "/home/testadmin/.ssh/authorized_keys"
            key_data = file("C:/Users/Minfy/Downloads/abhinav-azure-kp.pem")
        }
    }
    tags ={
        environment = "staging"
    }
}
