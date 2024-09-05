resource "proxmox_vm_qemu" "cloudinit-Cockpit-Management-server" {
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
                    size = 12
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
    ipconfig0 = "ip=192.168.1.32/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Portainer-Management-server" {
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
    name = "Portainer"

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
    ipconfig0 = "ip=192.168.1.35/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Jenkins-Development-server" {
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Gitlab-Development-server" {
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-K8s-Master-Development-Server" {
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-K8s-Worker-Development-Server" {
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
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
                    size = 30
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-Security-server" {
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
    name = "Security"

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
    ipconfig0 = "ip=192.168.1.70/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
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
    cores = 8
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
    ipconfig0 = "ip=192.168.1.80/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-MSSQL-Database-server" {
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
    name = "MSSQL"

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
    ipconfig0 = "ip=192.168.1.81/24,gw=192.168.1.1"
    ciuser = "nhat"
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}

resource "proxmox_vm_qemu" "cloudinit-NginxProxyManager-Networking-server" {
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
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
                    size = 12
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
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
    # nameserver = "10.0.200.11"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCRqF+LBeO2IOM6sdBOFnLWJQFuZnx9LPMIY+RHFFdjadBpwna+ZbpY0C14sOpGKYWZiXw8QJ/CB+JiAgmAI2svFt7UxkOdJPCIOjaINM02LPMnFH13pK8zt5IEyPh98Ih4YdgQYc8LFMDS7G/jNc5/AI9LJeraAUq9Q0ZenB7tinQmrJhPcqqUrz4lH1EEmjJV1yozXVctMFXX4UV0CLDNgnnXsAemErxPkDy9+8r5n2Z2nHl5zEAmfRiEGRDIaZngPRCtBb51aXCEXjzLr22kC3pU9eAFaAycSAMrPGP5Ao9x1ThYZidG+3sf5Dye/59xaHo0rWFAe3Aaq9bZdP0PZTM8hYOz4xKyiikq6aa4U1h4sVvPVj+ay/NKxKQ/R6habFyWjmXFxWpJqyrF4pO1X1XT5QE4mXS+dhN1cT03ryfvObpatOpbwI/8WcjjKUgFMF1srvA4rXnvb9xXJyUikbNdgiiyF6QGgNWc1YNflmNqS3vp0iGFYHRVA2pkmcoZlqSzDXsMXkTUCg+ajTWYCydj4YwElrucvvYEaeAObEW9w2X3YNzxan2/+ctMybkn1UZ8n3pJusfbPFGsFotKVpULAHB5BPS5KZ3fo/N0yGKIpsDXcB/FRANX3oDMhIw7KuyJALYto2vkEacZ8e3fP3as4rf+7m3elZe6zbZ1HQ== Shadow
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}
