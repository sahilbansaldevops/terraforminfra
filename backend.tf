terraform {
  backend "s3" {
    bucket = "sahilterraform-backend"
    key    = "StateFiles/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraformstatelocking"
  }
}