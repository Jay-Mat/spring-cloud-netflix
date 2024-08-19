pipeline {
    agent any 

    triggers {
        pollSCM '* * * * *'
    }
    tools {
        maven 'Maven'
    }


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
        stage('Sonar Analysis') {
            environment {
                scannerHome = tool "SonarScanner";
            }
            steps {
                withSonarQubeEnv('SonarScanner') {
                sh "${scannerHome}/bin/sonar-scanner"         
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