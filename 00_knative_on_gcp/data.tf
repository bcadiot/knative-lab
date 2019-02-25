data "google_client_config" "current" {}

data "google_container_engine_versions" "available" {
  region = "${data.google_client_config.current.region}"
}
