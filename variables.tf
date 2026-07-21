variable "repo_names" {
  type        = list(string)
}

variable "github_token" {
  type        = string
  description = "GitHub Personal Access Token"
  sensitive   = true
}