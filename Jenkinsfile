#!groovy

def err
def status = "Success"


    node {
        withCredentials([
               
                [
                        $class          : 'UsernamePasswordMultiBinding',
                        credentialsId   : 'bitbucket-integration',
                        passwordVariable: 'GIT_PASSWORD',
                        usernameVariable: 'GIT_USER'     
                ],
                [
                        $class          : 'UsernamePasswordMultiBinding',
                        credentialsId   : 'devops-tf-user',
                        passwordVariable: 'SECRET_KEY_PASSWORD',
                        usernameVariable: 'ACCESS_KEY_USER'
                ]
        ]) {
            
            stage('pull from SCM') {
			checkout scm
			}
			
            stage('Terraform Init ') {
                sh'''
                cd terraform && /usr/bin/terraform init  -reconfigure
				
				'''
            }
                 
            stage('Terraform Plan ') {
                sh'''
				cd terraform && /usr/bin/terraform plan
									
				'''
            }
                 
            // stage('Terraform Apply ') {
            //     input 'PROCEED TO APPLY CHANGES'
            //     sh"""
            //     cd terraform && /usr/bin/terraform apply -input=true -auto-approve -var "aws_access_key=$ACCESS_KEY_USER" -var "aws_secret_key=$SECRET_KEY_PASSWORD" -var "git_username=$GIT_USER" -var "git_password=$GIT_PASSWORD"
			// 	"""
            // }
        }
	}

