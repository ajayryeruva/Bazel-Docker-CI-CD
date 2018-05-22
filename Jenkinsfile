def err = null

try {

node('master')  {
	  stage('git-repo-checkout') {
                 checkout scm
		 //sh 'git pull -f origin dev'
                 //sh 'git push -f origin master'
                 //sh "git tag bazel-${env.MAJOR_VERSION}.${env.BUILD_NUMBER}"
                 //sh "git push -f origin bazel-${env.MAJOR_VERSION}.${env.BUILD_NUMBER}"
          }
          //stage('pre-analysis'){
          //       sh '/usr/bin/cppcheck --xml --xml-version=2 cpp-ci-cd-example 2> cppcheck.xml; /usr/bin/cppcheck --enable=all --inconclusive --xml --xml-version=2 cpp-ci-cd-example 2> cppcheck.xml'
          //}
          stage('bazel-build'){
                 sh 'cd cpp-ci-cd-example/; sudo /usr/bin/bazel build //main:hello-world'
          }
          stage('bazel-test'){
                 sh 'cd cpp-ci-cd-example/; sudo bazel-bin/main/hello-world; sudo cp bazel-bin/main/hello-world docker-static-binary/run/'
          }
          stage ('cppcheck'){
		 build job: 'cppcheck-report', wait: false
          }
          stage('sonarscan') {
		 // ws('.') {
		 // requires SonarQube Scanner 2.8+
		 def ScannerHome = tool 'SonarScanner';
		 withSonarQubeEnv('SonarQube 7.1') {
		 // bat "${ScannerHome}/bin/sonar-scanner.bat"
		 sh "${ScannerHome}/bin/sonar-scanner -Dsonar.host.url=http://52.11.124.85:8081 -Dsonar.branch=${env.BRANCH_NAME} -Dsonar.working.directory=/opt/sonar-scanner/.sonar -Dsonar.cppcheck.reportPath=cppcheck.xml -Dsonar.analysis.mode= -X"
		  }
		//}
	  }
          stage('docker-cycle'){
                 sh 'cd cpp-ci-cd-example/docker-static-binary/; ./run.sh'
          }
	  stage('Deployment approval'){
      		 input "Deploy to prod?"
	  }
}
}

catch (caughtError) {
    err = caughtError
    currentBuild.result = "FAILURE"
}

finally {
    (currentBuild.result != "ABORTED") && node("master") {
        // Send e-mail notifications for failed or unstable builds.
        // currentBuild.result must be non-null for this step to work.
        step([$class: 'Mailer',
        notifyEveryUnstableBuild: true,
        recipients: "ajay.yeruva@mindstream.org",
        sendToIndividuals: true])
    }
    /* Must re-throw exception to propagate error */
    if (err) {
        throw err
    }

}
