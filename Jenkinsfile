pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build Images') {
	steps {
	 sh 'docker build -t intrudersecurity/reconswift:v1'
      }
    }
    stage('Push Image') {
	steps {
	  withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
		sh 'docker login -u $DOCKER_USERNAME -p DOCKER_PASSWORD'
		sh 'docker push intrudersecurity/reconswift:v1'
	  }
	}
    }
  }  
}

