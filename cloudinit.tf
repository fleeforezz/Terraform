# Load environment variables
# Load environment variables using terraform-dotenv
data "external" "env" {
  program = ["bash", "-c", "cat .env | yq -o=json"]
}

# Define SSH keys variable
variable "ssh_keys" {
  type        = string
  sensitive   = true
}

resource "proxmox_vm_qemu" "cloudinit-Kubernetes-Master-1" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "prx1"
    desc = "Cloudinit Ubuntu"
    count = 1
    onboot = true

    # The template name to clone this vm from
    clone = "ubn-noble-terra"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 8
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 8192
    name = "Cockpit"

    # cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single"
    bootdisk = "scsi0"

    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    storage = "Fast500G"
                    size = 50
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr2"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=10.0.1.53/24,gw=10.0.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = data.external.env.result.SSH_KEYS
}
