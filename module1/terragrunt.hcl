include {
    path = find_in_parent_folders()
}

terraform {
  source = "git@github.com:bdelv/tg-source-module1//"
}

  // -------------------- inputs ---------------------
inputs = {
  size = 10
}
