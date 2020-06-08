terraform {
  backend "remote" {
    hostname      = "app.terraform.io"
    organization  = "ship-it"

    workspaces {
      name = "dev-env"
    }
  }
}
