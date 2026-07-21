resource "github_repository" "bulk_repos" {
  for_each = toset(var.repo_names) # Converts your list into a unique set

  name        = each.key            # each.key will be "devops-learn", "php-fpm", etc.
  description = "Repository: ${each.key}"
  visibility  = "private"           # Change to "public" if needed
}

output "created_repos" {
  value = [for repo in github_repository.bulk_repos : repo.name]
}