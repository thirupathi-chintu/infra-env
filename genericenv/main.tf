
provider "aws" {
  region     =  "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

if  ( ENV == "dev") {
    module "dev" {
    source = "./dev"
    ENV = "dev"
  }
}

elsif  ( ENV == "jenkins") {
    module "jenkins" {
    source = "./jenkins"
    ENV = "jenkins"
  }
}

elsif  ( ENV == "prod") {
    module "prod" {
    source = "./prod"
    ENV = "prod"
  }
}

