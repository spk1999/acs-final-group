terraform {
  backend "s3" {
    bucket = "acs730-week6-sshrestha63"
    #key    = "01-networking/terraform.tfstate"
    key    = "prod/01-networking/terraform.tfstate"
    region = "us-east-1"
  }
}