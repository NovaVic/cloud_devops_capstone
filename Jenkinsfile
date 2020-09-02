pipeline {
     agent any
     stages {
          
         stage('checkout from version control system') {
             steps {
                 sh '''
                   rm -rf /tmp/site_v1_for_canary_deployment
                   rm -rf /tmp/site_v2_for_canary_deployment
                   rm -rf /tmp/cloud_devops_capstone
                   cd /tmp/           
                   git clone https://github.com/NovaVic/site_v1_for_canary_deployment.git 
                   git clone https://github.com/NovaVic/site_v2_for_canary_deployment.git 
                   git clone https://github.com/NovaVic/cloud_devops_capstone.git
                '''

             }
         }
         stage('Lint HTML') {
              steps {
                  sh 'tidy -q -e /tmp/site_v1_for_canary_deployment/index.html'
                  sh 'tidy -q -e /tmp/site_v2_for_canary_deployment/index.html'
              }
         }
         stage('Lint Dockerfile') {
              steps {
                  sh 'hadolint /tmp/site_v1_for_canary_deployment/Dockerfile'
                  sh 'hadolint /tmp/site_v1_for_canary_deployment/Dockerfile'
              }
         }
         stage('Build and push Docker Image') {
              steps {
                  // For more info go to: 
                  // https://stackoverflow.com/a/58953352
                  // https://www.jenkins.io/doc/book/pipeline/docker/
                 script {  
                   docker.withRegistry('https://registry.hub.docker.com', 'novavic-docker-hub-credentials') {

                        def image1 = docker.build("novavic/clouddevops_capstone-img-v1:1.0", "/tmp/site_v1_for_canary_deployment/")
                        image1.push()

                        def image2 = docker.build("novavic/clouddevops_capstone-img-v2:1.0", "/tmp/site_v2_for_canary_deployment/")
                        image2.push()
                   } 
                 }
              }
         }
         stage('create cluster and deploy app with blue green deployment strategy') {
            steps {
                  withAWS(region:'us-west-2',credentials:'cloud-devops-capstone') {
                       sh '''
                         chmod +x /tmp/cloud_devops_capstone/create-cluster.sh
                         /tmp/cloud_devops_capstone/create-cluster.sh
                         aws eks --region us-west-2 update-kubeconfig --name alphabetsoupv1
                         kubectl create namespace alphabetsoupv1
                         kubectl apply -f /tmp/cloud_devops_capstone/deployment.yaml
                         kubectl apply -f /tmp/cloud_devops_capstone/load-balancer-service.yaml
                         kubectl get deployments -n alphabetsoupv1
                         kubectl expose deployment alphabetsoupv1 --type=LoadBalancer --name=alphsoupv1-lb-service -n alphabetsoupv1
                         kubectl describe services -n alphabetsoupv1
                         kubectl get pods -n alphabetsoupv1
                       '''
                  }
            }    
         }       
     }
}
