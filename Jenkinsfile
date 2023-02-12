pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('DOCKER_HUB_JENKINS')
    }

    stages {
        stage('Build') {
            steps {
                sh 'docker build -t sabovyan/main_app:0.1 ./app'

                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

                sh 'docker push sabovyan/main_app:0.1'
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

    post {
        always {
            sh 'docker logout'
        }
    }
}
