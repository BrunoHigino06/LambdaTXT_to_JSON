provider "aws" {
  region = "us-east-1"
  alias = "us"
}

provider "aws" {
  region = "us-west-2"
  alias = "west"
}