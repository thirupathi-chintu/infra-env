
provider "aws" {
  region     =  "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
# if [ ENV = "dev" ]
# then
#   module "dev" {
#     source = "./dev"
#     ENV = "dev"
#   }
#  fi


    module "dev" {
    source = "./dev"
    ENV = "dev"
  }


    module "jenkins" {
    source = "./jenkins"
    ENV = "jenkins"
  }


    module "prod" {
    source = "./prod"
    ENV = "prod"
  }


