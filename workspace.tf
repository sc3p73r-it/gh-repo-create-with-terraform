terraform {

  cloud {
    
    organization = "hellodevops"

    workspaces {
      name = "gh-repo-create"
    }
  }
}
