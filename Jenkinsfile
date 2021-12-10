pipeline{
    agent any
    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: 'The target environment')
        choice(name: 'CHOICE', choices:['choice 1','choice 2','choice 3'], description: 'The testing choice')
    }
    stages{
        stage ('Flutter Doctor') {
            steps {
                cmd_exec('flutter doctor -v')
            }
        }

        stage ('test stage') {
            expression {
                prarams.CHOICE == 'choice 1'
            }
            steps {
                echo "test output condition"
            }
        }

        stage ('Flutter Build APK') {
            steps {
                echo "test output ${DEPLOY_ENV}"
                cmd_exec('flutter build apk --split-per-abi')
            }
        }
        
    }
   

}
def cmd_exec(command) {
    return bat(returnStdout: true, script: "${command}").trim()
}
