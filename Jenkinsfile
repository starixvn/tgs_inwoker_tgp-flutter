pipeline{
    agent any
    
    stages{
        stage ('Flutter Doctor') {
            steps {
                cmd_exec('flutter doctor -v')
            }
        }

        stage ('Flutter Build APK') {
            steps {
                cmd_exec('flutter build apk --split-per-abi')
            }
        }
        
    }
   

}
