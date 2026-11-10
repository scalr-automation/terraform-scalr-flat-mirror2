include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "db" {
  config_path = "../db"
  skip_outputs = true
}

dependency "shared" {
  config_path = "../../ext/shared"
  skip_outputs = true
}
