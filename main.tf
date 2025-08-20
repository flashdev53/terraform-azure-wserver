provider "azurerm" {
    features {}
}
resource "azurerm_resource_group" "rg"{
    name="dev-webserver-rg"
    location="Central India"
}
resource "azurerm_virtual_network" "vnet"{
    name="dev-vnet"
    address_space=["10.0.0.0/16"]
    location=azurerm_resource_group.rg.location
    resource_group_name=azurerm_resource_group.rg.name
}
resource "azurerm_subnet" "subnet"{
    name="dev-subnet"   
    address_prefixes=["10.0.1.0/24"]
    virtual_network_name=azurerm_virtual_network.vnet.name
    resource_group_name=azurerm_resource_group.rg.name
}
resource "azurerm_public_ip" "publicip"{
    name="dev-publicip"
    allocation_method="Static"
    location=azurerm_resource_group.rg.location
    resource_group_name=azurerm_resource_group.rg.name
}
resource "azurerm_network_interface" "nic"{
    name="dev-nic"
    location=azurerm_resource_group.rg.location
    resource_group_name=azurerm_resource_group.rg.name
    ip_configuration{
        name="dev-ipconfig"
        subnet_id=azurerm_subnet.subnet.id
        private_ip_address_allocation="Dynamic"
        public_ip_address_id=azurerm_public_ip.publicip.id
    }
}
resource "azurerm_linux_virtual_machine" "vm"{
    name="dev-webserver-vm"
    size="Standard_B1s"
    admin_username="devadmin"
    location=azurerm_resource_group.rg.location
    resource_group_name=azurerm_resource_group.rg.name
    network_interface_ids=[azurerm_network_interface.nic.id]

    admin_ssh_key {
        username="devadmin"
        public_key = file("/home/dev/.ssh/id_rsa.pub")
    }

    os_disk {
        caching="ReadWrite"
        storage_account_type="Standard_LRS"
    }
    source_image_reference {
        publisher="Canonical"
        offer="0001-com-ubuntu-server-focal"
        sku="20_04-lts"
        version="latest"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update -y",
            "sudo apt-get install nginx -y",
            "sudo systemctl start nginx",
            "sudo systemctl enable nginx"
        ]
    }
}