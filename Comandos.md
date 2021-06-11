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


# Mostra todos recursos
terraform show


# Ver os recursos de forma interativa
terraform console
<nome do recurso> (aws_s3_bucket_object.object1.bucket)


# Importar recursos criados manualmente
terraform import <comando específico para cada recurso>
```