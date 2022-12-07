pipeline {
    agent any

    parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    stages {
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                sh 'pwd'
                sh 'cd terraform && terraform init -input=false'
                sh 'cd terraform && terraform workspace select ${environment}'
                sh "cd terraform && terraform plan -input=false -out tfplan"
                sh 'cd terraform && terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                sh "cd terraform && terraform apply -input=false tfplan"
            }
        }
    }

    post {
        always {
            sh 'cd terraform'
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}
