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
         docker.withRegistry('https://hub.docker.com/', 'dockerhub') {
            def customImage = docker.build("isdance/client")
            /* Push the container to the custom Registry */
            customImage.push()
        }
        //  stage('Build Docker Image') {
		// 	steps {
		// 		withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
		// 			sh '''
		// 				docker build -t isdance/client .
		// 			'''
		// 		}
		// 	}
		// }

		// stage('Push Image To Dockerhub') {
		// 	steps {
		// 		withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
		// 			sh '''
		// 				docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
		// 				docker push isdance/client
		// 			'''
		// 		}
		// 	}
		// }
     }
}
