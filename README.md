# Final Task GCP
## This will guide you through deploying a k8s cluster on GCP.
the infrastructure is written with terraform making 1 VPC and 2 subnets with a VM instance and a nat gateway in one subnet and the other subnet containing the GKE Cluster.
### prerequisite
- a linux machine
- Gcloud tool authinticated
- Docker
- Kubectl
### Steps
- download the source code
- in the infrastructure folder run the following commands
```
terraform init
terraform plan
terraform apply
```
This should apply the infrastructure code
- navigate to the Docker folder and build the Dockerfile
- now ssh to the instance you created and connect to the cluster and install kubectl 
- apply the yaml files found in the kubectl folder to add the deployments and the loadbalancer to your cluster.
