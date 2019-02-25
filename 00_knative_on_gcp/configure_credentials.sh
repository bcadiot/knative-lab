#!/bin/bash

CLUSTER_NAME=$(terraform output cluster_name)
PROJECT_NAME=$(terraform output project_name)
DEPLOY_REGION=$(terraform output deploy_region)

gcloud container clusters get-credentials ${CLUSTER_NAME} --region ${DEPLOY_REGION} --project ${PROJECT_NAME}
kubectl config use-context gke_${PROJECT_NAME}_${DEPLOY_REGION}_${CLUSTER_NAME}
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud config get-value core/account)
