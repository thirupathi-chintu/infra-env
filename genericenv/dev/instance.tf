resource "aws_security_group" "access-dev" {
 name = "access-dev"
 description = "allow ssh access"
 vpc_id = "${module.vpc.vpc-id}"
 tags {
    Name         = "allow-ssh"
    Environmnent = "${var.ENV}"
  }
}

# Todo: For multiple containers, will need to interate on:
resource "aws_instance" "dev" {
  ami           = "ami-06358f49b5839867c"
  instance_type = "${var.aws_instance_type}"
  iam_instance_profile = "${module.iam.iam_instance_profile}" 
  subnet_id = "${module.vpc.manager_aws_subnet}"
  # instance_tenancy = "default"
  associate_public_ip_address = true

  tags {
    Name         = "instance-${var.ENV}"
    Environmnent = "${var.ENV}"
  }
  vpc_security_group_ids = ["${aws_security_group.access-dev.id}"]
  # security_groups = ["${aws_security_group.access-dev.id}"]
  # security_groups = [ "access-dev" ]
  

  # Copy publick key to instance.
  key_name = "${aws_key_pair.dev.key_name}"
  
  connection {
    type = "ssh"
    user = "ubuntu"
    port = 22
    host = "${aws_instance.dev.public_ip}"
    private_key = "${file("${var.key_pair["private_key_file_path"]}")}"    
    timeout = "3m"
    agent = false
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"##### About to run container #####\"",
      "echo \"##### Shell was running #####\"",
    ]
  }
}

# Output the security group Id to be used to add rules.
output "dev_security_group" {
  value = "${aws_security_group.access-dev.id}"
}

output "dev_aws_instance" {
  value = "${aws_instance.dev.public_ip}"
}
