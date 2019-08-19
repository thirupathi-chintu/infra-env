
module "iam" {
  source = "../../modules/iam"
  ENV = "${var.ENV}"
  role = "${var.role}"
  policy = "${var.policy}"
}

module "security_rules" {
  source = "../../modules/security_rules"
  security_group_rules = "${var.security_group_rules}"
  ip_value = "0.0.0.0/0"
  security_group_id = "${aws_security_group.access-jenkins1.id}"
}

module "vpc" {
  source = "../../modules/vpc"
  ENV = "${var.ENV}"
  subcidr = "10.0.102.0/24"
  azs = "eu-west-1b"
  cidr = "10.0.0.0/16"
}

