pipeline {
     agent any
     environment {
        CI = 'true'
        HOME = '.'
    }
     stages {
         stage('Build') {
             steps {
                 sh 'echo "Build Start"'
                 sh 'npm install --loglevel verbose'
                 sh 'npm run build'
             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e build/index.html'
              }
         }
         stage('Lint') {
              steps {
                  sh 'npm run lint'
              }
         }
         stage('Test') {
              steps {
                  sh 'npm test'
              }
         }
     }
}
