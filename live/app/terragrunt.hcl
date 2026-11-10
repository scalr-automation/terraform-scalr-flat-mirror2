locals {
  probe = run_cmd("sh", "${get_terragrunt_dir()}/probe.sh")
}

dependency "b" {
  config_path = local.probe
}
