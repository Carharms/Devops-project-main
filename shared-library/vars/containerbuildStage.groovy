// This can be repeated across all pipelines
def call(Map config = [:]) {
    stage('Container Build') {
                steps {
                    script {
                        echo "Building Docker image..."
                        def image = docker.build("${DOCKER_IMAGE_NAME}:${IMAGE_TAG}")
                        
                        // Tag with branch-specific tags
                        if (env.BRANCH_NAME == 'main') {
                            image.tag("latest")
                        } else if (env.BRANCH_NAME == 'develop') {
                            image.tag("dev-latest")
                        } else if (env.BRANCH_NAME?.startsWith('release/')) {
                            image.tag("staging-latest")
                        }
                    }
                }
            }
}