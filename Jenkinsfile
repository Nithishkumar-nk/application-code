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

        stage('ECR Login') {
            steps {
                sh '''
                    echo "Logging in to Amazon ECR..."

                    aws ecr get-login-password --region ap-southeast-2 | docker login \
                        --username AWS \
                        --password-stdin \
                        285690764832.dkr.ecr.ap-southeast-2.amazonaws.com
                '''
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                    echo "Tagging Docker image..."

                    docker tag fastapi-app:${BUILD_NUMBER} \
                        285690764832.dkr.ecr.ap-southeast-2.amazonaws.com/fastapi-app:${BUILD_NUMBER}

                    echo "Pushing Docker image to ECR..."

                    docker push \
                        285690764832.dkr.ecr.ap-southeast-2.amazonaws.com/fastapi-app:${BUILD_NUMBER}
                '''
            }
        }
    }
}
