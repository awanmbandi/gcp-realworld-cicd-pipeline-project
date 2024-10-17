pipeline {
    agent any
    tools {
        git 'Git'
    }
    stages {
        stage('Validate Project') {
            steps {
                sh 'mvn validate'
            }
        }
        stage('Unit Test'){
            steps {
                sh 'mvn test'
            }
        }
        stage('Integration Test'){
            steps {
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage('App Packaging'){
            steps {
                sh 'mvn package'
            }
        }
        stage ('Checkstyle Code Analysis'){
            steps {
                sh 'mvn checkstyle:checkstyle'
            }
        }
        stage('SonarQube Inspection') {
            steps {
                sh  """mvn clean verify sonar:sonar \
                        -Dsonar.projectKey=javawebapp \
                        -Dsonar.host.url=http://10.162.0.2:9000 \
                        -Dsonar.login=sqp_b93c2b7a3fe542f11967c22dd5894cb62406c7f0"""
            }
        }
        stage("Upload Artifact To Nexus"){
            steps{
                 sh 'mvn deploy'
            }
            post {
                success {
                  echo 'Successfully Uploaded Artifact to Nexus Artifactory'
                }
            }
        }
    }
}
