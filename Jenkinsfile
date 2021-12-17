pipeline{
    agent any
    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: 'The target environment')
        choice(name: 'BRAND', choices:['PG','HKJP','WLG','BIN'], description: 'The brand choice')
        choice(name: 'ENVIRONMENT', choices:['developement','staging','production'], description: 'The environment choice')
   }
    stages{
        stage ('Flutter Doctor') {
            steps {
                cmd_exec('flutter doctor -v')
            }
        }

        stage ('test stage') {
            when {
                expression {
                    params.BRAND == 'PG' && params.ENVIRONMENT == 'developement'
                }
            }
            
            steps {
                echo "PG_dev"
                 runShellScript('pg_dev/pg_dev.yaml', 'com.tgs.pg_dev', 'PG_dev')
                }
        }
                
        stage ('Flutter clean') {
            steps {
                cmd_exec('flutter clean')
            }
        }
        stage ('Flutter Build APK') {
            steps {
                echo "test output ${DEPLOY_ENV}"
                cmd_exec('flutter build apk')
            }
        }
        
    }
   

}
def cmd_exec(command) {
    return bat(returnStdout: true, script: "${command}").trim()
}

def runShellScript(yamlFilePath, appId, appName) {
    echo "Configurating"
    echo "${WORKSPACE}/env/${yamlFilePath}, ${appId}, ${appName}"
    sh 'flutter pub run --no-sound-null-safetyflutter_launcher_icons:main -f ${WORKSPACE}/env/${yamlFilePath}'
    sh 'flutter pub run --no-sound-null-safety environment_config:generate --config=env/${yamlFilePath}'
    sh 'cd ../../'
    sh 'dart pub global run rename --bundleId ${appId}'
    sh 'dart pub global run rename --appname ${appName}'
    echo "Done"
}
