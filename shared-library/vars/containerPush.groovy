def call(Map config = [:]) {
    stage('Container Push') {
            when {
                anyOf {
                    branch 'develop'
                    branch 'main'
                    branch 'release/*'
                }
            }
            steps {
                script {
                    echo "Pushing Docker image to registry..."
                    docker.withRegistry('https://index.docker.io/v1/', env.DOCKER_HUB_CREDENTIALS) {
                        def image = docker.image("${DOCKER_IMAGE_NAME}:${IMAGE_TAG}")
                        image.push()
                        
                        if (env.BRANCH_NAME == 'main') {
                            image.push("latest")
                        } else if (env.BRANCH_NAME == 'develop') {
                            image.push("dev-latest")
                        } else if (env.BRANCH_NAME?.startsWith('release/')) {
                            image.push("staging-latest")
                        }
                    }
                }
            }
        }
        
        stage('Deploy') {
            when {
                anyOf {
                    branch 'develop'
                    expression { env.BRANCH_NAME.startsWith('release/') }
                    branch 'main'
                }
            }
            steps {
                script {
                    if (env.BRANCH_NAME == 'main') {
                        timeout(time: 10, unit: 'MINUTES') {
                            input message: "Deploy to production?", ok: "Deploy"
                        }
                    }
                    
                    echo "Deploying to ${env.BRANCH_NAME} environment..."
                    sh 'docker-compose -f docker-compose.yml up -d'
                }
            }
        }
}