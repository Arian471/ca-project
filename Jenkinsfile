pipeline {
  agent {
    docker {
      image 'python'
    }

  }
  stages {
    stage('Hello World') {
      steps {
        echo 'suh dude'
      }
    }

    stage('error') {
      parallel {
        stage('Create artifacts') {
          steps {
            archiveArtifacts 'app/templates/'
          }
        }

        stage('Dockerize application') {
          steps {
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