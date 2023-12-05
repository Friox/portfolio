pipeline {
  agent any
  stages {
    stage('Set Variable') {
      steps {
        script {
          IMAGE_NAME = "friox-portfolio"
          IMAGE_STORAGE = "localhost:7000"
        }
      }
    }

    stage('Build Container Image') {
      steps {
        script {
          image = docker.build("${IMAGE_NAME}:${env.BRANCH_NAME}")
        }
      }
    }

    stage('Push Container Image') {
      steps {
        script {
          docker.withRegistry("http://${IMAGE_STORAGE}") {
            image.push()
          }
        }
      }
    }

    stage('Deploy and Clean') {
      steps {
        sh "docker container rm ${IMAGE_NAME}-${env.BRANCH_NAME} -f"
        sh "docker run -i -t -d --name ${IMAGE_NAME}-${env.BRANCH_NAME} -p 8001:3100 ${IMAGE_STORAGE}/${IMAGE_NAME}:${env.BRANCH_NAME}"
        sh "docker image prune -f"
      }
    }
  }
}