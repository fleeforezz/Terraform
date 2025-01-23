resource "proxmox_vm_qemu" "cloudinit-Kubernetes-Master-1" {
    # Node name has to be the same name as within the cluster
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
    name = "k8s-master-1.local"
    vmid = 117

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
    nameserver = "1.1.1.1"
    sshkeys = <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDF/hVW9QqlMV//ke+RmIFPAv9t144HDE2ygv6vOZJel7GMAfTzwb+iMNW+L92Fph3Ra4dHTIf0c0ToJDCe8PLSDbQtgNr4G/PVXPqdJYQMbULrsY8Nbktl7rkQYotoh8a4wL5yH0Ygvgws3dIJmyEZwDDAaL3sgjFtyD7sKg8etQWTlZfSaLSI/mD7QlzAXLj3LmqpVI3q/3WkhDZhxv096hwtTppuxsy9+xY0XjbP8EUkLUFyIMUEZFRwU+DD2cnFyjAXw0erSPFbP0asVwK6pboYjDwlYTVNq5lLqCAAJFiBajWvJm2EGF5v9U8Qp9/MQLs/cotfOPKvLPy/uPa/NrKTmRAPEEbRbQWdMIUJsj2t0jIz2Xd9FN/ChmnGpsFNSjmVgI6GR4ql/JhiRjTFiIqq6rPceq+MROjmFXQnmDiSyBLamWMf3VojWRHyqYEIl1ZRP4PZU4KI7vCGXt2BZtLYR2CEaP/xj1KwQD5jwjbzzQ10HIkoghCtovlm1730ERrE3AOWaQpgpfk0OI23o0nUUmP+KNjhmNdczelxfK6f+EMrwhJ1MaImjUG93qqfGmvOE0ant6CtAMd59yidBiTHJ6HrNOVWKfG+zy203lWxtuee/svQgzAcpGvz1ZiQHMYWaz4Oms36GmlL36SbPk4bdpt4aTezdSp/Bi0nuQ== katana
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNlOzyhLmxvu5ROcO2Il00SyRHZH5PDu3U/ktN6Sesx8XafZw8UEJ2ZUXW2yojQ94dUi8Tg86eXS0+M6eIYn5Fcn8etCo3ajeg7sXfsG8Spk1UW2sxq0H4eCA8WDrVIQqCeO0jZTkOPA+dToIjqDZGYUg5iQU/fMoqEJ/gKxWuhLpNE4EiI/h9JFW0e+SS3lYkgvEQj6QDTwhdScUKs6l+99HCYHTwwr+nBf7DAthR5Sc7dYWxqYBi5XotfjqaHWCTWetd1QgEzbjP2pkpKvWtttVrKKzc1OsZEzusYWbVy/5XvOeaanriE8vAdhCtMJti0SgpzNrFRYevt+KlkdPLUfwcfKeH7IsKzzOhq49ZBQaWXR3SubL4fZVOk/ab13FwRYbwdw/eXAC21WDrxoMddrXV54CpcmdLtyPCIelL/FipuLTzGKTwLAiWsy+cQSS5UE5aYy4o3hE+ABw0n4JHJmPOX4J8Huw0h+Ff9yWwZm0om9oM12NGzcQ0ewScZf/JTdBrvi3bv3vk2oYCO9hlX11QuTFizKeIIJQWlD8Vkgl/RRQx4eIpUTR5bvuNPW22l084feexlyHqkVZfuJb4yzumr45K19lW17pxSMjkvoOONZOPp5OegH6+ibv45BYVxB9dGE3Y0s1EJm5VH4VzVpKpiGi0tag4JepUWNFUVw== root@prx1
    EOF
}
