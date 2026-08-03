# 🧳 Wanderlust DevSecOps GitOps Infrastructure

> A production-style DevSecOps and GitOps implementation for the Wanderlust application using Jenkins, SonarQube, Trivy, Docker, Kubernetes, ArgoCD, Prometheus, Grafana, and Alertmanager.

---

## 📖 Project Overview

The **Wanderlust DevSecOps GitOps Infrastructure** repository manages the Kubernetes deployment and operational lifecycle of the Wanderlust application using GitOps principles.

This project demonstrates a complete end-to-end DevSecOps workflow, starting from source code integration and security scanning to automated deployment, continuous monitoring, and alerting.
 
The infrastructure is designed to simulate a real-world production environment by integrating CI/CD, containerization, Kubernetes orchestration, GitOps automation, observability, and proactive monitoring.

### Key Objectives

- Automate application deployment using GitOps.
- Improve software quality through static code analysis.
- Perform container security scanning before deployment.
- Deploy applications on Kubernetes using ArgoCD.
- Monitor cluster and application health using Prometheus.
- Visualize metrics using Grafana dashboards.
- Generate alerts using Alertmanager and custom Prometheus alert rules.

---

## 🏗️ Solution Architecture
  <img width="700" height="700" alt="ChatGPT Image Aug 4, 2026, 12_09_12 AM" src="https://github.com/user-attachments/assets/197519d4-05bd-4c22-854b-4ad1dcad6b1b" />
---

## 🏗️ Architecture

The project follows a modern DevSecOps and GitOps workflow where every code change is automatically validated, secured, deployed, monitored, and continuously reconciled with the desired Kubernetes state.

The workflow consists of the following stages:

1. Source Code Management
2. Continuous Integration (Jenkins)
3. Static Code Analysis (SonarQube)
4. Container Security Scanning (Trivy)
5. Docker Image Build & Push
6. GitOps Manifest Update
7. Continuous Deployment (ArgoCD)
8. Kubernetes Deployment
9. Monitoring (Prometheus)
10. Visualization (Grafana)
11. Alerting (Alertmanager)

This architecture separates application delivery from infrastructure management, ensuring reproducibility, traceability, and automated recovery from configuration drift.
