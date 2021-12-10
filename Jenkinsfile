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
                cmd_exec('rm -rf android/app/src/main/res/drawable-*')
            }
        }

        stage ('Flutter Build APK') {
            steps {
                cmd_exec('flutter build apk --split-per-abi')
            }
        }
        
    }
   

}
def cmd_exec(command) {
    return bat(returnStdout: true, script: "${command}").trim()
}
