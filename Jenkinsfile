def err = null

try {

node('master')  {
	  stage('git-code-checkout') {
                 checkout scm
          }
          stage('generate-cppcheck-sar-file'){
                 sh '/usr/bin/cppcheck --xml --xml-version=2 cpp-ci-cd-example 2> cppcheck.xml; /usr/bin/cppcheck --enable=all --inconclusive --xml --xml-version=2 cpp-ci-cd-example 2> cppcheck.xml'
          }
          stage('bazel-build'){
                 sh 'cd cpp-ci-cd-example/; sudo /usr/bin/bazel build //main:hello-world'
           }
          stage('bazel-test'){
                 sh 'cd cpp-ci-cd-example/; sudo bazel-bin/main/hello-world; sudo cp bazel-bin/main/hello-world docker-static-binary/run/'
          }
          stage('docker-build-publish-run'){
                 sh 'cd cpp-ci-cd-example/docker-static-binary/; ./run.sh'
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