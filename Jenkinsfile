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
                        sh label: '', script: 'tar czf app.tar.gz app app.db config.py create_db.py db_repository downgrade_down.py migrate_db.py run.py upgrade_db.py'
                        archive 'app.tar.gz'
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
