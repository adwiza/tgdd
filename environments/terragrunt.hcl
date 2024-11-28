locals {
  terraform_state_key = replace("${path_relative_to_include()}/terraform.tfstate", "./", "")
}

inputs = {
  terraform_state_key = local.terraform_state_key
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    backend "s3" {
        bucket  = "terragrunt"
        endpoints = { s3 = "http://192.168.3.14:9000" }
        access_key = ""
        secret_key = ""  
        key = "${local.terraform_state_key}"
        region  = "us-east-1"
        encrypt = false
        skip_credentials_validation  = true
        skip_requesting_account_id   = true
        skip_metadata_api_check      = true
        skip_region_validation       = true
        use_path_style               = true
    }
}
EOF
}