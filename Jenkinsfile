pipeline {
     agent any
     stages {
         stage('checkout') {
             steps {
                 sh '''
                   git clone https://github.com/NovaVic/site_v1_for_canary_deployment.git
                   git clone https://github.com/NovaVic/site_v2_for_canary_deployment.git 
                '''

             }
         }
         stage('install hadolint') {
            steps {  
                 sh '''
                   sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64 &&\
                   chmod +x /bin/hadolint
                 '''
            }     
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e https://raw.githubusercontent.com/NovaVic/site_v1_for_canary_deployment/master/index.html'
                  sh 'tidy -q -e ./site_v2_for_canary_deployment/index.html'
              }
         }
         stage('Lint Dockerfile') {
              steps {
                  sh 'hadolint ./site_v1_for_canary_deployment/Dockerfile'
                  sh 'hadolint ./site_v1_for_canary_deployment/Dockerfile'
              }
         }
         stage('Build and push Docker Image') {
              steps {
                  // For more info go to: 
                  // https://stackoverflow.com/a/58953352
                  // https://www.jenkins.io/doc/book/pipeline/docker/
                  
                  //sh 'Using Two Different Syntax while Building Images'
                  //sh 'docker build -f ./site_v1_for_canary_deployment/Dockerfile --tag=sk_clouddevops_capstone_img_v1 '
                   script {  
                      docker.withRegistry('https://registry.hub.docker.com', 'novavic-docker-hub-credentials') {
                        //app.push("${env.BUILD_NUMBER}")
                        //app.push("latest")

                        def image1 = docker.build("sk_clouddevops_capstone_img_v1:1.0", "./site_v1_for_canary_deployment/")
                        image1.push()

                        def image2 = docker.build("sk_clouddevops_capstone_img_v2:1.0", "./site_v2_for_canary_deployment/")
                        image2.push()
                      } 
                   }
              }
         }

     }
}
