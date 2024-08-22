resource "proxmox_vm_qemu" "cloudinit-Media-server" {
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
    memory = 16384
    name = "Media"

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
                    size = 32
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.40/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Jenkins-server" {
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
    name = "Jenkins"

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
                    size = 25
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.50/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Gitlabs-server" {
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
    memory = 16384
    name = "Gitlab"

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
                    size = 25
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.51/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-K8s-Master" {
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
    cores = 4
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 8192
    name = "K8s-Master-0${count.index + 1}"

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
                    size = 32
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.52/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-K8s-Worker" {
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
    cores = 4
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 8192
    name = "K8s-Worker-0${count.index + 1}"

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
                    size = 32
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.53/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Monitoring-server" {
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
    name = "Monitoring"

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
                    size = 25
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.60/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-MySQL-Database-server" {
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
    cores = 2
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 8192
    name = "MySQL"

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
                    size = 15
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.80/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Reverse_Proxy-Networking-server" {
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
    name = "Nginx-Proxy-Manager"

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
                    size = 20
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.90/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Pi_Hole-Networking-server" {
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
    cores = 2
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 4096
    name = "Pi-hole"

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
                    size = 14
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.91/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Game-server" {
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
    cores = 10
    sockets = 1
    numa = false
    vcpus = 0
    cpu = "host"
    memory = 32768
    name = "Game"

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
                    size = 20
                }
            }
        }
    }

    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    # Setup the ip address using cloud-init.
    # Keep in mind to use the CIDR notation for the ip.
    # ipconfig0 = "ip=10.0.1.80${count.index + 1}/24,gw=10.0.1.1"
    ipconfig0 = "ip=192.168.1.100/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "192.168.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
    EOF
}
