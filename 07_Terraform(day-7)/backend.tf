terraform {
    backend "azurerm" {
        storage_account_name = "azurebackendstoreabhinav"
        container_name = "backend"
        key="terraform.tfstate"
        access_key = "" # create the storage account, use its access key 
    }
}