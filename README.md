The project is designed to create cronjob resources in kubernetes environment via Gitlab Ci.  
you must specify the following values of variables:  
- ${KUBE_URL} - ip or dns name of K8S API  
- ${KUBE_TOKEN} - token with write privileges  
- ${KUBE_NAMESPACE} - used namespace
- ${DEPLOYMENT_NAME} - name of kubernetes deployment 
