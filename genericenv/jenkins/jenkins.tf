
provider "aws" {
  region     =  "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}


module "iam" {
  source = "../../modules/iam"
  ENV = "jenkins"
  role = "${var.role}"
  policy = "${var.policy}"
}

module "security_rules" {
  source = "../../modules/security_rules"
  security_group_rules = "${var.security_group_rules}"
  ip_value = "0.0.0.0/0"
  security_group_id = "${aws_security_group.access-jenkins.id}"
}

module "vpc" {
  source = "../../modules/vpc"
  ENV = "jenkins"
  subcidr = "10.0.1.0/24"
  azs = "eu-west-1a"
  cidr = "10.0.0.0/16"
}

