include {
    path = find_in_parent_folders()
}

dependency "depend_module_1" {
  config_path = "../module1"
  mock_outputs = {
    module1-output = "mocked-module1-output"
  }
}

terraform {
  source = "git@github.com:bdelv/tg-source-module2//module2a/"
}

  // -------------------- inputs ---------------------
inputs = {
  size = 20
}
