# terraform {
#   backend "s3" {
#     key            = "terraform-aws/aws-curion-test.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "aim-do-000-d01-usoh-tfrm-backend"
#     bucket         = "aim-do-000-d01-usoh-tfrm-backend-19279"
#   }
# }

# connection {
#     password            = "${rsadecrypt(self.password_data,file("/var/lib/cloudbees-core-cm/workspace/Terraform-Ansible-ETL/terraform/windows-key.pem"))}"
# 	}