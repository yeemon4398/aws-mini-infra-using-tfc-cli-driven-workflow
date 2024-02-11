terraform {
  cloud {
    organization = "mini-projects"

    workspaces {
      name = "tfc-cli-driven-workflow"
    }
  }
}