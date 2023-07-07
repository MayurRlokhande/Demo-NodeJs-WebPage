pipeline {
    agent any
    tools{
        nodejs 'nodejs-10'
    }
 

    stages {
        stage('Git Checkout') {
            steps {
               git branch: 'main', changelog: false, poll: false, url: 'https://github.com/MayurRlokhande/Demo-NodeJs-WebPage.git'
            }
        }
         stage('Install Dependencies') {
            steps {
                sh "npm install"
            }
        }
         stage('Owasp Dependency Check') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ ', odcInstallation: 'DP'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
         stage('Docker Build & Push') {
            steps {
                 script{
                   withDockerRegistry(credentialsId: 'eee27830-225b-4162-b1ef-a9ee54273c52', toolName: 'docker') {
                            sh "docker build -t demonodejs ."
                            sh "docker tag demonodejs mayurrl/nodejsnew:latest"
                            sh "docker push mayurrl/nodejsnew:latest"
                        }
                            
                    }            
                
                }
             
          }
           stage('Docker Deploy') {
            steps {
                 script{
                   withDockerRegistry(credentialsId: 'eee27830-225b-4162-b1ef-a9ee54273c52', toolName: 'docker') {
                           
                           sh "docker run -d --name demonodeapp -p 8089:8089 mayurrl/nodejsnew:latest"
                        }
                            
                    }            
                
                }
             
          }
    }
}
