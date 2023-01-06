resource "local_file" "ansible_inventory" {
    depends_on = [
      aws_instance.ec2-instance
    ]
  content         = aws_instance.ec2-instance.private_ip
  filename        = "../ansible/ansible_inventory.txt"
  file_permission = "0777"
}

# resource "null_resource" "nullremote1" {
#     depends_on = [
#       local_file.ansible_inventory
#     ]
#     connection {
#     host = aws_instance.ec2-instance.private_ip
#     type = "winrm"
#     user = "Administrator"
# 	#user = "${var.admin_user}"
#     password = "UcA67u!zRJZxJ6Swhlt$Hw*!y!7QCPw?"
#     #password = aws_instance.ec2-instance.get_password_data
#     port = 5985
#     }   
#     provisioner "file" {
#     source      = "/var/lib/cloudbees-core-cm/workspace/Terraform-Ansible-ETL/ansible/ansible_inventory.txt"
#     destination = "C:/App/ansible_inventory.txt" 
#   		   }
#     }
resource "null_resource" "nullremote2" {
    depends_on = [
       #null_resource.nullremote1
       local_file.ansible_inventory
    ]
  provisioner "local-exec" {
          #working_dir = "../ansible"
          command = "sleep 240; ansible_winrm_server_cert_validation=ignore ansible-playbook -i '/var/lib/cloudbees-core-cm/workspace/Terraform-Ansible-ETL/ansible/ansible_inventory.txt' --extra-vars 'ansible_connection=winrm ansible_port=5986 ansible_user=Administrator ansible_password=UcA67u!zRJZxJ6Swhlt$Hw*!y!7QCPw? ansible_winrm_transport=basic' /var/lib/cloudbees-core-cm/workspace/Terraform-Ansible-ETL/ansible/playbook.yml"

       }

}
