pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'stg', 'prod'],
            description: 'Select the environment'
        )
    }

    stages {
        stage('Hello World') {
            steps {
                echo "Hello World from trigger ${params.ENVIRONMENT}"
            }
        }

        stage('Hello Jenkins') {
            steps {
                echo "Hello Jenkins from ${params.ENVIRONMENT}"
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
