def call(Map config = [:]) {
    stages {
        stage('Build') {
            steps {
                script {
                    echo "Install Node.js dependencies and running code quality checks..."
                    sh '''
                        # Install dependencies for Node.js
                        npm install
                        
                        # Run linting if available
                        if npm list eslint >/dev/null 2>&1; then
                            echo "Running ESLint..."
                            npm run lint || echo "Linting completed with issues"
                        else
                            echo "ESLint not configured, skipping linting"
                        fi
                        
                        echo "Validating required files..."
                        test -f "Dockerfile" && echo "Dockerfile found" || (echo "Dockerfile missing" && exit 1)
                        test -f "docker-compose.yml" && echo "docker-compose.yml found" || (echo "docker-compose.yml missing" && exit 1)
                    '''
                }
            }
        }
}