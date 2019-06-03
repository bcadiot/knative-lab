#!/bin/bash

KNATIVE_INGRESS=$(kubectl get service --namespace=istio-system istio-ingressgateway --output=jsonpath="{.status.loadBalancer.ingress[0].ip}")
KNATIVE_HELLO=$(kubectl get ksvc helloworld --output jsonpath="{.status.domain}")
# KNATIVE_HELLO=helloworld.default.example.com

curl -s -H "Host: ${KNATIVE_HELLO}" http://${KNATIVE_INGRESS}