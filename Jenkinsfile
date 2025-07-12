pipeline {
    agent any

    environment {
        REMOTE_USER = "ubuntu"
        REMOTE_HOST = "18.133.75.61"   // <-- your Ansible EC2 instance
    }

    stages {
        stage('SSH to Ansible Server') {
            steps {
                sshagent(credentials: ['ansible-ssh-key']) {
                    sh '''
                        echo "Trying SSH connection to Ansible server..."
                        ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "hostname"
                    '''
                }
            }
        }

        stage('Copy Playbooks to Ansible Server') {
            steps {
                sshagent(credentials: ['ansible-ssh-key']) {
                    sh '''
                        echo "Copying Ansible files to server..."
                        scp -o StrictHostKeyChecking=no \
                          ansible/ansible.cfg \
                          ansible/inventory_aws_ec2.yaml \
                          ansible/my-playbook.yaml \
                          $REMOTE_USER@$REMOTE_HOST:/home/ubuntu/
                    '''
                }
            }
        }
    }
}
