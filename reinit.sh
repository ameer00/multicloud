#!/bin/bash

# Enter your values below
PROJECT_DEF=ameer-mc-1
GCP_ZONE_DEF=us-central1-a
SA_KEY_DEF=cloud-tools/multicloud-sa.json
AWS_KEY_DEF=AKIAIPHPJP4PMUOBXXFA
AWS_SECRET_DEF=nhRWysrrfjl04av3r8n8cThaZXVm7BXyQX8k1ysv
AWS_REGION_DEF=us-west-2
DOMAIN_DEF=ameer1.ml

read -p 'Use default values (y or n)?  ' USE_DEF
USE_DEF=${USE_DEF:-y}

if [ $USE_DEF = n ]; then

read -p 'Enter GCP Project ID (might be different from Project name): ' PROJECT
PROJECT=${PROJECT:-$PROJECT_DEF}
read -p 'Enter filename of your service account key for GCP (rel path to $HOME): ' SA_KEY
SA_KEY=${SA_KEY:-$SA_KEY_DEF}
read -p 'Enter your default GCP zone (zone of your k8s clusters e.g. us-central1-a): ' GCP_ZONE
export GCP_ZONE=${GCP_ZONE:-$GCP_ZONE_DEF}
read -p 'Enter AWS Access Key ID: ' AWS_KEY
AWS_KEY=${AWS_KEY:-$AWS_KEY_DEF}
read -p 'Enter AWS Secret Access Key: ' AWS_SECRET
AWS_SECRET=${AWS_SECRET:-$AWS_SECRET_DEF}
read -p 'Enter AWS default region (for example us-west-2): ' AWS_REGION
AWS_REGION=${AWS_REGION:-$AWS_REGION_DEF}
read -p 'Enter your domain, for example, yourdomain.xyz: ' DOMAIN
DOMAIN=${DOMAIN:-$DOMAIN_DEF}
SUB_DOMAIN="aws.$DOMAIN"

else

PROJECT=$PROJECT_DEF
GCP_ZONE=$GCP_ZONE_DEF
SA_KEY=$SA_KEY_DEF
AWS_KEY=$AWS_KEY_DEF
AWS_SECRET=$AWS_SECRET_DEF
AWS_REGION=$AWS_REGION_DEF
DOMAIN=$DOMAIN_DEF
SUB_DOMAIN="aws.$DOMAIN"

fi

gcloud auth activate-service-account --key-file=$HOME/$SA_KEY
gcloud config set project $PROJECT
gcloud config set compute/zone $GCP_ZONE
gcloud container clusters get-credentials gke-cluster --zone $GCP_ZONE --project $PROJECT
gcloud container clusters get-credentials glb-cluster --zone $GCP_ZONE --project $PROJECT
aws configure set aws_access_key_id $AWS_KEY
aws configure set aws_secret_access_key $AWS_SECRET
aws configure set default.region $AWS_REGION
KOPS_STATE_STORE=s3://clusters.$SUB_DOMAIN
kops export kubecfg uswest2.$SUB_DOMAIN --state $KOPS_STATE_STORE
echo Active GCP Project: $PROJECT
echo Default GCP zone: $GCP_ZONE 
echo AWS hosted zone: $SUB_DOMAIN
echo Kops State Store: $KOPS_STATE_STORE
export PROJECT GCP_ZONE AWS_REGION SUB_DOMAIN KOPS_STATE_STORE
export GKE_CLUSTER="gke_"$PROJECT"_"$GCP_ZONE"_gke-cluster"
export GLB_CLUSTER="gke_"$PROJECT"_"$GCP_ZONE"_glb-cluster"
export AWS_CLUSTER="uswest2."$SUB_DOMAIN
export GKE_APP_INGRESS_IP=$(kubectl get ingress app -n multicloud -o jsonpath='{.status.loadBalancer.ingress[0].ip}' --context $GKE_CLUSTER)
export AWS_APP_INGRESS_IP=$(kubectl get ingress app -n multicloud -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' --context $AWS_CLUSTER)
export NGINX_IP=$(kubectl get service global-lb-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}' --context $GLB_CLUSTER)

yum -y install bind-utils gettext 
