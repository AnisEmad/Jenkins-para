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
        stage('Checkout code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Select or Create Workspace') {
            steps {
                sh 'terraform workspace select ${WORKSPACE} || terraform workspace new ${WORKSPACE}'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Approval') {
            steps {
                script {
                    input message: "Apply to ${params.WORKSPACE}?"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -var-file="envs/${WORKSPACE}.tfvars"'
            }
        }
    }

    post {
        failure {
            emailext(
                to: 'anisemad123@gmail.com',
                subject: "❌ Pipeline Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    <h3>Pipeline Failed</h3>
                    <p><b>Job:</b> ${env.JOB_NAME}</p>
                    <p><b>Build:</b> #${env.BUILD_NUMBER}</p>
                    <p><b>Workspace:</b> ${params.WORKSPACE}</p>
                    <p><b>Check the logs:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                """,
                mimeType: 'text/html'
            )
        }

        success {
            emailext(
                to: 'anisemad123@gmail.com',
                subject: "✅ Pipeline Succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: """
                    <h3>Pipeline Succeeded</h3>
                    <p><b>Job:</b> ${env.JOB_NAME}</p>
                    <p><b>Build:</b> #${env.BUILD_NUMBER}</p>
                    <p><b>Workspace:</b> ${params.WORKSPACE}</p>
                    <p><b>Check the logs:</b> <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                """,
                mimeType: 'text/html'
            )
        }
    }
}
