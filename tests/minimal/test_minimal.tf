terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "LACP-ACTIVE"
  mode = "active"
}

data "aci_rest" "lacpLagPol" {
  dn = "uni/infra/lacplagp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "lacpLagPol" {
  component = "lacpLagPol"

  equal "name" {
    description = "name"
    got         = data.aci_rest.lacpLagPol.content.name
    want        = module.main.name
  }

  equal "mode" {
    description = "mode"
    got         = data.aci_rest.lacpLagPol.content.mode
    want        = "active"
  }
}
