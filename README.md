# Terraform Kubernetes Provider

The purpose of this example project is to show how to provision a basic Apache web service on top of GKE cluster with a replication controller.
## Pre-requisite
Assume that you have the following items ready
- GCP Account
- Google Cloud SDK
- kubectl
- Terraform version 0.12+

Activate the service account for the environment
```bash
$ gcloud auth activate-service-account [ACCOUNT] --key-file=[KEY_FILE] --project=[PROJECT_NAME]
```
then get the credentials for kubernetes
```bash
$ gcloud container clusters get-credentials [CLUSTER_NAME] --region REGION --project [PROJECT_NAME]
```
this will update kubernetes config (~/.kube/config) with a credentials information and point kubectl at your GKE cluster.
## Used resources
* `kubernetes_deployment`
* `kubernetes_service`
## Usage
### Create
Download the provider
```bash
$ terraform init
```
then proceed to plan and create the resources
```bash
$ terraform apply
```
Optionally, you may specify the version of httpd, number of pods replicas and the exposed port to your liking.
```bash
$ export TF_VAR_num_replicas=3
$ export TF_VAR_httpd_version=2.4
$ export TF_VAR_exposed_port=8080
$ terraform apply
```
After the resources successfully created, it will give an output of public IP address of load balancer that exposes the web service. 
```bash
Outputs:

lb_ip = 34.67.51.82
```
### Destroy
to destroy the resources
```bash
$ terraform destroy
```
