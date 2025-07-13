pipeline {
    agent any

    environment {
        REMOTE_USER = "ubuntu"
        REMOTE_HOST = "3.8.130.237"   // <-- your Ansible EC2 instance
    }

    stages {
        stage('SSH to Ansible Server') {
            steps {
                sshagent(credentials: ['ansible-server-key']) {
                    sh '''
                        echo "Trying SSH connection to Ansible server..."
                        ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "hostname"
                    '''
                }
            }
        }

        stage('Copy Playbooks to Ansible Server') {
            steps {
                sshagent(credentials: ['ansible-server-key']) {
                    sh '''
                        echo "Copying Ansible files to server..."
                        scp -o StrictHostKeyChecking=no \
                          ansible/ansible.cfg \
                          ansible/inventory.aws_ec2.yaml \
                          ansible/my-playbook.yaml \
                          $REMOTE_USER@$REMOTE_HOST:/home/ubuntu/
                    '''
                }
                // Copy the app server private key to the Ansible server for use by Ansible
                withCredentials([
                    sshUserPrivateKey(credentialsId: 'ec2-app-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')
                ]) {
                    sshagent(credentials: ['ansible-server-key']) {
                        sh 'scp -o StrictHostKeyChecking=no $keyfile $REMOTE_USER@$REMOTE_HOST:/home/ubuntu/ssh-key.pem'
                        sh 'ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_HOST "chmod 600 /home/ubuntu/ssh-key.pem"'
                    }
                }
            }
        }
    stage('Execute Ansible Playbook') {
            steps {
                script {
                    echo "calling ansible playbook to configure ec2 instances"
                    def remote = [:]
                    remote.name = "ansible-server"
                    remote.host = env.REMOTE_HOST
                    remote.allowAnyHosts = true
                    withCredentials([
                        sshUserPrivateKey(credentialsId: 'ansible-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')
                    ]) {
                        remote.user = user
                        remote.identityFile = keyfile
                        sshScript remote: remote, script: "prepare-ansible-server.sh"
                        sshCommand remote: remote, command: "ansible-playbook -i /home/ubuntu/inventory.aws_ec2.yaml /home/ubuntu/my-playbook.yaml"

                    }
                }
            }
        }
    }
}
