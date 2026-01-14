# Plateforme DevSecOps locale avec OpenTofu

Ce TP met en place une plateforme DevSecOps **100 % locale**, auto-hébergée avec Docker et décrite intégralement en OpenTofu.

## Outils inclus
- Gitea (Git)
- Jenkins (CI)
- SonarQube Community (qualité de code)
- PostgreSQL (base partagée)
- Réseau Docker dédié
- Volumes persistants

## Pré-requis
- Docker installé et fonctionnel
```bash
sudo apt update && sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
```
- OpenTofu installé
```bash
sudo apt update && sudo snap install --classic opentofu
tofu version
```
ou
```bash
sudo apt update && sudo apt install -y opentofu
tofu version
```
- ≥ 6 Go de RAM disponibles recommandés

## Lancement
```bash
tofu init
tofu apply -auto-approve
docker ps
```

## Lien vers les interfaces
- Gitea http://localhost:3000/
- Jenkins http://localhost:8080/
- SonarQube http://localhost:9000/


### Destruction 
```bash
tofu destroy -auto-approve
docker ps
```
