# Azure Terraform Infrastructure

A Terraform lab that provisions an Azure resource group and a StorageV2 account with Standard LRS replication. A state-tracked random suffix helps make the storage name globally unique. The account requires HTTPS and TLS 1.2 or later and disables anonymous public blob access.

## Validate without an Azure subscription

```sh
terraform init -backend=false
terraform fmt -check -recursive
terraform validate
terraform test
```

Provider plugins are downloaded during init. The test uses mock providers and creates no Azure resources.

## Deploy to your own Azure subscription

```sh
az login
az account set --subscription YOUR_SUBSCRIPTION_ID
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
terraform init
terraform plan -out=deployment.tfplan
terraform apply deployment.tfplan
terraform output
```

Deployment uses the subscription you select and can incur Azure charges. This example uses local Terraform state. Keep the state and plan out of Git. After the lab, use `terraform destroy` to remove the resources and confirm the planned deletion.
