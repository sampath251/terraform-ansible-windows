#connecting to the Ansible control node using winrm connection
resource "null_resource" "nullremote1" {
depends_on = [aws_instance.ec2-instance] 
connection {
      type = "winrm"
      port = 5986      
      host = "${var.host}"
      user = "Administrator"        
      password = "${var.password}"  or UcA67u!zRJZxJ6Swhlt$Hw*!y!7QCPw?     or    SuperS3cr3t!!!!
      https = true
      insecure = true
      script_path = "C:/windows/temp/terraform_%RAND%.cmd"     
  }  
    #copying the ansible_inventory.txt file to the Ansible control node from local system 
  provisioner "file" {
    source      = "ansible_inventory"
    destination = "C:/App/ansible_terraform/aws_instance/ansible_inventory.txt"  
    #May the pathdef=C:/windows/temp/terraform_%RAND%.cmd
       }
	#Running ansible playbook on remote system using remote-exec in terraform file
  provisioner "remote-exec" {
     inline = [
       "C:/App/ansible_terraform/aws_instance//",
         "ansible-playbook instance.yml"
     ]
   }
  #Terraform code block to open webpage automatically on local system
   provisioner "local-exec" {
   command = "chrome http://${aws_instance.ec2-instance.public_ip}/web/"
   #command = "sleep 60; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u administrator -i '../ansible/ansible_inventory.ini' --private-key Cloudbees-CI.pem -e'git_username=${var.git_username} git_password=${var.git_password}'  ../ansible/playbook.yml"
}
}
