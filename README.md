# GitHub Organization Bulk Repository Provisioner

This Terraform project automates the creation of multiple repositories inside a GitHub Organization (`vitaltechmyanmar`). It is designed to handle **100 custom-named repositories** (e.g., `devops-learn`, `laravel-codedeploy`, `k8s-iac`, etc.) in a single execution.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Complete Configuration Files](#config-file)
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


---

## Project Structure

```text
.
├── providers.tf          # Terraform and GitHub provider configuration
├── workspace.tf          # Terraform Workspace
├── variables.tf          # Input variable definitions
├── repository.tf         # Main resource block (creates the repositories)
├── outputs.tf            # Displays repository URLs after creation
└── terraform.tfvars      # Your list of 100 custom repository names
```

## Complete Configuration Files
Copy and paste the following code blocks into their respective files.

### File 1: `provider.tf`
This configures Terraform to use the GitHub API and targets your specific organization.
```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.13.0"
    }
  }
}

provider "github" {
 owner = "vitaltechmyanmar"
 token = var.github_token
}
```
### File 2: `variables.tf`
```hcl
variable "repo_names" {
  type        = list(string)
}

variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}
```
### File 3: `terraform.tfvars`
This is where you paste your 100 unique names.
Replace the placeholders below with your actual list. Ensure every name is wrapped in double quotes and followed by a comma.
```hcl
repo_names = [
  "devops-learn",
  "laravel-codedeploy",
  "php-fpm",
  "k8s-iac",
  "terraform-with-aws",
  "react-dashboard",
  "nodejs-microservice",
  # ------------------------------------------------------------------
  # ⚠️ IMPORTANT: Add your remaining 93+ names here, one per line.
  # Example:
  # "python-flask-api",
  # "java-spring-boot",
  # "go-grpc-server",
  # ------------------------------------------------------------------
]
github_token = ""
```
### File 4: `repository.tf`
This file uses the `for_each` meta-argument to loop through your 100 names and create a GitHub repository for each one.
```hcl
resource "github_repository" "bulk_repos" {
  for_each = toset(var.repo_names) # Converts your list into a unique set

  name        = each.key            # each.key will be "devops-learn", "php-fpm", etc.
  description = "Repository: ${each.key}"
  visibility  = "private"           # Change to "public" if needed
}

output "created_repos" {
  value = [for repo in github_repository.bulk_repos : repo.name]
}
```
### File 5: `outputs.tf`
This allows you to easily view all 100 repository URLs after the creation is complete.
```hcl
output "created_repos" {
  description = "List of all created repository names"
  value       = [for repo in github_repository.bulk_repos : repo.name]
}

output "repository_urls" {
  description = "Map of repository names to their GitHub URLs"
  value = {
    for name, repo in github_repository.bulk_repos : name => repo.html_url
  }
}
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

