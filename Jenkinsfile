pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
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
        stage ('Approval') {
            steps{
                input message: "apply to ${WORKSPACE}?"
            }
        }
        stage ('Terraform apply') {
           steps{
             sh 'terraform apply --var-file="env/${WORKSPACE}.tfvars"'
           }
        }

    // post {
    //     success {
    //         echo 'Pipeline completed successfully!'
    //     }
    //     failure {
    //         echo 'Pipeline failed!'
    //     }
    // }
}
}
