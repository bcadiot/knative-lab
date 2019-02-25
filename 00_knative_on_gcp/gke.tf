resource "google_container_cluster" "cluster" {
  provider           = "google-beta"
  project            = "${data.google_client_config.current.project}"
  name               = "knative"
  region             = "${data.google_client_config.current.region}"
  min_master_version = "${data.google_container_engine_versions.available.latest_master_version}"
  logging_service    = "logging.googleapis.com"
  monitoring_service = "monitoring.googleapis.com"

  remove_default_node_pool = true
  initial_node_count       = 1

  addons_config {
    istio_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "cluster-np1" {
  project    = "${data.google_client_config.current.project}"
  name       = "${google_container_cluster.cluster.name}-np1"
  region     = "${data.google_client_config.current.region}"
  cluster    = "${google_container_cluster.cluster.name}"
  node_count = 1

  version = "${data.google_container_engine_versions.available.latest_node_version}"

  management {
    auto_repair = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 10
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management",
      "https://www.googleapis.com/auth/servicecontrol",
    ]

    image_type   = "COS"
    machine_type = "n1-standard-1"
  }
}
