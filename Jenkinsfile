pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t lloydmatereke/jenkins-docker-hub ./app'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
