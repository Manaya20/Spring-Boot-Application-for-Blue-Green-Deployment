pipeline {
    agent any
    environment {
        IMAGE = "mydockerhubuser/myapp:${BUILD_NUMBER}"
        COLOR = "green"  // This will switch between blue/green deployments
    }
    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/your-org/myapp-blue-green-deployment.git'  // Replace with your repo URL
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'mvn clean package -DskipTests'  // Build the app with Maven
                sh 'docker build -t $IMAGE .'  // Build the Docker image
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u mydockerhubuser --password-stdin'  // Replace with your Docker Hub username
                    sh 'docker push $IMAGE'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl set image deployment/myapp-$COLOR myapp=$IMAGE --record'
            }
        }
        stage('Switch Traffic') {
            steps {
                input "Switch traffic to $COLOR version?"
                sh 'kubectl patch service myapp-service -p "{\"spec\": {\"selector\": {\"app\": \"myapp\", \"color\": \"$COLOR\"}}}"'
            }
        }
    }
}
