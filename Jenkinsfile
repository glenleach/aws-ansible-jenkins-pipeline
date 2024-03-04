pipeline {   
  agent any
  stages {
    stage("copy files to ansible server") {
      steps {
        script {
          echo "copying all neccessary files to ansible control node"
          sshagent(['ansible-server-key']) {
            sh "scp -o StrictHostKeyChecking=no ansible/* root@138.68.94.71:/root"

            withCredentials([sshUserPrivateKey(credentialsId: 'ec2-server-key', keyFileVariable: 'keyfile', usernameVariable: 'user')]) {
              sh "scp {$keyfile} root@138.68.94.71:/root/ssh-key.pem"
            }
          }
        }
      }
    }      
  }
} 
