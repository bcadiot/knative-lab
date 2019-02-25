# How To deploy a knative cluster

## Deploy GKE Cluster

```
terraform apply
```

## Set Permissions

```
bash configure_credentials.sh
```

## Install Knative serving

```
kubectl label namespace default istio-injection=enabled
kubectl apply -f https://github.com/knative/serving/releases/download/v0.3.0/serving.yaml
```

## Deploy a sample application

Deploy and check the service
```
kubectl apply -f helloworld.yaml
kubectl get ksvc
kubectl describe ksvc helloworld
```

Reach the service
```
KNATIVE_INGRESS=$(kubectl get service --namespace=istio-system istio-ingressgateway --output=jsonpath="{.status.loadBalancer.ingress[0].ip}")
KNATIVE_HELLO=$(kubectl get ksvc helloworld --output jsonpath="{.status.domain}")

curl -H "Host: ${KNATIVE_HELLO}" http://${KNATIVE_INGRESS}
```
