output "ipaddress" {
  value = aws_instance.ec2-instance.private_ip
}

output "instance_id" {
  value = aws_instance.ec2-instance.id
}

 output "private_key" {
   sensitive = true
   value     = tls_private_key.key_type.private_key_pem
 }

 output "adm_password" {
   sensitive = true
   value = "${rsadecrypt(aws_instance.ec2-instance.password_data, file("windows-key.pem"))}"
}