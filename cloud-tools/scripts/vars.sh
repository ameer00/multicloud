# Define variables below
# Feel free to add additional variables underneath the GCP and AWS sections below

# Enter values for GCP
export GCP_ZONE=us-central1-a
export GKE_CLUSTER=gke-cluster
export GLB_CLUSTER=glb-cluster

# Enter values for AWS
export AWS_REGION=us-east-2
export AWS_ZONE=us-east-2a
export DOMAIN=ameerlabs.com
export AWS_CLUSTER=$AWS_ZONE

# Do not enter anything below
export PROJECT=$(gcloud info --format='value(config.project)')
export GKE_CONTEXT="gke_"$PROJECT"_"$GCP_ZONE"_"$GKE_CLUSTER
export GLB_CONTEXT="gke_"$PROJECT"_"$GCP_ZONE"_"$GLB_CLUSTER
export SUB_DOMAIN=aws.$DOMAIN
export AWS_CONTEXT=$AWS_CLUSTER"."$SUB_DOMAIN

# For verification
echo "Please confirm the vars below:"
echo "GCP Project ID: " $PROJECT
echo "GCP Zone: " $GCP_ZONE
echo "GKE Cluster Context: " $GKE_CONTEXT
echo "GLB Cluster Context: " $GLB_CONTEXT
echo "AWS Region: " $AWS_REGION
echo "AWS Availability Zone: " $AWS_ZONE
echo "AWS Sub Domain: " $SUB_DOMAIN
echo "AWS Cluster Context: " $AWS_CONTEXT
