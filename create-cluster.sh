
# https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html
eksctl create cluster \
--name alphabetsoupv1 \
--version 1.17 \
--region us-west-2 \
--nodegroup-name alphabetsoupv1 \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3 \
--ssh-access --ssh-public-key /tmp/capstoneKeyPairV4_v2.pem --managed
