terraform {
  backend "s3" {
    bucket = "yansoonbucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
