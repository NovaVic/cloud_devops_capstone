pipeline {
     agent any
     stages {
         stage('checkout from version control system') {
             steps {
                 sh '''
                   rm -rf ~/site_v1_for_canary_deployment
                   rm -rf ~/site_v2_for_canary_deployment
                   cd ~
                   git clone https://github.com/NovaVic/site_v1_for_canary_deployment.git 
                   git clone https://github.com/NovaVic/site_v2_for_canary_deployment.git 
                '''

             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e ~/site_v1_for_canary_deployment/index.html'
                  sh 'tidy -q -e ~/site_v2_for_canary_deployment/index.html'
              }
         }
         stage('Lint Dockerfile') {
              steps {
                  sh 'hadolint ~/site_v1_for_canary_deployment/Dockerfile'
                  sh 'hadolint ~/site_v1_for_canary_deployment/Dockerfile'
              }
         }
         stage('Build and push Docker Image') {
              steps {
                  // For more info go to: 
                  // https://stackoverflow.com/a/58953352
                  // https://www.jenkins.io/doc/book/pipeline/docker/
                  
                  //sh 'Using Two Different Syntax while Building Images'
                  //sh 'docker build -f ~/site_v1_for_canary_deployment/Dockerfile --tag=sk_clouddevops_capstone_img_v1 '

                 docker.withRegistry('https://registry.hub.docker.com', 'novavic-docker-hub-credentials') {
                   //app.push("${env.BUILD_NUMBER}")
                   //app.push("latest")
                   script {  
                        def image1 = docker.build("sk_clouddevops_capstone_img_v1:1.0", "~/site_v1_for_canary_deployment/Dockerfile")
                        image1.push()

                        def image2 = docker.build("sk_clouddevops_capstone_img_v2:1.0", "~/site_v2_for_canary_deployment/Dockerfile")
                        image2.push()
                   } 
                 }
              }
         }

     }
}
