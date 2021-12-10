pipeline{
    agent any
    
    stages{
        stage ('Flutter Doctor') {
            steps {
                sh "flutter doctor -v"
            }
        }

        stage ('Flutter Build APK') {
            steps {
                sh "flutter build apk --split-per-abi"
            }
        }
        
    }
   

}
