def call(Map config = [:]) {
            stage('SonarQube Analysis and Quality Gate') {
            steps {
                script {
                    // SonarScanner tool path
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv('SonarQube') {
                        bat """
                            ${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=${SONAR_PROJECT_KEY} -Dsonar.sources=. -Dsonar.exclusions=node_modules/**,test/**,coverage/**
                        """
                    }
                }
            }
        }
}