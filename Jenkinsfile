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

    stage('') {
      parallel {
        stage('Create artifacts') {
          steps {
            archiveArtifacts 'app/build/libs/'
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