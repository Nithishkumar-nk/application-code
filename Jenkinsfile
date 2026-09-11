pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Show Project Files') {
            steps {
                sh '''
                    echo "Project files:"
                    ls -la
                '''
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

        stage('Docker Check') {
            steps {
                sh '''
                    docker --version
                    docker info
                '''
            }
        }

        stage('Trivy Check') {
            steps {
                sh '''
                    cd /tmp
                    trivy --version
                '''
            }
        }
    }
}
