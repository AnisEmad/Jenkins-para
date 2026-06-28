pipeline {
    agent any

    parameters {
        choice(
            name: 'WORKSPACE',
            choices: ['dev', 'stg', 'prod'],
            description: 'Select the workspace'
        )
    }

    stages {
        stage ('checkout code') {
            steps {
                checkout scm
            }
        }

        stage ('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage ('Select Or Create workspaces') {
            steps {
                sh 'terraform workspace select ${WORKSPACE} || terraform workspace new ${WORKSPACE}'
            }
        }
        stage ('Terraform plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage ('Terraform apply') {
            input message: "Apply to ${WORKSPACE}"
            sh "terraform apply --var-file env/${WORKSPACE}.tfvars
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
