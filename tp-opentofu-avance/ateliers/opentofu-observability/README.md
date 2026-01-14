# Stack Observabilité locale – OpenTofu

Ce TP déploie une stack d’observabilité locale pour une application Node.js simulée, sans dépendance à un SaaS externe.

## Outils
- Prometheus (métriques)
- Grafana (visualisation)
- Loki (logs)
- Podinfo (application Node.js de démonstration)

## Pré-requis
- Docker fonctionnel
- OpenTofu installé
- Ports libres : 3000, 8080, 9090, 3100

## Lancement

```bash
tofu init
tofu apply -auto-approve
```

## Accès aux services
- Podinfo : http://localhost:8080
- Prometheus : http://localhost:9090
- Grafan : http://localhost:3000
- Loki : http://localhost:3100/ready