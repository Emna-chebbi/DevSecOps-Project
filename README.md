# DevSecOps Project

## Overview

This project demonstrates a **complete enterprise-grade DevSecOps pipeline implementation** for a cloud-native social media management platform. It replaces traditional manual deployment with a fully automated **GitOps-based Kubernetes architecture** integrating CI/CD, security scanning, and observability.

The platform consists of **4 microservices** (API, Web, AI service, and background workers) deployed across **QA and Production environments**, managed through a centralized GitOps repository (BB-INFRA).

---

## Infrastructure Components

| Component | Purpose |
|-----------|--------|
| **GitHub Actions** | CI/CD automation (build, test, scan, deploy) |
| **SonarCloud** | SAST (code quality & security analysis) |
| **Trivy** | Filesystem & container vulnerability scanning |
| **Gitleaks** | Secrets detection in source code |
| **Checkov** | Infrastructure-as-Code security validation (Helm/K8s) |
| **OWASP ZAP** | Dynamic Application Security Testing (DAST) |
| **GitHub Container Registry (GHCR)** | Docker image storage |
| **BB-INFRA** | GitOps repository (Helm + environment configs) |
| **ArgoCD** | GitOps deployment controller (auto-sync cluster state) |
| **Kubernetes** | Container orchestration (QA environment) |
| **HashiCorp Vault** | Centralized secrets management |
| **Prometheus + Grafana** | Monitoring & visualization |
| **Alertmanager** | Alert routing & notifications (email via SMTP) |

---

## 🔁 GitOps Strategy

The **BB-INFRA repository** is the single source of truth for all environments.

It contains:
- Helm charts for all microservices
- Environment-specific values (QA / Production)
- ArgoCD Application manifests (App of Apps pattern)
- Prometheus alerting rules

### Advantages:
- No configuration drift
- Fully version-controlled infrastructure
- Environment isolation (QA vs Prod)
- Full audit trail of all changes
- Automated deployments via Git only

---

## Tech Stack

### DevOps / GitOps
- Docker (multi-stage builds, optimized images)
- Kubernetes
- ArgoCD (GitOps continuous deployment)
- Helm (templated infrastructure)
- GitHub Actions (CI/CD automation)
- GHCR (GitHub Container registry)

---

### 🔐 Security (Shift-Left + Shift-Right)

| Tool | Purpose | Stage |
|------|--------|-------|
| SonarCloud | SAST (code vulnerabilities, code smells) | PR / CI |
| Gitleaks | Secrets detection | Pre-build |
| Trivy FS | Dependency vulnerabilities | CI |
| Trivy Image | Container security scanning | Post-build |
| Checkov | Infrastructure security validation | Pre-deploy |
| OWASP ZAP | Runtime application security testing (DAST) | Post-deploy |
| Vault | Secrets management | Runtime |

---

## 🔄 CI/CD Pipeline Stages

### 1. Code Security (Pre-Build)
- SonarCloud Quality Gate enforcement
- Gitleaks secret scanning

### 2. Build Stage
- Install dependencies
- Run unit tests
- Multi-stage Docker build

### 3. Security Scanning
- Trivy filesystem scan (dependencies + config)
- Trivy container scan (image vulnerabilities)
- Checkov IaC validation (Helm/K8s manifests)

### 4. Artifact Publishing
- Push Docker images to GHCR
- Tagging: `latest`, `main`, `vX.X.X`, commit SHA

### 5. GitOps Deployment
- Update BB-INFRA repository with new image tag
- ArgoCD detects changes and syncs automatically

### 6. Post-Deployment Security
- OWASP ZAP scans deployed application endpoints

---

## 🔒 Security Highlights

- No secrets stored in Git (Vault only)
- SAST (SonarCloud) blocks insecure code
- Trivy ensures container security
- Checkov enforces IaC security policies
- OWASP ZAP validates runtime security
- Non-root containers enforced
- Read-only filesystem in production containers
- Automated secret rotation via Vault

---

## Monitoring & Observability

### Prometheus
Used for:
- Cluster metrics collection
- Node CPU, memory, disk monitoring
- Kubernetes workload observability
- Alert rule evaluation

### Grafana
Provides centralized visualization of:
- Cluster health
- Node resource usage
- Namespace-level metrics
- Pod status and restarts
- Workload performance

### Alerting (Alertmanager)

| Alert | Condition | Severity |
|------|-----------|----------|
| High CPU Usage | > 85% (3 min) | Warning |
| High Memory Usage | > 85% (3 min) | Warning |
| Disk Pressure | > 80% (2 min) | Warning |
| CrashLoopBackOff | Pod restarts detected | Critical |
| Deployment Mismatch | Desired ≠ Available pods | Critical |

Alerts are sent via **SMTP (OVH email relay)**.

---

## Demo

👉 [Watch Demo Video](https://drive.google.com/file/d/1-xOuCM41jrCEWRJ25_AfS3UmudnTWNkb/view?usp=sharing)
