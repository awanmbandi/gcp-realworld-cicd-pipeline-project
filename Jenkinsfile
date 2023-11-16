pipeline {
    agent any
  
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
                        -Dsonar.host.url=http://10.162.0.16:9000 \
                        -Dsonar.login=sqp_4f9eae6daf8ce37fda23102e2fc1e87a001645ef"""
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
