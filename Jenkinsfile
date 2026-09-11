pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'sonar-scanner'

                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    echo "Building Docker image..."

                    docker build -t fastapi-app:${BUILD_NUMBER} .

                    echo "Docker images:"
                    docker images | grep fastapi-app
                '''
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh '''
                    echo "Scanning Docker image..."

                    trivy image --severity HIGH,CRITICAL fastapi-app:${BUILD_NUMBER}
                '''
            }
        }
    }
}
