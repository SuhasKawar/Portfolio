pipeline {
    agent any
    
    environment {
        DOCKER_IMAGE = "your-dockerhub-username/portfolio"
        DOCKER_TAG = "latest"
        REGISTRY_CREDENTIALS = credentials('docker-hub-credentials')
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/portfolio.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', REGISTRY_CREDENTIALS) {
                        dockerImage.push()
                    }
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    sh """
                    ssh user@your-server '
                        docker pull ${DOCKER_IMAGE}:${DOCKER_TAG}
                        docker stop portfolio-container || true
                        docker rm portfolio-container || true
                        docker run -d --name portfolio-container -p 80:80 ${DOCKER_IMAGE}:${DOCKER_TAG}
                    '
                    """
                }
            }
        }
    }
    
    post {
        always {
            sh 'docker system prune -f'
        }
        success {
            echo '✅ Portfolio deployed successfully!'
        }
        failure {
            echo '❌ Deployment failed!'
        }
    }
}