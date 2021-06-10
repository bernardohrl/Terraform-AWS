```
# Cria arquivos locais de configuração inicial
terraform init

# Vê as mudanças
terraform plan
terraform plan -out="tfplan.out"
terraform plan -var-file="prod.tfvars"

# Aplica as mudanças
terraform apply 
terraform apply --auto-approve
terraform apply "tfplan.out"


# Exclui tudo
terraform destroy

# Valida se as tags estão corretas
terraform validate

# Formata os arquivos
terraform fmt
```