pipeline {
    agent any 
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Jay-Mat/spring-cloud-netflix', branch: 'main' 
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                // Assuming SonarQube server is accessible at 'http://sonarqube-server:9000'
                // Replace with your SonarQube server URL and token
                withSonarQubeEnv('http://sonarqube-server:9000', 'sqa_9c14e26e0689b56ebcc235ca0b9cd1f383a3e969') {
                    sh 'mvn sonar:sonar'
                }
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker build -t spring-netflix:{BUILD_NUMBER} .'
                sh 'docker tag spring-netflix:{BUILD_NUMBER} jaymath237/netflix-clone:{BUILD_NUMBER}'
                sh 'docker login -u {USERNAME} -p {PASSWORD} docker.io'
                sh 'docker push jaymath237/netflix-clone:{BUILD_NUMBER}'
            }
        }
    }
    post {
        always {
            echo 'Pipeline completed'
        }
        success {
            echo 'Build successful!'
            // Send email notification on success
            mail to: '{MY_EMAIL}', subject: 'Jenkins Pipeline Success', body: "Build successful for ${env.JOB_NAME}!"
        }
        failure {
            echo 'Build failed!'
            // Send email notification on failure
            mail to: '{MY_EMAIL}', subject: 'Jenkins Pipeline Failure', body: "Build failed for ${env.JOB_NAME}!"
        }
    }
}