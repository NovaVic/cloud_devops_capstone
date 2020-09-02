
# Plan

*  Used base nginx docker image and replaced the index file with soup related index page in one case (green)
and alphabet related index page in another case (blue).


* Initially thought about Canary but then later on went with Blue Green deployment Strategy.

* Used Kubernetes service and deployment yaml and eksctl to make cluster and load balancer creation simpler.

* Used source code and Docekrfile from these two repos:

                  https://github.com/NovaVic/site_v1_for_canary_deployment.git (assume source of blue)
                  https://github.com/NovaVic/site_v2_for_canary_deployment.git (assume source of green)

# Pre-requisites:

* Jenkins Installation - done as part of Project 3 of same course.

sudo apt update
sudo apt upgrade
sudo apt install default-jdk
sudo systemctl start jenkins

sudo systemctl status jenkins

* Added  blue ocean plugin, docker hub plugin into Jenkins, installed docker, aws cli, kubectl
* Added IAM user cloud-devops-capstone
* Added security credentials for cloud-devops-capstone and docker hub in jenkins creentials section
* Added jenkins user to docker group

* Generated key pair to to able to use while creating a cluster to allow ssh into cluster nodes for trouble shooting.

# Materials and concepts used to create and trouble shoot the cluster:

https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html
https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html
https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/


https://docs.aws.amazon.com/cli/latest/userguide/cli-services-ec2-keypairs.html#creating-a-key-pair
https://docs.aws.amazon.com/eks/latest/userguide/troubleshooting.html#unauthorized
https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
https://aws.amazon.com/premiumsupport/knowledge-center/iam-assume-role-cli/
https://docs.aws.amazon.com/cli/latest/reference/sts/get-caller-identity.html
https://aws.amazon.com/premiumsupport/knowledge-center/eks-delete-cluster-issues/
https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html#w237aac13c27b9b3
https://docs.aws.amazon.com/eks/latest/userguide/load-balancing.html
https://stackoverflow.com/questions/60013670/eks-create-cluster-command-fails-with-error-computing-fingerprint-illegal-base6

# How it works

Linked this github repo to jenkins such that any chnage in this repo causes automatic pulling of files, building , tagging and
pushing of docker images, creation of kube clusters and deployment of the app `soup` or `alphabet` into the cluster using blue-green
deployment strategy (originally thought to do Canary deployment but the assignment talks about Blure-green or rolling - so changed 
the plan accordingly). 
Additionally the Load Balancer port 80 is exposed for accessing the app from outside of the aws system.

# Sample Screen Shots
The screen snapshots are in images subdirectory of this repo.

# Cleanup
deleting cluster (to conserve resources and save cost):

eksctl delete cluster --region=us-west-2 --name=alphabetsoupv1
