
## Terraform, Google Cloud Platform (GCP), Google Kubernetes Engine (GKE) and Kubernetes (k8)

Custom docker image is used to wrap according cli commands for convenient usage.

Set `GOOGLE_APPLICATION_CREDENTIALS` variable -- path to GCP service account JSON key.

Set `CLOUDSDK_CORE_PROJECT` variable -- GCP project id.

Set other variables. To set some terraform variable via environment variable inside of docker, use `TF_VAR_` prefix. For example, `TF_VAR_region`.

Run container (need to specify the name of the service `terraform`, otherwise it won't run):

```shell
docker-compose up -d --build terraform
```

Enter container shell:

```shell
docker-compose exec terraform bash
```

And run according commands:

```shell
# Initialize the Terraform working directory
terraform init

# Ensure your configuration is syntactically valid.
terraform validate

# Review the actions Terraform will take to achieve the desired state.
terraform plan

# Create the GKE cluster and associated resources.
terraform apply --auto-approve
```

After cluster is created, run (still inside docker container shell):

```shell
# To configure kubectl to use the GKE cluster credentials run:
gcloud container clusters get-credentials ${TF_VAR_cluster_name} --region ${TF_VAR_region} --project ${TF_VAR_project_id}

# Check if kubectl can communicate with cluster.
kubectl get nodes
```

### k8, run sample application

To ensure your cluster is set up correctly, a sample application could be deployed. Run (still inside docker container shell):

```shell
# deploy sample application
kubectl create deployment hello-world --image=gcr.io/google-samples/hello-app:1.0

# expose the deployment
kubectl expose deployment hello-world --type=LoadBalancer --port=80 --target-port=8080

# check the service
kubectl get services
```

#### k8 clear sample application

Run (still inside docker container shell):

```shell
terraform destroy --auto-approve
```
