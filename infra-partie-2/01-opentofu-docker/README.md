sudo apt update && sudo apt install -y docker.io

sudo systemctl enable --now docker

curl -fsSL https://get.opentofu.org/install.sh | sudo bash

mkdir opentofu-docker-demo

cd opentofu-docker-demo/

clear

snap install --classic opentofu

sudo snap install --classic opentofu

tofu versiob

tofu version

touch main.tf

tofu init

tofu plan

tofu apply -auto-approve

tofu plan

tofu apply -auto-approve

docker ps

tofu destroy -auto-approve

exit