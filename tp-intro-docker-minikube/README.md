sur la vm:

mkdir docker-node-app

cd docker-node-app

nano server.js

nano Dockerfile

docker build -t hello-node:1.0 .

docker run -p 8080:8080 node-app

docker ps

minikube start --driver=docker

minikube image build -t hello-node:1.0 .

docker build -t node-app .

nano deployment.yaml (node-app)

kubectl apply -f deployment.yaml

kubectl get pods

minikube service node-app-service --url


# Mener l’analyse
### Pourquoi Docker a permis d’exécuter le serveur Node.js sans Node.js installé localement ?
- Car on lance une image de docker contenant node.js
### Quel est l’intérêt d’utiliser Minikube/Kubernetes pour déployer un conteneur ?
- cela permet de généraliser le comportement sur tout type d'environnement afin de pouvoir partager/reproduire et Minikube permet de simuler un cluster kubernetes localement
### Quelles sont les différences entre lancer un conteneur directement avec Docker et l’orchestrer avec Kubernetes ?
- Docker seul lance un conteneur manuellement sur une machine unique, Kubernetes gère plusieurs conteneurs, leur communication et permet donc une gestion plus robuste pour un env de prod