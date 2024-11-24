generate "backend" {
  path      = "s3-backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
    backend "s3" {
        bucket  = "terraform-statefiles-aws-vpc"
        endpoints = { s3 = "http://192.168.3.14:9000" }
        access_key="RPPQEbARsxnaB6XT0WtD"           # Access and secret keys
        secret_key="4xdgnfTABBbDxJrY6O4QvVuIHULAYDxExmqppeg0"  
        key     = "${path_relative_to_include()}/terraform.tfstate" # "terraform.tfstate" #
        region  = "us-east-1"
        encrypt = false
        skip_credentials_validation  = true   # Skip AWS-related checks and validations
        skip_requesting_account_id   = true
        skip_metadata_api_check      = true
        skip_region_validation       = true
        use_path_style               = true   
    }
}
EOF
}