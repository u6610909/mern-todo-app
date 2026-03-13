pipeline {
    agent any
    
    tools {
        nodejs 'node'
    }
    
    environment {
        // REPLACE WITH YOUR ACTUAL DOCKER HUB USERNAME
        DOCKER_IMAGE = 'pratchanon/finead-todo-app:latest'
        
        // This grabs the credentials we will create in Jenkins later
        DOCKER_CREDS = credentials('dockerhub-creds') 
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Installing dependencies in the appropriate folders...'
                // Doing exactly what the README and exam instructed
                sh '''
                cd TODO/todo_backend
                npm install
                cd ../todo_frontend
                npm install
                '''
            }
        }
        
        stage('Containerise') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }
        
        stage('Push') {
            steps {
                echo 'Logging into Docker Hub and pushing image...'
                sh "echo \$DOCKER_CREDS_PSW | docker login -u \$DOCKER_CREDS_USR --password-stdin"
                sh "docker push ${DOCKER_IMAGE}"
            }
        }
    }
    
    post {
        always {
            // Clean up credentials
            sh "docker logout"
        }
    }
}   