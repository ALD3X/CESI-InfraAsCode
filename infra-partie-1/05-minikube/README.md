- [guide installation minikube](https://kubernetes.io/fr/docs/tasks/tools/install-minikube/)
  
sudo usermod -aG docker $USER

newgrp docker

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

chmod +x minikube-linux-amd64

sudo mv minikube-linux-amd64 /usr/local/bin/minikube

minikube start --driver=docker

kubectl create deployment nginx --image=nginx

kubectl expose deployment nginx --type=NodePort --port=80

minikube service nginx --url

kubectl get pods

kubectl get services

kubectl get nodes

-- petite balade sur le tuto minikube+kubectl

kubectl delete service nginx
kubectl delete deployment nginx
