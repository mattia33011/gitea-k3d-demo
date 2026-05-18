[![Medium Article](https://img.shields.io/badge/Medium-Read%20Article-black?logo=medium&style=flat-flat)](YOUR_MEDIUM_ARTICLE_LINK_HERE)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-k3s%20%2F%20k3d-blue?logo=kubernetes&style=flat-flat)](https://k3s.io/)
[![Gitea](https://img.shields.io/badge/Git-Gitea-green?logo=gitea&style=flat-flat)](https://gitea.io/)

This repository serves as a complete hands-on laboratory designed to demonstrate how to deploy **Gitea** inside a lightweight local **k3s/k3d** Kubernetes cluster and build an automated, fully native, and GitHub-compatible CI/CD pipeline using **Gitea Actions** and its built-in **Package Registry**.

---

## 📖 The Step-by-Step Guide

The complete logic, architectural choices, and full context behind this setup are explained in detail in my Medium article:

👉 **[Read the Full Article on Medium: "Gitea: The Ultimate GitHub Alternative for Your Home Lab?"](https://medium.com/@mattia.iaria30/gitea-the-ultimate-github-alternative-for-your-home-lab-63bd1ebe3c80)**

---

## 🎯 Repository Purpose & Scope

The main goal of this project is to provide a minimalist, highly efficient DevOps playground tailored for **home labs** and resource-constrained environments. 

While enterprise setups lean heavily towards GitLab, its high RAM overhead can be restrictive for hobbyists or small labs. This lab proves how **Gitea** matches standard Git workflows and automation capabilities at a fraction of the hardware footprint.

By following this laboratory, you will learn how to:
1. Spin up a multi-node local cluster using `k3d`.
2. Configure Gitea via customized Helm values.
3. Hook up a local **Gitea Actions Runner** mapped via specific Kubernetes node labels.
4. Set up proper **RBAC permissions** (Service Account, Roles, and Bindings) so the runner can safely orchestrate cluster deployments.
5. Store base64-encoded `kubeconfig` payloads securely inside Gitea Repository Secrets.
6. Push and host Docker artifacts inside Gitea's integrated **Package Registry**.
7. Run a complete 2-stage (**Build & Deploy**) pipeline that matches GitHub Actions syntax exactly.

---

## 📂 Project Structure

```text
.
├── manifests/
│   ├── deployer-rbac.yaml        # Role, RoleBinding, and Service Account for the runner
│   └── runner.yaml               # Gitea Action Runner deployment manifest
├── scripts/
│   └── generate_kubeconfig.sh    # Script to extract and encode a safe kubeconfig payload
├── helm/
│   └── values.yaml               # Tailored Helm values for Gitea cluster setup
└── .gitea/workflows/
    └── build-and-deploy.yaml     # The 2-stage CI/CD pipeline definition