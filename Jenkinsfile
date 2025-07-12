pipeline {   
  agent any
  environment {
    ANSIBLE_SERVER = "18.133.75.61"
    }
    stages {
    stage("copy files to ansible server") {
    steps {
    script {
    echo "copying all neccessary files to ansible control node"
    sshagent(['jenkins-ansible']) {
    sh "scp -o StrictHostKeyChecking=no ansible/* ubuntu@${ANSIBLE_SERVER}:/home/ubuntu/"
    
    withCredentials([sshUserPrivateKey(credentialsId: 'ansible-app-servers', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
    sh 'scp $keyfile ubuntu@$ANSIBLE_SERVER:/home/ubuntu/ssh-key.pem'
    sh 'ssh ubuntu@$ANSIBLE_SERVER "chmod 600 /home/ubuntu/ssh-key.pem"'
    }
    }
    }
    }
    }
    stage ("execute ansible playbook") {
    steps {
    script {
    echo "calling ansible playbook to configure ec2 instances"
    def remote = [:]
    remote.name = "ansible-ec2-instance"
    remote.port = 22
    remote.host = ANSIBLE_SERVER
    remote.allowAnyHosts = true
    
    withCredentials([sshUserPrivateKey(credentialsId: 'jenkins-ansible', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
    remote.user = user
    remote.identityFile = keyfile
    sshScript remote: remote, script: "prepare-ansible-server.sh"
    sshCommand remote: remote, command: "ansible-playbook my-playbook.yaml"
    }
    }
    }
    }      
    }
    }
