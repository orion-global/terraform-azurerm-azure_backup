terraform {
  cloud {
    organization = "orion-global"

    workspaces {
      name = "internal-terraform-modules" # Always use this workspace name for module creation and test
    }
  }
}