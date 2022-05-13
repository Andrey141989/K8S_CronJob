#!/bin/sh
set -eu
 
#kubectl binary setup
apk add -U curl
curl -L -o /usr/bin/kubectl "https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl"
chmod +x /usr/bin/kubectl
kubectl version --client
 
#kubectl connection setup
kubectl config set-cluster default-cluster --insecure-skip-tls-verify=true --server="${KUBE_URL}"
    echo "TOKEN Auth used"
kubectl config set-credentials default-admin --token="${KUBE_TOKEN}"
 
kubectl config set-context default-system --user=default-admin --namespace="${KUBE_NAMESPACE}" --cluster=default-cluster
kubectl config use-context default-system
kubectl cluster-info
 
#manifests setup
cd manifests/
sed -i "s%KUBE_NAMESPACE%${KUBE_NAMESPACE}%" CronJob.yml
sed -i "s%DEPLOYMENT_NAME%${DEPLOYMENT_NAME}%" CronJob.yml
sed -i "s%KUBE_NAMESPACE%${KUBE_NAMESPACE}%" RoleBinding.yml
sed -i "s%DEPLOYMENT_NAME%${DEPLOYMENT_NAME}%" Role.yml
sed -i "s%KUBE_NAMESPACE%${KUBE_NAMESPACE}%" Role.yml
sed -i "s%KUBE_NAMESPACE%${KUBE_NAMESPACE}%" ServiceAccount.yml
 
#manifests deploy
kubectl apply -R -f .