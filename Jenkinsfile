pipeline {
    agent any
    environment {
        docker_username = "arian471"
    }
    stages {
        stage('Clone down') {
            steps {
                stash excludes: '.git', name: 'code'
            }
        }
        stage('Build and Test') {
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
        stage('Artifacts + Dockerize') {
            parallel {
                stage('Create artifacts') {
                    steps {
                        unstash 'code'
                        archiveArtifacts artifacts: 'app/build/libs/', allowEmptyArchive: true    
                    }
                }
                stage('Dockerize application') {
                    environment {
                        DOCKERCREDS = credentials("docker_login")
                    }
                    when {
                        branch 'master'
                    }
                    steps {
                        unstash 'code'
                        sh label: '', script: 'docker build -t arian471/pythonapp .'
                        sh label: '', script: 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
                        sh label: '', script: 'docker push arian471/pythonapp'
                    }
                }
            }
        }
    }
}
