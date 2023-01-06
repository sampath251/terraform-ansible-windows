resource "aws_instance" "ec2-instance" {
  depends_on = [
    aws_key_pair.generated_key
  ]
  ami                    = var.ami
  instance_type          = var.instance_type
  #vpc_security_group_ids = [aws_security_group.allow_ssh.id] ##to be populated another
  vpc_security_group_ids = ["sg-0a65db84b0273955e"]
  subnet_id = var.subnet
  key_name  = var.instance_key_name
  get_password_data       = true
    connection {
    password            =   "${rsadecrypt(self.password_data)}"
    }

  tags = {
    Name = "Terraform-managed EC2 instance for ETL"
  }
  ebs_block_device {
    device_name           = var.volume_device_name
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    delete_on_termination = true
    encrypted             = true
    kms_key_id            = "mrk-81950d7ef3dc480f93bd8621a5a2fade"
    tags = {
      Name = "additional storage"
    }
  }
  lifecycle {
    ignore_changes        = [tags]
    create_before_destroy = true
  }
}

#Generating the key 
resource "tls_private_key" "key_type" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.instance_key_name
  public_key = tls_private_key.key_type.public_key_openssh
}

resource "local_file" "private_key" {
  depends_on = [
    aws_key_pair.generated_key
  ]
  content         = tls_private_key.key_type.private_key_pem
  filename        = "windows-key.pem"
  file_permission = 0400
}

resource "local_file" "public_key" {
  depends_on = [
    aws_key_pair.generated_key
  ]
  content         = tls_private_key.key_type.public_key_pem
  filename        = "windows-v1-public.pem"
  file_permission = 0400
}


# #Store the pasword ssm
# resource "aws_ssm_parameter" "windows_ec2" {
#   depends_on = [aws_instance.winserver_instance[0]]
#   name       = "/Microsoft/AD/${var.environment}/ec2-win-password"
#   type       = "SecureString"
#   value = rsadecrypt(aws_instance.winserver_instance[0].password_data, nonsensitive(tls_private_key.instance_key
#   .private_key_pem))
# }

/* resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description = "SSH from AIM"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
} */


data "aws_instance" "windows-key" {
  instance_id = "i-instanceid"

  filter {
    name   = "image-id"
    values = ["ami-xxxxxxxx"]
  }

  filter {
    name   = "tag:Name"
    values = ["instance-name-tag"]
  }
}