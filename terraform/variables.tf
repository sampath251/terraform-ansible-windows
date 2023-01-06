variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "ami" {
  type    = string
  default = "ami-07be42c623075462f" 
}

variable "vpc" {
  default = "vpc-053dcacfa4bed47d0"
}

variable "subnet" {
  default = "subnet-0e64e42b1b41ad17f"
}

variable "aws_access_key" {
  type    = string
  default = ""
}

variable "aws_secret_key" {
  type    = string
  default = ""
}

variable "volume_size" {
  default = 70
}

variable "volume_type" {
  default = "gp2"
} 

variable "instance_key_name" {
  default = "windows-key"
}


variable "volume_device_name" {
  description = "Additional ebs volume device path"
  type = string
  default = "/dev/xvdh"
}

variable "password"{
  type = string
 }
variable "host"{
}

variable "git_username" {
  default = ""
}

variable "git_password" {
  default = ""  
}

