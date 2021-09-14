output "dn" {
  value       = aci_rest.lacpLagPol.id
  description = "Distinguished name of `lacpLagPol` object."
}

output "name" {
  value       = aci_rest.lacpLagPol.content.name
  description = "Port channel policy name."
}
