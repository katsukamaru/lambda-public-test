variable "region" {
  default = "ap-northeast-1"
}

provider "aws" {
  access_key = "YOUR_ACCESS_KEY"
  secret_key = "YOUR_SECRET_KEY"
  region     = "${var.region}"
}

