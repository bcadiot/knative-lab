#!/bin/bash

# Create broken
kubectl label namespace default knative-eventing-injection=enabled

# Test 
kubectl run busybox --image=busybox --restart=Never -- ls
kubectl delete pod busybox