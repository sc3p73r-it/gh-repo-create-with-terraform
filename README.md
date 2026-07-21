# GitHub Organization Bulk Repository Provisioner

This Terraform project automates the creation of multiple repositories inside a GitHub Organization (`vitaltechmyanmar`). It is designed to handle **100 custom-named repositories** (e.g., `devops-learn`, `laravel-codedeploy`, `k8s-iac`, etc.) in a single execution.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Execution Instructions](#execution-instructions)


---

## Prerequisites

Before running this project, ensure you have the following:

1.  **Terraform** (v1.0.5 or later) installed locally.
2.  **GitHub Personal Access Token (Classic)** with the following minimum permissions:
    - `repo` (Full control of private repositories).
    - `admin:org` (Full control of organizations and teams).
    - `delete_repo` (Required if you plan to destroy resources).
3.  **Organization Admin Rights**: Your GitHub user **must** be an **Owner** (Admin) of the `vitaltechmyanmar` organization.
4.  **SAML SSO Authorization** (Critical): If your organization uses SAML Single Sign-On, you **must** authorize your token for the organization before running Terraform (see [Troubleshooting](#troubleshooting)).

---

## Project Structure

```text
.
├── providers.tf          # Terraform and GitHub provider configuration
├── variables.tf          # Input variable definitions
├── repository.tf         # Main resource block (creates the repositories)
├── outputs.tf            # Displays repository URLs after creation
└── terraform.tfvars      # Your list of 100 custom repository names
```

## Execution Instructions
```bash
# Step 1: Set your GitHub Token as an environment variable
export GITHUB_TOKEN="your_personal_access_token_here"

# Step 2: Initialize Terraform (downloads the GitHub provider plugins)
terraform init

# Step 3: Preview the execution plan
# Verify that it shows "Plan: 100 to add, 0 to change, 0 to destroy."
terraform plan

# Step 4: Apply the configuration and create all 100 repositories
terraform apply -auto-approve

```

