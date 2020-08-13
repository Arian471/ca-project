pipeline {
  agent {
    docker {
      image 'python'
    }

  }
  stages {
    stage('clone down') {
      steps {
          stash excludes: '.git', name: 'code'
      }
    }
    stage('Hello World') {
      steps {
        echo 'suh dude'
      }
    }
    stage('build app') {
      agent {
        docker {
          image 'python'
        }
      }
      options {
        skipDefaultCheckout(true)
      }
      steps {
        unstash 'code'
        stash excludes: '.git', name: 'code'
      }
    }

    stage('error') {
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
