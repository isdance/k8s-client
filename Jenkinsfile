pipeline {
     agent any
     environment {
        CI = 'true'
        HOME = '.'
        K8S_TEMPLATES_FOLDER = '/home/ubuntu/k8s-simple-templates'
        k8S_TEMPLATE = '/home/ubuntu/k8s-simple-templates/client-deployment.yml'
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
         stage('Lint JavaScript') {
              steps {
                  sh 'npm run lint'
              }
         }
         stage('Unit Tests') {
              steps {
                  sh 'npm test'
              }
         }
         stage('Build Docker Image') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh "docker build -t isdance/client:v-${env.BUILD_ID} ."
				}
			}
		}

		stage('Push Image To Dockerhub') {
			steps {
				withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]){
					sh '''
						docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
					'''
                    sh "docker push isdance/client:v-${env.BUILD_ID}"
                    sh "cp /home/ubuntu/k8s-simple-templates/client-deployment.yml /tmp"
                    sh "sed -i -e \"/client:v-/s/\\([0-9]\\+\\)/${env.BUILD_ID}/\" /tmp/client-deployment.yml"
				}
			}
		}

        stage('Apply Kubernetes files') {
            withKubeConfig([credentialsId: 'aws-static', serverUrl: 'https://4EB7DC51970C7A5A86305E866C1F48A8.yl4.us-west-2.eks.amazonaws.com']) {
                sh 'kubectl get deployments'
                sh 'kubectl apply -f /tmp/client-deployment.yml'
            }
        }
     }
}
