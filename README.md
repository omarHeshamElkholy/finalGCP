# Final Task GCP
## Deploying a python app using terraform, docker and GCP services
## Infrastructure
A VPC containing 2 subnets, Nat gate-way, Private VM instance and a private GKE cluster.
## k8s elements
a redis pod, redis service, python app deployment and a service loadbalancer.
## Docker
Dockerized the python app with a Dockerfile and a docker-compose file to run multiple containers and tested locally then pushed to GCR.
## Steps
- download the source code
- in the infrastructure folder run the following commands
```
terraform init
terraform plan
terraform apply
```
This should apply the infrastructure code
- now ssh to the instance you created and connect to the cluster and install kubectl 
- apply the yaml files found in the kubectl folder to add the deployments and the loadbalancer to your cluster.

i have uploaded the dockerfile and docker-compose file used to build images
