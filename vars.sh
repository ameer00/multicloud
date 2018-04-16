export GKE_CLUSTER="gke_"$PROJECT"_"$GCP_ZONE"_gke-cluster"
export GLB_CLUSTER="gke_"$PROJECT"_"$GCP_ZONE"_glb-cluster"
export AWS_CLUSTER="uswest2."$SUB_DOMAIN
export GKE_APP_INGRESS_IP=$(kubectl get ingress app -n multicloud -o jsonpath='{.status.loadBalancer.ingress[0].ip}' --context $GKE_CLUSTER)
export AWS_APP_INGRESS_IP=$(kubectl get ingress app -n multicloud -o jsonpath='{.status.loadBalancer.ingress[0].hostname}' --context $AWS_CLUSTER)
export NGINX_IP=$(kubectl get service global-lb-nginx -o jsonpath='{.status.loadBalancer.ingress[0].ip}' --context $GLB_CLUSTER)

