# Minimal terragrunt multi-modules from multi-source

Note: his repo is used only for issue submissions.

## repos:

https://github.com/bdelv/tg-source-main
terragrunt minimal project. Instantiates2 modules in 2 different repos.

https://github.com/bdelv/tg-source-module1
minimal terraform module. creates a random string made of letters

https://github.com/bdelv/tg-source-module2
minimal terraform module. creates a random string made of numbers

In a folder:
```Bash
git clone git@github.com:bdelv/tg-source-main.git
git clone git@github.com:bdelv/tg-source-module1.git
```
# Working

## without the --terragrunt-source parameter 

In tg-source-module1 and tg-source-module2
```Bash
terraform plan
terraform apply
```

In tg-source-main, anywhere:
```Bash
terragrunt plan-all
terragrunt apply-all
```

In tg-source-main, in a module folder:
```Bash
terragrunt plan
terragrunt apply
terragrunt plan-all
terragrunt apply-all
```

## with the --terragrunt-source parameter 

plan and apply in a specific single folder

In tg-source-main/module1
```Bash
terragrunt plan --terragrunt-source absolute_path_to_local_module1//
terragrunt apply --terragrunt-source absolute_path_to_local_module1//
```

# Not working

## plan-all and apply-all with --terragrunt-source parameter

```Bash
terragrunt plan-all --terragrunt-source absolute_path_to_local_module1//
terragrunt apply-all --terragrunt-source absolute_path_to_local_module1//
```

Result:
```Bash
[terragrunt] 2020/01/16 11:31:00 Encountered the following errors:
Did not find any Terraform files (*.tf) in /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA/tg-source-module1
Cannot process module Module /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module2 (excluded: false, dependencies: [/Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1]) because one of its dependencies, Module /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1 (excluded: false, dependencies: []), finished with an error: Did not find any Terraform files (*.tf) in /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA/tg-source-module1
```

They seem to copy the module files and set the working directory in a different path with single commands (plan and apply) than with the global commands (plan-all and apply-all)

plan in tg-source-main/module1 (working):
```Bash
[terragrunt] 2020/01/16 11:29:55 Downloading Terraform configurations from file:///Users/brice/dev/repos/terragrunt-bug/tg-source-module1 into /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA
[terragrunt] 2020/01/16 11:29:55 Copying files from /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1 into /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA
[terragrunt] 2020/01/16 11:29:55 Setting working directory to /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA
```

plan-all:
```Bash
[terragrunt] [/Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1] 2020/01/16 11:24:29 Downloading Terraform configurations from file:///Users/brice/dev/repos/terragrunt-bug/tg-source-module1 into /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA
[terragrunt] [/Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1] 2020/01/16 11:31:00 Copying files from /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1 into /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA/tg-source-module1
[terragrunt] [/Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1] 2020/01/16 11:31:00 Setting working directory to /Users/brice/dev/repos/terragrunt-bug/tg-source-main/module1/.terragrunt-cache/7rdUxUWymm90npCS62plRg8EUEI/2FVY947kVfZpASeTETWKtMpHQsA/tg-source-module1
```
