provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.PROJECT}"
  region      = "${var.REGION}"
}

resource "google_container_cluster" "primary" {
  name               = "${var.CLUSTER}"
  zone               = "${var.ZONE}"
  initial_node_count = 1

  master_auth {
    username = "${var.USERNAME}"
    password = "${var.PASSWORD}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      name = "gke"
    }

    tags = ["name", "gke"]
  }

}
