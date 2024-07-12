provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "k8master" {
  ami                    = var.ec2ami
  instance_type          = var.instancetype
  vpc_security_group_ids = [aws_security_group.sahil.id]
  key_name = "terraform-key"

  
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./terraform-key.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./script.sh"
    destination = "/tmp/script.sh"
  }
  
   provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }
}


resource "aws_security_group" "sahil" {
  name        = "for k8 cluster"

  ingress {
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
