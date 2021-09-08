pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Tooling Version') {
      steps {
        sh '''docker --version
              docker-compose --version'''
      }
    }

    stage('Build DockerFile') {
      steps {
        sh '''docker run hello-world
        docker stop $(docker ps -a -q)
        docker container prune -f
        docker volume prune -f'''
        sh 'make build'
      }
    }

    stage('Run Enviorement') {
      steps {
        sh 'make run'
      }
    }

    stage('Run Tests') {
      steps {
        sh '''docker-compose run app rake db:drop db:create db:migrate RAILS_ENV=test
                docker-compose run app rspec spec --format json --out rspec.json
                docker-compose down --remove-orphans
'''
      }
    }

    stage('Tests & Coverage') {
      parallel {
        stage('Coverage Result') {
          steps {
            sh 'sudo bash scripts/cov_result.sh'
          }
        }

        stage('Test Results') {
          steps {
            sh 'sudo bash scripts/test_result.sh'
          }
        }

      }
    }

  }
  post {
    always {
      sh '''sudo rm -r tmp/cache
            sudo rm -r coverage'''
    }

  }
}