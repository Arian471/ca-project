pipeline {
    agent any
    stages {
        stage('clone down') {
            steps {
                stash excludes: '.git', name: 'code'
            }
        }
        stage('build app') {
            agent any
            options {
                skipDefaultCheckout(true)
            }
            steps {
                unstash 'code'
                sh label: '', script: 'ls -lah'
                sh label: '', script: 'docker build -t app .'
            }    
        }
        stage('error') {
            parallel {
                stage('Create artifacts') {
                    steps {
                        unstash 'code'
                        archiveArtifacts artifacts: 'app/build/libs/', allowEmptyArchive: true    
                    }
                }
                stage('Dockerize application') {
                    steps {
                        unstash 'code'
                        echo 'epic docker'
                    }
                }
            }
        }
    }
    environment {
        DOCKERCREDS = 'credentials(\'docker_login\')'
    }
}
