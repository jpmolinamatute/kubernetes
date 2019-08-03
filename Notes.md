# Amazon Elastic Kubernetes Service (Amazon EKS) #

## Documentation ##

### Kubernetes Cluster ###

* [Amazon EKS Clusters](https://docs.aws.amazon.com/eks/latest/userguide/clusters.html)
* [Creating an Amazon EKS Cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html)
* [Managing Cluster Authentication](https://docs.aws.amazon.com/eks/latest/userguide/managing-auth.html)

### Group Nodes ###

* [Worker Nodes](https://docs.aws.amazon.com/eks/latest/userguide/worker.html)
* [Amazon EKS-Optimized AMI](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html)
* [Launching Amazon EKS Worker Nodes](https://docs.aws.amazon.com/eks/latest/userguide/launch-workers.html)

### Deep Learning ###

* [AWS Deep Learning Containers on Amazon EKS](https://docs.aws.amazon.com/dlami/latest/devguide/deep-learning-containers-eks.html)

## Commands ##

```sh
. Environments
aws --profile AI eks --region=us-east-2 update-kubeconfig  --name=Kubernetes
kubectl get svc
kubectl apply -f ./.kube/aws-auth-cm.yaml
kubectl get nodes
```
