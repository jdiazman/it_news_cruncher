resource "google_compute_instance" "service_vm" {
    name         = "service-vm"
    machine_type = "e2-micro"
    zone         =  var.zone
    project      = var.project_id

    boot_disk {
        initialize_params {
            image = "ubuntu-os-cloud/ubuntu-2204-lts"
            size  = 10
            type  = "pd-balanced"
        }
    }

    network_interface {
        network = "default"
        access_config {
            // No external IP for better security
            // Comment out the next line to allow external IP if needed
            // nat_ip = null
        }
    }

    service_account {
        scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    }

    tags = ["project-members-only"]

    metadata = {
        enable-oslogin = "TRUE"
    }
}

resource "google_compute_firewall" "allow_project_members_ssh" {
    name    = "allow-ssh-project-members"
    network = "default"

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = ["35.235.240.0/20"] # Google IAP IPs for SSH by project members

    target_tags = ["project-members-only"]
    direction   = "INGRESS"
    priority    = 1000
    description = "Allow SSH only via IAP (project members)"
}