output "deploy_region" {
  value = "${data.google_client_config.current.region}"
}

output "cluster_name" {
  value = "${google_container_cluster.cluster.name}"
}

output "project_name" {
  value = "${data.google_client_config.current.project}"
}
