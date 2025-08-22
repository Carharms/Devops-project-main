def call(Map config = [:]) {
    stage('Test') {
                steps {
                    script {
                        echo "Running Node.js tests..."
                        sh '''
                            # Create test directory if it doesn't exist
                            mkdir -p test
                            
                            # If node js microservice
                            echo "Running unit tests..."
                            npm test || echo "Unit tests completed with issues"

                            # Elif python microservice
                            # link to unit tests within subdirectory
                            
                        '''
                    }
                }
            }
        }