output "created_repos" {
  value = [for repo in github_repository.bulk_repos : repo.name]
}

output "repository_urls" {
  value = {
    for name, repo in github_repository.bulk_repos : name => repo.html_url
  }
}