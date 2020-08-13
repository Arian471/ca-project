pipeline {
    agent any
    stages {
        stage('Clone down') {
            steps {
                stash excludes: '.git', name: 'code'
            }
        }
        stage('Build') {
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
        stage('Test') {
            agent any
            steps {
                unstash 'code'
                sh label: '', script: 'pip install -r requirements.txt'
                sh label: '', script: 'python tests.py'
            }
        }
        stage('Parallel') {
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
                        echo 'epicer docker'
                    }
                }
            }
        }
    }
    environment {
        DOCKERCREDS = 'credentials(\'docker_login\')'
    }
}
