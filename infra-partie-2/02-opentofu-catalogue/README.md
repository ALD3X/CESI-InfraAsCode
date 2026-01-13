mkdir opentofu-pro-demo

cd opentofu-pro-demo

mkdir api

tofu init

cd api/

rm -r *

ls

npm init -y

npm install express pg redis

cd ..

touch main.tf variables.tf outputs.tf terraform.tfvars

tofu init

docker ps

tofu plan -var-file="terraform.tfvars"

tofu apply -var-file="terraform.tfvars"

docker ps

curl http://localhost:3000/health

docker ps -a

docker logs opentofu_api

tofu destroy -var-file="terraform.tfvars" -auto-approve

tofu destroy -var-file="terraform.tfvars" -auto-approve

tofu plan -var-file="terraform.tfvars"

tofu apply -var-file="terraform.tfvars"

curl http://localhost:3000/health

curl http://localhost:3000/products

curl http://localhost:3000/health

tofu apply -var-file="terraform.tfvars"

tofu apply -var-file="terraform.tfvars"

docker ps

curl http://localhost:3000/health

tofu destroy -var-file="terraform.tfvars" -auto-approve