pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }

  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t jupyter:latest .'
      }
    }
    stage('Test') {
      steps {
        sh 'echo "Foo!"'
      }
    }
  }
}