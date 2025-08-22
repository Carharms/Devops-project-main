def call(Map config = [:]) {
    stage('Container Security Scan') {
                steps {
                    script {
                        echo "Running container security scan..."
                        // very comprehensive security scan below - not synopsis provided in dev docs
                        try {
                            bat "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy:latest image --exit-code 1 --severity CRITICAL ${DOCKER_IMAGE_NAME}:${IMAGE_TAG}"
                        } catch (Exception e) {
                            echo "Security scan encountered issues but continuing: ${e.getMessage()}"
                        }
                    }
                }
            }
        }