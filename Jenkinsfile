pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('Acesskeyidknk')
        AWS_SECRET_ACCESS_KEY = credentials('secretkeyknk')
        GITHUB_TOKEN = credentials('knkgithub')
        AWS_DEFAULT_REGION    = 'eu-west-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kanak5522/knk2.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init ' // Use -reconfigure if preferred
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan' // Output plan to file
                sh 'terraform show -no-color tfplan > tfplan.txt' // Optional: for human-readable output
            }
        }
        stage('Apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                script {
                    if (params.autoApprove) {
                        sh 'terraform apply -auto-approve tfplan'
                    } else {
                        sh 'terraform apply tfplan'
                    }
                }
            }
        }
        stage('Destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                sh 'terraform destroy --auto-approve'
            }
        }
    }
}
