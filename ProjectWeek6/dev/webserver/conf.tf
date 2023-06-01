terraform {
  backend "s3" {
    bucket = "group-17-s3-bucket1"
    #key    = "01-networking/terraform.tfstate"
    key    = "dev/01-webserver/terraform.tfstate"
    region = "us-east-1"
  }
}