resource "proxmox_vm_qemu" "cloudinit-k8s-master" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "alpha"
    desc = "Cloudinit Ubuntu"
    count = 1
    onboot = true

    # The template name to clone this vm from
    clone = "ubn-noble-temp"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "k3s-master-0${count.index + 1}"

    # cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single"
    bootdisk = "scsi0"

    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        # scsi {
        #     scsi0 {
        #         disk {
        #           storage = "Extra500G"
        #           size = 12
        #         }
        #     }
        # }
    }

    network {
        model = "virtio"
        bridge = "vmbr2"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=10.0.1.81/24,gw=10.0.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCffHb2rxXW8kTY6CLSdPN9h5jsKdVDHesbeoCARCPG61FxXFxG2CZ1ragl20O9dnePEpdaQo3g7vAPBYB6kWQK34eDv+AYzu7jiGYosasr+7pZXNHkE0O9R7YJkvyawkOKa/lBRUGjqHmywvL6Kt/g7lvPdQ/BZ98oTm3G8bKw/TL9V50yu52Ahi2AFdAhDh0tIUKbS9Yaa4PKegKkPV5d+PQmFKLgFApjkDLxTK/xgjkA4IvrhwCqn956gGlccYU5MUB3AZXoSP+uVUv4TBrxXTVMjW9IHsGBe5LrFI9awsKJPH/mdDK1besYE80H6Zp0i1S0MJoMLekcs5YZHV3/vBmzwYAVxARHYdD2KBiRDq2QhfNFVIHfUXPgDxd+Fb5gic5nVrqcqzNdv5yKZBmbx0y/g4iCPs7wikNuwWl7c4elOF3TwgKicMqPkE/i41wSv9TGp6P3iemEt+cWm/gSHy0iR/s5TG1voeyBzPH4abFIvN1/q/K2mt5lKZXqIW73BfpX5XRHXcDNKP1ErwHstGhqkuhjb6FhH3zS1xfQuzSLctyZaV5z0y9YcXVU8tuao2CF5F4kMqG+Dr/2ps5UVc/Tejpqu1p9KLEbVtWIcGB1YmDH5FN7OMM6069CPUsSFBmF/3D1MSBSOQhxuP73CPY8w1Li71GLiS8+vJB4HQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-k8s-worker" {
    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "alpha"
    desc = "Cloudinit Ubuntu"
    count = 1
    onboot = true

    # The template name to clone this vm from
    clone = "ubn-noble-temp"

    # Activate QEMU agent for this VM
    agent = 0

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "k3s-worker-0${count.index + 1}"

    # cloudinit_cdrom_storage = "local-lvm"
    scsihw   = "virtio-scsi-single" 
    bootdisk = "scsi0"

    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = "local-lvm"
                }
            }
        }
        # scsi {
        #     scsi0 {
        #         disk {
        #           storage = "Extra500G"
        #           size = 12
        #         }
        #     }
        # }
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.90${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=10.0.1.91/24,gw=10.0.1.1"
    ciuser = "nhat"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCffHb2rxXW8kTY6CLSdPN9h5jsKdVDHesbeoCARCPG61FxXFxG2CZ1ragl20O9dnePEpdaQo3g7vAPBYB6kWQK34eDv+AYzu7jiGYosasr+7pZXNHkE0O9R7YJkvyawkOKa/lBRUGjqHmywvL6Kt/g7lvPdQ/BZ98oTm3G8bKw/TL9V50yu52Ahi2AFdAhDh0tIUKbS9Yaa4PKegKkPV5d+PQmFKLgFApjkDLxTK/xgjkA4IvrhwCqn956gGlccYU5MUB3AZXoSP+uVUv4TBrxXTVMjW9IHsGBe5LrFI9awsKJPH/mdDK1besYE80H6Zp0i1S0MJoMLekcs5YZHV3/vBmzwYAVxARHYdD2KBiRDq2QhfNFVIHfUXPgDxd+Fb5gic5nVrqcqzNdv5yKZBmbx0y/g4iCPs7wikNuwWl7c4elOF3TwgKicMqPkE/i41wSv9TGp6P3iemEt+cWm/gSHy0iR/s5TG1voeyBzPH4abFIvN1/q/K2mt5lKZXqIW73BfpX5XRHXcDNKP1ErwHstGhqkuhjb6FhH3zS1xfQuzSLctyZaV5z0y9YcXVU8tuao2CF5F4kMqG+Dr/2ps5UVc/Tejpqu1p9KLEbVtWIcGB1YmDH5FN7OMM6069CPUsSFBmF/3D1MSBSOQhxuP73CPY8w1Li71GLiS8+vJB4HQ== katana
    EOF
}