pipeline{
    agent any
    parameters {
        string(name: 'DEPLOY_ENV', defaultValue: 'TESTING', description: 'The target environment')
        choice(name: 'BRAND', choices:['PG','HKJP','WLG','BIN'], description: 'The brand choice')
        choice(name: 'ENVIRONMENT', choices:['development','staging','production'], description: 'The environment choice')
   }
    stages{
        stage ('Flutter Doctor') {
            steps {
                cmd_exec('flutter doctor -v')
            }
        }
         stage ('Flutter clean') {
            steps {
                cmd_exec('flutter clean')
            }
        }

        stage('Build environment'){
            parallel{
                stage ('Build pg development environment') {
                    when {
                        expression {
                            params.BRAND == 'PG' && params.ENVIRONMENT == 'development'
                        }
                    }

                    steps {
                        echo "PG_dev"
                        script{
                            echo "reading yaml file"
        					yaml_file = env.WORKSPACE + "pg_dev\\pg_dev.yaml"
        					read_yaml_file(yaml_file)
        				}
                         runShellScript('pg_dev\\pg_dev.yaml', 'com.tgs.pg_dev', 'PG_dev')
                        }
                }

                stage ('Build pg staging environment') {
                    when {
                        expression {
                            params.BRAND == 'PG' && params.ENVIRONMENT == 'staging'
                        }
                    }

                    steps {
                        echo "PG_stg"
                         runShellScript('pg_stg\\pg_stg.yaml', 'com.tgs.pg_stg', 'PG_stg')
                        }
                }

                stage ('Build pg production environment') {
                    when {
                        expression {
                            params.BRAND == 'PG' && params.ENVIRONMENT == 'production'
                        }
                    }

                    steps {
                        echo "PG_prod"
                         runShellScript('pg_prod\\pg_prod.yaml', 'com.tgs.pg_prod', 'PG')
                        }
                }

                stage ('Build hkjp environment') {
                    when {
                        expression {
                            params.BRAND == 'HKJP'
                        }
                    }

                    steps {
                        echo "HKJP"
                         runShellScript('hkjp\\hkjp.yaml', 'com.tgs.hkjp', 'HKJP')
                        }
                }

                stage ('Build bin environment') {
                    when {
                        expression {
                            params.BRAND == 'BIN'
                        }
                    }

                    steps {
                        echo "BIN"
                         runShellScript('bin_gaming\\bin_gaming.yaml', 'com.tgs.bin_gaming', 'BIN')
                        }
                }

                stage ('Build wlg environment') {
                    when {
                        expression {
                            params.BRAND == 'WLG'
                        }
                    }

                    steps {
                        echo "WLG"
                         runShellScript('wlg\\wlg.yaml', 'com.tgs.wlg', 'WLG')
                        }
                }
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
    echo "${WORKSPACE}\\env\\${yamlFilePath}, ${appId}, ${appName}"
    bat 'flutter pub get'
    bat "flutter pub run --no-sound-null-safety flutter_launcher_icons:main -f env\\${yamlFilePath}"
    bat "flutter pub run --no-sound-null-safety environment_config:generate --config=env\\${yamlFilePath}"
    bat 'cd ..\\..\\'
    bat "dart pub global run rename --bundleId ${appId}"
    bat "dart pub global run rename --appname ${appName}"
    echo "Done"
}

def read_yaml_file(yaml_file) {
	def datas = ""
	if(yaml_file.toString().endsWith(".yaml")){
		datas = readYaml file : yaml_file
		
	}else {
		datas = readYaml text : yaml_file
	}
	datas.each {
		echo "${it.key} = ${it.value} "
	 }
}
