eksctl create cluster \
--name alphabetsoup \
--version 1.17 \
--region us-west-2 \
--nodegroup-name alphabetsoup \
--node-type t2.micro \
--nodes 2 \
--nodes-min 1 \
--nodes-max 3
