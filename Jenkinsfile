pipeline {
   agent any
    stages {
        stage('vcs') {
            steps {
                git branch: 'main', url:'https://github.com/srvarri/ec2.git'
            }

        }
        stage('call ec2') {
            steps {
                sh "chmod +x -R ${env.WORKSPACE}"
                sh './var2.sh'
            }
        }
    }
} 
